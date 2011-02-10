class Order
  class Dropoff < Place
    include Mongoid::Document  
    embedded_in :booking, :inverse_of => :dropoff  
  end
end