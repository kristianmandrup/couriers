require 'customer/order/booking_ext/api'
require 'customer/order/booking_ext/class_methods'

class Customer
  module Order
    class Booking    
      include Mongoid::Document

      field       :number,              :type => String
      field       :description,         :type => String

      embeds_one  :pickup,              :class_name => 'Order::Pickup'
      embeds_one  :dropoff,             :class_name => 'Order::Dropoff'

      embedded_in :waybill,             :inverse_of => :booking
      embedded_in :delivery_state,      :inverse_of => :booking

      field       :selected_couriers,   :type => Array

      after_initialize :setup

      extend  Customer::Order::BookingExt::ClassMethods
      include Customer::Order::BookingExt::Api

      def to_s
    %Q{#{number}
desc: #{description}
pickup: #{pickup}
dropoff: #{dropoff}
}
      end

      def selected_couriers= courier_ids
        value = courier_ids.reject{|i| i.blank?}.map(&:to_i)
        write_attribute(:selected_couriers, value)
      end

      # get by number
      scope :by_number, lambda { |number| where(:number => number) }
  
      accepts_nested_attributes_for :pickup,  :allow_destroy => true
      accepts_nested_attributes_for :dropoff, :allow_destroy => true

      protected

      def counter
        ::Order::Counter::Booking
      end
  
      def setup
        self.number = counter.next
      end
    end
  end
end