# Every Delivery can be sent out as an offer to one or more couriers who will respond to that offer

class Delivery::Offer
  include Mongoid::Document

  field :number, :type => String

  embeds_one  :booking, :class_name => 'Order::Booking'
  embeds_many :delivery_requests, :class_name => 'Delivery::Request'  

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

  def set_state state, courier
    puts "set_state of offer: #{state}, for courier nr: #{courier.number}"
    delivery_requests.each do |req|
      puts "!!!! Request nr = #{req.courier.number}"
      if req.courier.number == courier.number
        puts "!!! FOUND request to answer"
        puts "Tries to set state! (will now do lock and timeout checks)"
        req.set_state(state)
        req.save! 
      end
    end
  end

  def pickup
    booking.pickup
  end

  def dropoff
    booking.dropoff
  end

  def for_couriers couriers
    puts "for couriers: #{couriers.size}"
    couriers.each do |courier| 
      "Adding delivery request for: #{courier.number}"
      self.delivery_requests << self.class.create_request(courier)
    end 
    puts "Request added: #{delivery_requests.size}"
    self.save
  end
  
  class << self
    def status event
      Rails.logger.error "Unknown offer event: #{event}" and return if !event_msg[event]
      status_msg event, event_msg[event]
    end
    
    def create_request courier
      Delivery::Request.create_for courier
    end

    def create_from city = :munich 
      create_from_booking Order::Booking.create_from city
    end
    
    def create_from_booking booking
      delivery_offer = self.new
      delivery_offer.booking = booking
      delivery_offer
    end

    def create_for booking, couriers
      delivery_offer = create_from_booking booking
      delivery_offer.for_couriers couriers
      delivery_offer      
    end

    def create_for_couriers_only couriers
      delivery_offer = Delivery::Offer.create_from :munich
      delivery_offer.for_couriers couriers
      delivery_offer      
    end
    
    private

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
  
  def setup
    self.number = rand(100) + 1
  end
end