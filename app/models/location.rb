class Location
  include Mongoid::Document
  
  # attr_accessor :address, 
  field :latitude, :type => String
  field :longitude, :type => String

  def move dlat, dlong
    self.latitude = (lat + dlat.to_f).to_s
    self.longitude = (lng + dlong.to_f).to_s
    self    
  end

  def lat
    latitude.to_f.round(6)
  end

  def lng
    longitude.to_f.round(6)    
  end

  def to_s mode = :short
    return "#{lat}, #{lng}" if mode == :short
    "latitude: #{lat}, longitude: #{lng}"
  end
  
  class << self

    # from GeoMagic location
    def create_from geo_location
      self.new :latitude => geo_location.latitude, :longitude => geo_location.longitude
    end

    # YAML.load_file("#{Rails.root}/config/available_cities.#{locale}.yml")
    def available_cities
      @available_cities ||= t 'cities.germany'
    end

    def from_ip session
    end
  end 
  
end
