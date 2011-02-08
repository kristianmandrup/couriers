# Every Delivery can be sent out as an offer to one or more couriers who will respond to that offer

class Delivery::Offer
  include Mongoid::Document

  field :number,        :type => String
  field :max,           :type => Integer
  field :time_notified, :type => Time
  field :state,         :type => String

  references_one  :accepted_courier,  :class_name => 'Courier'
  embeds_one      :booking,           :class_name => 'Order::Booking'
  embeds_many     :delivery_requests, :class_name => 'Delivery::Request'

  validates :booking, :presence => true

  after_initialize :setup

  include Api

  # conv. methods

  def to_s
    %Q{number: #{number}
      booking:
      #{booking}
      requests:
      #{delivery_requests.map(&:to_s)}
    }
  end

  def set_courier_state courier, new_state
    raise DeliveryTimeOutError, "Your response was too late" if time_out? new_state
    raise DeliveryAlreadyTakenError, "Customer accepted delivery response of another courier" if locked? new_state
    set_state new_state
  end

  def pickup
    booking.pickup
  end

  def dropoff
    booking.dropoff
  end

  def for_couriers couriers
    self.delivery_requests = []
    couriers.each do |courier|
      self.delivery_requests << self.class.create_request(courier)
    end
    self.save
  end

  def with_dropoff
    yield dropoff
  end

  def with_pickup
    yield pickup
  end


  class << self
    def status event
      Rails.logger.error "Unknown offer event: #{event}" and return if !event_msg[event]
      status_msg event, event_msg[event]
    end

    def create_request courier
      Delivery::Request.create_for courier
    end

    def create_for options = {:max => 3}
      delivery_offer = self.new
      delivery_offer.max_couriers = extract_max options      
      delivery_offer.booking = extract_booking options
      delivery_offer.for_couriers extract_couriers options
      delivery_offer
    end
    
    private

    def extract_max_couriers options
      options[:max] || 3
    end

    def event_msg
      {
        :OK => 'You got the delivery',
        :DELIVERY_TIMEOUT => 'You responded after the timeout period',
        :DELIVERY_TAKEN => 'Delivery has already been taken'
      }
    end

    def status_msg code, msg
      {:status => {:code => code.to_s, :message => msg} }
    end
  end

  protected

  def set_state new_state
    self.state = new_state

    delivery_request = delivery_request_for(courier)
    delivery_request.set_state(new_state)

    self.accepted_courier = courier if self.state == 'accepted'
    save
  end

  def locked? new_state
    case new_state.to_sym
    when :accepted
      return  self.state == 'accepted'
    end
    false
  end

  def time_out? new_state
    case new_state.to_sym
    when :accepted
      @time_notified - Time.now > 20.seconds
    end
    false
  end

  def delivery_request_for courier
    delivery_requests.each do |req|
      return req if req.courier.number == courier.number
    end
    nil
  end

  protected

  def counter
    Order::Counter::DeliveryOffer
  end
  
  def setup
    self.state = 'ready'
    self.number = counter.next
  end
end
