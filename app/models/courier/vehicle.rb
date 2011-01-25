class Courier::Vehicle
  include Mongoid::Document

  field :name,  :type => String  
  field :count, :type => Integer, :default => 1
  
  class << self    
    def available_types
      [:bike, :cargobike, :motorbike, :car, :van]
    end
    
    def create_single name
      raise ArgumentError, "Not a valid vehicle type - must be one of #{available_types}" if !available_types.include? name
      Vehicle.new :name => name.to_s, :count => 1
    end    
    
    def random_vehicle
      available_types.pick_one
    end   
    
    def travel_mode_of vehicle_type
      return 'biking' if biking_modes.include? vehicle_type.to_s.downcase
      'driving'
    end      

    def biking_modes
      ['bike', 'bicycle']
    end
    
    def travel_modes
      [:biking, :driving]
    end
  end
  
  # create_car, create_van etc.
  available_types.each do |type|
    class_eval %{
      def create_#{type}
        create_single :#{type}
      end        
    }
  end  
end
