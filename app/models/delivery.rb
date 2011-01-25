class Delivery
  include Mongoid::Document
  
  embeds_one :waybill, :class_name => 'Order::Waybill'
  embeds_one :location

  embedded_in :courier, :inverse_of => :delivery

  field :number,      :type => Integer
  field :state,       :type => String
  
  validates :state, :delivery_state => true

  def for_json    
    {:id => number, :travel_mode => travel_mode, :directions => 'go get it', :pickup => pickup, :dropoff => dropoff}
  end

  def info
    for_json
  end
  
  def pickup
    waybill.pickup
  end

  def dropoff
    waybill.dropoff
  end 
  
  class << self    
    def delivery_states
      [:ready, :accepted, :cancelled, :arrived_at_pickup, :arrived_at_dropoff, :billed]
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

    def extract_city options = {}
      case options
      when Symbol
        options
      else
        options[:from] || :munich
      end
    end

    def setup
      self.number = rand(100) + 1
    end
    
    def random_delivery_state
      delivery_states.pick_one
    end
  end
end