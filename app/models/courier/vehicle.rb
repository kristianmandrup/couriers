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
