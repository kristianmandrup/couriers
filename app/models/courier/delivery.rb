class Courier::Delivery
  include Mongoid::Document
  
  embeds_one :waybill  

  field :delivery_state, :type => String
  
  validates :delivery_state, :delivery_state => true
  
  class << self
    def delivery_states
      [:ready, :accepted, :cancelled, :arrived_at_pickup, :arrived_at_dropoff, :billed]
    end    
        
    def create_random
      delivery = self.new :delivery_state => random_delivery_state
      delivery.booking = Order::Booking.create_from :munich
      delivery
    end

    def create_from booking, state = :ready
      delivery = self.new :delivery_state => state
      delivery.booking = booking
      delivery
    end
    
    protected
    
    def random_delivery_state
      delivery_states[random_index]
    end

    def random_index 
      rand(delivery_states.size)
    end    
  end
end