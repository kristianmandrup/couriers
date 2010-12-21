class Vehicle
  include Mongoid::Document

  field :name,  :type => String  
  field :count, :type => Integer
end
