# Used by Api::DeliveriesController

class Delivery::State
  include Mongoid::Document

  embeds_one :booking, :class_name => 'Order::Booking'

  def self.courier_got_delivery
    {:status => {:code => "OK", :message => 'You got the delivery'} }
  end

  def self.delivery_already_taken
    {:status => {:code => "DELIVERY_TAKEN", :message => 'Delivery has already been taken'} }
  end

  def self.delivery_timeout
    {:status => {:code => "DELIVERY_TIMEOUT", :message => 'You responded after the timeout period'} }
  end

  # 3,5km to target
  # using google maps directions!?
  def directions   
    "3,5km to target"
  end
end