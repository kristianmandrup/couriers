class Order::Booking
  include Mongoid::Document

  field       :number,              :type => String
  field       :description,         :type => String

  embeds_one  :pickup,              :class_name => 'Order::Pickup'
  embeds_one  :dropoff,             :class_name => 'Order::Dropoff'

  embedded_in :waybill,         :inverse_of => :booking
  embedded_in :delivery_state,  :inverse_of => :booking

  after_initialize :setup
  
  def for_json
    {:pop => pickup.for_json, :pod => dropoff.for_json, :description => description }
  end

  def to_s
    %Q{#{number}
desc: #{package_description}
pickup: #{pickup}
dropoff: #{dropoff}
}
  end

  class << self
    include ::OptionExtractor
    
    def create_empty options = {}
      booking = self.new options

      # booking.description = extract_desc options

      booking.pickup  = Order::Pickup.new
      booking.dropoff = Order::Dropoff.new

      booking
    end

    def create_for options = {}
      booking = self.new
      booking.description = extract_desc options
      booking.pickup      = extract_pickup options
      booking.dropoff     = extract_dropoff options
      booking
    end
  end
  
  accepts_nested_attributes_for :pickup,  :allow_destroy => true
  accepts_nested_attributes_for :dropoff, :allow_destroy => true

  protected

  def counter
    Order::Counter::Booking
  end
  
  def setup
    self.number = counter.next
  end
end
