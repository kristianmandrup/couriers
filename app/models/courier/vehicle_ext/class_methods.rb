class Courier
  module VehicleExt
    module ClassMethods        
      def create_one name
        raise ArgumentError, "Not a valid vehicle type - must be one of #{available_types}" if !available_types.include? name
        Courier::Vehicle.new :name => name.to_s, :count => 1
      end    

      def create number, name
        raise ArgumentError, "Not a valid vehicle type - must be one of #{available_types}" if !available_types.include? name
        Courier::Vehicle.new :name => name.to_s, :count => number
      end    
  
      def random_vehicle
        available_types.pick_one
      end   
  
      def travel_mode_of vehicle_type
        return 'biking' if biking_modes.include? vehicle_type.to_s.downcase
        'driving'
      end      

      def biking_modes
        ['bike', 'bicycle', 'cargobike']
      end
  
      def travel_modes
        [:biking, :driving]
      end
    end
  end
end