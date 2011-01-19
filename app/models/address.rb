class Address
  include Mongoid::Document

  field :street,    :type => String
  field :city,      :type => String
  field :country,   :type => String

  embeds_one  :location

  def for_json
    {:street => street, :city => city, :country => country}
  end

  def lat
    location.latitude if location
  end
  
  def lng
    location.longitude if location
  end

  #  returns the string representing the address / the address
  def to_s
    %Q{#{street}
#{city}      
#{country}
}
  end
  
  # static_map_of_addresses(addresses)
    
  
  validates_presence_of :street, :city, :country

  class << self
    def country name
      define_method :get_country do
        name
      end
    end

    def countries_available
      [:usa, :canada, :germany]
    end

    # create localized address based on current geolocation!? 
    def create_from_point point_string  
      p "point_string: #{point_string.inspect}"          
      if !point_string.blank?
        begin 
          puts "try get location from string"
          location = GeoMap.geo_coder.locate point_string
          p "location: #{location.inspect}"
          pcountry = location ? location.country : 'Germany' # GeoMagic::Remote.my_location.country
          puts "country: #{pcountry}"          
          address_options = location ? {:street => location.street, :city => location.city, :zip => location.zip, :country => pcountry} : {}
          adr = create_address pcountry, address_options
          adr.location = Location.new :lat => location.latitude, :long => location.longitude
          p "adr: #{adr}"
          return adr
          p "why not returned? "
        rescue Exception => e
          p "Exception: #{e}"
        end
        p "did not return!?"
      end 
      p "return empty adr"
      create_empty
    end

    def create_empty
      Address::Empty.new
    end

    def create_address country = :de, address_options = {}
      p "create_address: #{address_options.inspect}"
      p "country code: #{country.to_s.downcase.to_sym.inspect}"
      case country.to_s.downcase.to_sym 
      when :de 
        p "german"
        create_germany address_options
      else
        p "canadian"        
        create_canada address_options
      end
    end

    # Use Geolocation service here!!!

    def streets city= :munich
      {
        :munich     => ['Mullerstrasse 43', 'Rosenheimerstrasse 108', 'Marienplatz 14', 'Kalzplatz 32'],
        :vancouver  => ['Bladestreet 18', 'Grand plaza 35', 'Jenny street 23', 'Sidewalk 100']
      }
    end 

    def countries city= :munich
      {
        :munich     => 'Germany',
        :vancouver  => 'Canada'
      }
    end

    def create_from city = :munich
      Address.new :street => streets[city].pick_one , :city => city, :country => countries[city]
    end

    def extract_street address
      'Mullerstrasse 34'
    end

    def extract_zip address
      '80469'
    end

    def extract_city address
      'Munich'
    end    
  end

  countries_available.map(&:to_s).each do |country|
    class_eval %{
      def self.create_#{country} *args
        p "create_germany called with \#{args.inspect}"
        Address::#{country.classify}.new *args
      end
    }
  end


  protected
  
  def set_country
    self.country = get_country
  end  
end
