class Courier::Vehicle
  include Mongoid::Document

  field :name,  :type => String  
  field :count, :type => Integer, :default => 1

  extend ClassMethods

  def to_s
    count == 1 ? "a #{name.to_s.humanize}" : "#{count} #{name.to_s.pluralize.humanize}"    
  end
    
  # create_car, create_van etc.
  available_types.each do |type|
    class_eval %{
      def #{type}?
        name == #{type}
      end        

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
