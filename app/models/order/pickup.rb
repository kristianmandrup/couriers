class Order
  class Pickup < Place
    include Mongoid::Document  
    embedded_in :booking, :inverse_of => :pickup  
  end
end