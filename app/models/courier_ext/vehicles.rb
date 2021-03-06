module CourierExt
  module Vehicles
    def travel_mode
      Courier::Vehicle.travel_mode_of current_vehicle
    end

    def self.included(base)
      Courier::Vehicle.available_types.each do |type|
        base.class_eval %{
          def bikes= num
            new_bikes = Vehicle.create_bikes num
            bikes? ? bikes.count = new_bikes.count : vehicles << new_bikes
          end
    
          def bikes?
            vehicles.any?{| v| v.#{type}? #{type} }
          end
    
          def bikes
            vehicles.select{| v| v.#{type}? #{type} }.first
          end
        }
      end
    end
  end
end