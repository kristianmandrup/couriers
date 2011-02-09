class Courier::PriceStructure
  include Mongoid::Document

  field :base_price,        :type => Float # price up to km_point
  field :assistance_price,  :type => Float # Ladehilfe  
  field :currency,          :type => String

  embeds_one :beyond_distance,         :class_name => 'Courier::Price::BeyondDistance'
  embeds_one :beyond_time,             :class_name => 'Courier::Price::BeyondTime'
  embeds_one :beyond_zip_codes,        :class_name => 'Courier::Price::BeyondZipCodes'  
  embeds_one :beyond_hours,   :class_name => 'Courier::Price::BeyondHours'  


  # validates :currency,      :presence => true, :currency => true
end
