class Order::Pickup < Order::Place
  include Mongoid::Document
  
  embedded_in :booking, :inverse_of => :pickup  
end