class Order::Quote
  include Mongoid::Document
    
  field :pickup_point,    :type => String
  field :dropoff_point,   :type => String
  field :vehicle,         :type => String
  
  def for_json
    {:pickup_point => ticket_nr.for_json, :dropoff_point => dropoff_point.for_json}
  end

  def into_json
    for_json.to_json
  end  
end  
  