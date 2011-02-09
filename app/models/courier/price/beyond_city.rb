class Courier::Price::BeyondZipCodes
  include Mongoid::Document
  
  field :price,       :type => Float   # price per kilometer beyond km_point
  field :zip_codes,   :type => Array  # from this time, the extra price is effective
  
  def initialize price, zip_codes
    self.time_limit = time_limit
    self.zip_codes = zip_codes    
  end
end
