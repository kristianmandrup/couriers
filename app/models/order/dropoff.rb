class Order::Dropoff < Order::Place
  include Mongoid::Document
  
  embedded_in :booking, :inverse_of => :dropoff        
end