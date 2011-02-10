class Order::Quote
  include Mongoid::Document
    
  field :pickup_point,    :type => String
  field :dropoff_point,   :type => String
  field :vehicle,         :type => String

  def to_s
    %Q{
from: #{contact}
to: #{address}
vehicle: #{vehicle}
}
  end
    
  module Api
    def for_json
      {:pickup_point => pickup_point, :dropoff_point => dropoff_point}
    end
  end
  include Api  
end  
  