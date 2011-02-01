module TiramizooApp  
  class << self
    def pubsub
      TiramizooApp::PubSub
    end
    
    def geocoder
      geocoder_context.instance
    end   

    def geocoder_context
      @geocoder_context ||= GeoMagic.geo_coder(:env => :rails).configure
    end   

    def google_key
      geocoder_context.google_key
    end
              
    def load_streets city
      country_code = country_code_of(city)
      city = city.to_s
      
      @streets ||= {}
      @streets[city] ||= begin
        yml = YAML.load_file("#{Rails.root}/config/addresses.#{country_code}.yml")
        yml[country_code.to_s][city.to_s]
      rescue
        puts "No key found for city: #{city} in addresses.#{country_code}.yml"
        []
      end
    end    
  
    # Move away!
    def country_code_of city = :munich
      COUNTRY_CODES[city.to_s.downcase.to_sym]
    end      
  
    COUNTRY_CODES = {
      :munich     => :de,
      :vancouver  => :ca
    }  
  end
end
