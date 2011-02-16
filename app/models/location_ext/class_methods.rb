module LocationExt
  module ClassMethods
    include ::OptionExtractor

    def create_from_params params 
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

    def create_for options = {}
      city = extract_city options
      street = streets(city).pick_one      
      loc = TiramizooApp.geocoder.geocode "#{street}, #{city}"
      create_from_location loc.location_hash
    end

    protected

    def streets city = :munich
      TiramizooApp.load_streets(city)
    end
  end
end