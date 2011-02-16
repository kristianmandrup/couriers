require 'order/waybill_ext/counter'
require 'order/waybill_ext/api'
require 'order/waybill_ext/class_methods'

class Order
  class Waybill
    include Mongoid::Document

    field       :ticket_nr,     :type => Integer    
    embeds_one  :booking,       :class_name => 'Customer::Order::Booking'
    embedded_in :order,         :class_name => 'Order',         :inverse_of => :waybill

    include Order::WaybillExt::Api
    extend  Order::WaybillExt::ClassMethods

    proxy_accessors_for :booking, [:pickup, :dropoff]    
  
    def to_s
    %Q{
ticket #: #{ticket_nr}
booking: #{booking}
}
    end
  
    protected

    def counter
      Order::Waybill::Counter.instance
    end
  
    def setup
      self.ticket_nr = counter.next_ticket_nr
    end  
  end
end