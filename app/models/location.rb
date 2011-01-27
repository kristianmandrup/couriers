class Location
  include Mongoid::Document
  
  # attr_accessor :address, 
  field :latitude, :type => Float
  field :longitude, :type => Float

  def move dlat, dlong
    self.latitude = (lat + dlat.to_f).to_s
    self.longitude = (lng + dlong.to_f).to_s
    self    
  end

  def for_json
    {:latitude => latitude, :longitude => longitude }
  end

  def lat
    latitude.to_f.round(6)
  end

  def lng
    longitude.to_f.round(6)    
  end

  def to_point
    GeoMagic::Point.new(lat, lng)
  end

  def nearby_couriers couriers, options = {:radius => 5.km}
    courier_locations = couriers.map {|c| c.location.to_point}.as_locations
    courier_locations.get_within options[:radius], :from => self.to_point
  end

  def to_s mode = :short
    return "#{lat}, #{lng}" if mode == :short
    "latitude: #{lat}, longitude: #{lng}"
  end
  
  class << self

    def create_from_params params 
      puts "create_from_params: #{params.inspect}"
      self.new :latitude => params[:latitude].to_f, :longitude => params[:longitude].to_f
    end

    # from GeoMagic location
    def create_from arg
      return create_from_location(arg) if arg.respond_to? :latitude
      return create_from_city if arg.kind_of_label?
      raise ArgumentError, "#create_from argument must be a location or city label: #{arg}"
    end

    def create_from_location loc
      attributes = case loc
      when Hash
        loc
      else
        {:latitude => loc.latitude, :longitude => loc.longitude}
      end        
      self.new attributes
    end

    def create_from_city city = :munich
      street = streets(city).pick_one      
      loc = TiramizooApp.geocoder.geocode "#{street}, #{city}"
      create_from_location loc.location_hash
    end
    
    def streets city = :munich
      TiramizooApp.load_streets(city)
    end 

    # YAML.load_file("#{Rails.root}/config/available_cities.#{locale}.yml")
    def available_cities
      @available_cities ||= t 'cities.germany'
    end
  end 
  
end
