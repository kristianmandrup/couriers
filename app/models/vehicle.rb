class Vehicle
  include Mongoid::Document

  field :name,  :type => String  
  field :count, :type => Integer, :default => 1
  
  class << self    
    def available_types
      [:bicycle, :motorbike, :car, :van]
    end
    
    def create_single name
      Vehicle.new :name => name.to_s, :count => 1
    end
    
    # def types
    #   available_types.inject([]) do |res, type|
    #     type = type.to_s
    #     res << [type, type]
    #     res
    #   end
    # end
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
