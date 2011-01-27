class Delivery
  include Mongoid::Document
  
  embeds_one :waybill, :class_name => 'Order::Waybill'
  embeds_one :location

  embedded_in :courier, :inverse_of => :delivery

  field :number,      :type => Integer
  field :state,       :type => String
  
  validates :state, :delivery_state => true

  after_initialize :set_number

  # API methods

  def for_json    
    # :directions => 'go get it'
    # number
    {:id => "1", :state => state, :travel_mode => travel_mode, :pickup => pickup.for_json, :dropoff => dropoff.for_json}
  end

  def get_state
    {:state => state}
  end

  def get_info
    self
  end

  # convenience methods

  def set_number
    self.number = rand(1000) + 1
  end
  
  def to_s
    %Q{delivery: # #{number}
state: #{state}
location: 
#{location}
waybill: 
#{waybill}
}
  end

  def travel_mode
    'biking'
  end
  
  def pickup
    waybill.pickup
  end

  def dropoff
    waybill.dropoff
  end 
  
  class << self
    include ::AddressHelper
        
    def delivery_states
      [:ready, :accepted, :cancelled, :picked_up, :delivered, :billed]
    end    

    def create_from_booking booking
      delivery = self.new :state => :ready
      delivery.waybill = Order::Waybill.create_from_booking booking
      delivery.location = delivery.pickup.location # initial location of delivery is at pickup
      delivery.timestamp = Time.now
      delivery
    end
        
    def create_random
      delivery = self.new :state => random_delivery_state
      delivery.waybill  = Order::Waybill.create_from :munich
      delivery.location = Location.create_from :munich
      delivery
    end

    def create_from options = {}      
      city = extract_city options

      delivery = self.new :state => random_delivery_state

      delivery.location = Location.create_from_city city
      delivery.waybill  = Order::Waybill.create_from city
      delivery
    end
    
    protected

    def setup
      self.number = rand(100) + 1
    end
    
    def random_delivery_state
      delivery_states.pick_one
    end
  end
end