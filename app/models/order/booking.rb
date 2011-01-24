class Order::Booking
  include Mongoid::Document

  embeds_one  :pickup,              :class_name => 'Order::Pickup'  
  embeds_one  :dropoff,             :class_name => 'Order::Dropoff'  

  field       :number,  :type => String
  field       :package_description, :type => String

  embedded_in :waybill,         :inverse_of => :booking
  embedded_in :delivery_state,  :inverse_of => :booking  
  
  def for_json
    {:pickup => pickup.for_json, :dropoff => dropoff.for_json, :package_description => package_description }
  end

  def into_json
    for_json.to_json
  end

  def to_s
    %Q{#{number}
desc: #{package_description}
pickup: #{pickup}
dropoff: #{dropoff}
}
  end

  class << self
    def create_empty_from city = :munich
      booking = self.new
      booking.package_description = random_desc
      booking.pickup  = Order::Pickup.new
      booking.dropoff = Order::Dropoff.new
      booking
    end

    def create_from city = :munich
      booking = self.new
      booking.pickup  = Order::Pickup.create_from city
      booking.dropoff = Order::Dropoff.create_from city
      booking
    end
    
    def random_desc
      descriptions.pick_one      
    end
    
    def descriptions
      ["Big box", "Small box", "Large cylinder", "Heavy box", "Box with wineglasses - be careful!"]
    end
  end
  
  accepts_nested_attributes_for :pickup,  :allow_destroy => true
  accepts_nested_attributes_for :dropoff, :allow_destroy => true
end
