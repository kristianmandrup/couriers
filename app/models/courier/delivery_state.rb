# Used by Api::DeliveriesController

class Courier::DeliveryState
  include Mongoid::Document

  embeds_one :booking, :class_name => 'Order::Booking'

  # 3,5km to target
  # using google maps directions!?
  def directions   
    "3,5km to target"
  end
end