class Address::Germany < Address
  include Mongoid::Document
  
  # Germany (Europe)
  field :postnr,    :type => String
  
  before_validation :set_country #, :request_state_and_city_validation_based_on_zipcode

  validates_presence_of     :postnr   

  validates_length_of       :postnr,    :within => 5..5
  validates_numericality_of :postnr,    :greater_than_or_equal_to => 1, :less_than => 999999

  def to_s
    %Q{#{street}
#{postnr_city}
#{country}
}
  end
  
  def postnr_city
    return "#{postnr} #{city}" if !postnr.blank?
    city
  end

  def zip
    self.postnr
  end

  def zip= value
    self.postnr = value
  end

  def postal_code= value
    self.postnr = value
  end
      
  private 

  country 'Germany'
              
  # http://www.funonrails.com/2010/08/zipcode-validation-using-geokit-in.html  
    
  def request_state_and_city_validation_based_on_zipcode 
    # Actual requesting api to return location associated with zipcode 
    if !(%w{postnr city}.all? {|attr| self.send :"#{attr}_changed?" } )
      location = MultiGeocoder.geocode("#{self.postnr}, #{COUNTRY}") 
    end 
    # Add Validation Error if location is not found 
    unless location.success 
      errors.add(:postnr, "Unable to geocode your location from postnr entered.") 
    else 
      # Validate city fields compared to loc object returned by geocode 
      errors.add(:city, "City doesn't matches with postnr entered") if self.city != location.city
    end 
  end
  
end