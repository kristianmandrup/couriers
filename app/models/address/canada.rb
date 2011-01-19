class Address::Canada < Address
  include Mongoid::Document

  # N.America
  field :zip_code,        :type => String

  # Canada
  field :province,        :type => String
    
  validates_length_of       :zip_code,    :within => 6..6
  validates_numericality_of :zip_code,    :greater_than_or_equal_to => 1, :less_than => 999999

  validates_presence_of     :zip_code,    :province
  
  before_validation :set_country #, :request_state_and_city_validation_based_on_zipcode

  def to_s
      %Q{#{street}
#{zip_code} #{city}
#{state}
#{country}
}
  end
      
  private 

  country 'Canada'
                
  # http://www.funonrails.com/2010/08/zipcode-validation-using-geokit-in.html  
    
  def request_state_and_city_validation_based_on_zipcode 
    # Actual requesting api to return locationation associated with zipcode 
    if !(%w{zipcode state city}.all? {|attr| self.send :"#{attr}_changed?" } )
      location = MultiGeocoder.geocode("#{self.zip_code}, #{COUNTRY}") 
    end 
    # Add Validation Error if locationation is not found 
    unless location.success 
      errors.add(:zip_code, "Unable to geocode your locationation from zip code entered.") 
    else 
      # Validate state and city fields in compare to location object returned by geocode 
      errors.add(:province, "Province doesn't matches with zip code entered") if self.province != location.province 
      errors.add(:city, "City doesn't matches with zip code entered") if self.city != location.city 
    end 
  end     
end
