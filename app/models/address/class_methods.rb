class Address
  module ClassMethods  
    include ::OptionExtractor
  
    def country name
      define_method :get_country do
        name
      end
    end

    def cities_available
      [:munich, :berlin]
    end

    def countries_available
      [:usa, :canada, :germany]
    end

    # create localized address based on current geolocation!? 
    def create_from_point point_string
      if !point_string.blank?        
        begin             
          loc = TiramizooApp.geocoder.geocode point_string
          address = create_address loc.address_hash
          address.location = Location.new loc.location_hash
          return address
        rescue GeoMagic::GeoCodeError => gle
          p "Geocode error: #{gle}"
        rescue Exception => e
          p "Locate exception from #{point_string}: #{e}"
          p "geocode location: #{loc.inspect}"
        end
      end 
      create_empty
    end

    def create_empty
      Address::Empty.new
    end

    # city => :munich
    def create_for options = {}
      options = get_options(options)
      city = extract_city options
      case city.to_sym
      when :munich
        create_germany options
      else
        create_canada options
      end
    end

    def create_from city = :munich
      create_from_point "#{random_street city}, #{city}"
    end

    protected

    def random_street city
      streets(city).pick_one
    end
  
    def streets city = :munich
      TiramizooApp.load_streets(city)
    end 
  end
end