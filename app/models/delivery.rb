class Delivery
  include Mongoid::Document
  
  embeds_one :waybill,  :class_name => 'Order::Waybill'
  embeds_one :location

  references_one  :courier,  :class_name => 'Courier'

  field :number,      :type => Integer
  field :state,       :type => String
  
  validates :state, :delivery_state => true

  after_initialize :set_number
  
  include Api
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
    courier.travel_mode
  end
  
  def pickup
    waybill.pickup
  end

  def dropoff
    waybill.dropoff
  end 

  def with_dropoff
    yield dropoff
  end

  def with_pickup
    yield pickup
  end
  
  class << self
    include ::OptionExtractor
        
    def valid_states
      [:accepted, :cancelled, :picked_up, :delivered, :billed]
    end    

    def create_from offer
      delivery = create_empty
      delivery.state    = :accepted
      delivery.location = offer.location
      delivery.waybill  = Order::Waybill.create_for :booking => offer.booking
      delivery.courier  = offer.accepted_courier
      delivery.save
      delivery
    end

    def create_empty
      self.new
    end
        
    def create_for options = {}
      delivery = self.new
      delivery.state    = extract_delivery_state(options)
      delivery.location = extract_location(options)
      delivery.waybill  = extract_waybill(options)      
      delivery
    end
    
  end

  protected

  def counter
    Order::Counter::Delivery
  end
  
  def setup
    self.number = counter.next
  end  
end