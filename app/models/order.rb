class Order
  include Mongoid::Document
  
  embeds_one :waybill,        :class_name => 'Order::Waybill'
  embeds_one :location
  embeds_one :offer,          :class_name => 'Order::Offer'

  references_one  :courier,   :class_name => 'Courier'

  field :number,      :type => Integer
  field :state,       :type => String
  
  validates :state, :delivery_state => true

  after_initialize :setup
  
  include Api
  # convenience methods
  
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
  
  extend Order::ClassMethods
  
  protected

  def counter
    Order::Counter
  end
  
  def setup
    self.number = counter.next
  end  
end