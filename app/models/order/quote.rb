class Order::Quote
  include Mongoid::Document
    
  field :pickup_point,    :type => String
  field :dropoff_point,   :type => String
  field :vehicle,         :type => String
end  
  