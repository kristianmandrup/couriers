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
      @streets[city] ||= begin
        puts "load streets for city: #{country_code.inspect} #{city.inspect}"
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
  