module TiramizooApp  
  class << self
    def pubsub
      TiramizooApp::PubSub
    end
    
    def geocoder
      GeoMagic.geo_coder(:env => :rails).instance
    end   
              
    def env 
      ENV['HEROKU_SITE'] || Rails.env.downcase || 'development'
    end

    def load_streets city
      country_code = country_code_of(city)
      city = city.to_s

      @streets ||= {}    
      @streets[city] ||= YAML.load_file("#{Rails.root}/config/addresses.#{country_code}.yml")[country_code][city.to_s]
    end    
  
    # Move away!
    def country_code_of city = :munich
      COUNTRY_CODES[city]
    end      
  
    COUNTRY_CODES = {
      :munich     => :de,
      :vancouver  => :ca
    }  
  end
end
  