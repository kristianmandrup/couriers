class Order
  class Booking    
    include Mongoid::Document

    field       :number,              :type => String
    field       :description,         :type => String

    embeds_one  :pickup,              :class_name => 'Order::Place::Pickup'
    embeds_one  :dropoff,             :class_name => 'Order::Place::Dropoff'

    embedded_in :waybill,             :inverse_of => :booking
    embedded_in :delivery_state,      :inverse_of => :booking

    field       :selected_couriers,   :type => Array

    after_initialize :setup

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

    extend ClassMethods
  
    accepts_nested_attributes_for :pickup,  :allow_destroy => true
    accepts_nested_attributes_for :dropoff, :allow_destroy => true

    # module Api
    #   def for_json
    #     {:pop => pickup.for_json, :pod => dropoff.for_json, :description => description }
    #   end
    # end
    # include Api

    protected

    def counter
      Order::Counter::Booking
    end
  
    def setup
      self.number = counter.next
    end
  end
end