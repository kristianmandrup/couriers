class Order::Quote
  include Mongoid::Document
    
  field :pickup_point,    :type => String
  field :dropoff_point,   :type => String
  field :vehicle,         :type => String
  
  def for_json
    {:pickup_point => ticket_nr.for_json, :dropoff_point => dropoff_point.for_json}
  end

  def into_json
    for_json.to_json
  end  

  def to_s
    %Q{
from: #{contact}
to: #{address}
vehicle: #{vehicle}
}
  end
  
  class << self
    def create_from city = :munich      
      pickup_point  = random_point city 
      dropoff_point = random_point city
      vehicle = Courier::Vehicle.random_vehicle.to_s
    end

    def random_point city
      "#{random_street(city)}, #{city}"
    end

    def random_street city
      street = streets(city).pick_one      
    end
        
    def streets city = :munich
      TiramizooApp.load_streets(city)
    end     
  end
end  
  