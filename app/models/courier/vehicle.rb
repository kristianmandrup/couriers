class Courier::Vehicle
  include Mongoid::Document

  field :name,  :type => String  
  field :count, :type => Integer, :default => 1

  def to_s
    count == 1 ? "a #{name.to_s.humanize}" : "#{count} #{name.to_s.pluralize.humanize}"    
  end
  
  class << self
    class << self
      def max_weight_kg type
      end

      def max_dimensions_cm type
      end

      def max_km type
      end
    end    
        
    def available_types
      [:bike, :cargobike, :motorbike, :car, :van]
    end
    
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
  
  # create_car, create_van etc.
  available_types.each do |type|
    class_eval %{
      def self.create_#{type}
        create_one :#{type}
      end        
    }
  end  

  # create_car, create_van etc.
  available_types.each do |type|
    class_eval %{
      def self.create_#{type.to_s.pluralize} number
        create number, :#{type}
      end        
    }
  end  
end
