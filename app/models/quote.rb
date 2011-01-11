class Quote
  include Mongoid::Document
    
  # embeds_one :pickup_address,   :class => 'Address'
  # embeds_one :dropoff_address,  :class => 'Address'

  field :pickup_point,   :type => String
  field :dropoff_point,  :type => String

  field :vehicles,  :type => String

  # embeds_one :vehicle  
  # embeds_one :vehicle
end  
  