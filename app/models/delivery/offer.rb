# Every Delivery can be sent out as an offer to one or more couriers who will respond to that offer

class Delivery::Offer
  include Mongoid::Document

  field :number, :type => String

  embeds_one  :booking, :class_name => 'Order::Booking'
  embeds_many :delivery_requests, :class_name => 'Courier::DeliveryRequest'  

  after_initialize :setup

  def to_s
    %Q{number: #{number}
booking: 
#{booking}

requests: 
#{delivery_requests}
}
  end

  def pickup
    booking.pickup
  end

  def dropoff
    booking.dropoff
  end

  def for_json    
    {:id => number, :directions => 'go get it', :pickup => pickup.without_contact , :dropoff => dropoff.without_contact }
  end

  def for_couriers couriers
    couriers.each do |courier|
      self.delivery_requests << self.class.create_request(courier)
    end 
  end
  
  class << self
    def create_request courier
      Courier::DeliveryRequest.create_for courier
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
  end

  protected
  
  def setup
    self.number = rand(100) + 1
  end
end