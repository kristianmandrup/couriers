require 'order/api'
require 'order/class_methods'
require 'order/proxies'

class Order
  include Mongoid::Document
  
  embeds_one :waybill,        :class_name => 'Order::Waybill'
  embeds_one :location
  embeds_one :offer,          :class_name => 'Order::Offer'

  references_one  :courier,   :class_name => 'Courier'

  field :number,      :type => Integer
  field :state,       :type => String
  
  validates :state, :order_state => true

  after_initialize :setup
  
  include Api
  include Proxies
  extend ClassMethods
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
  
  protected

  def counter
    Order::Counter
  end
  
  def setup
    self.number = counter.next
  end  
end