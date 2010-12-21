class PriceStructure
  include Mongoid::Document

  field :max_weight_kg,         :type => Float
  field :max_dimensions_cm,     :type => String

  field :base_price,            :type => Float # price up to km_point

  field :km_price,              :type => Float # price per kilometer beyond km_point
  field :km_point,              :type => String # from this distance, the km_price is effective

  field :cost_per_stop,         :type => Float 
  field :waiting_time,          :type => Float # every 5 min?
  field :unsuccessful_delivery, :type => Float # pickup or delivery could not be made

  field :currency,              :type => String
  
  embedded_in :service_provider, :inverse_of => :price_structure
end
