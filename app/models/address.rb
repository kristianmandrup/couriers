class Address
  include Mongoid::Document

  field :street,    :type => String
  field :city,      :type => String
  field :country,   :type => String

  embeds_one  :location

  def for_json
    {:street => street, :city => city, :country => country}
  end

  #  returns the string representing the address / the address
  def to_s
    %Q{#{street}
#{city}      
#{country}
}
  end

  def as_string
    "#{street}, #{city}, #{country}"
  end

  def locate! point_string = nil
    raise "Address can't be located without a street" if street.blank?
    begin             
      loc = TiramizooApp.geocoder.geocode as_string 
      self.location = Location.new :latitude => loc.latitude, :longitude => loc.longitude
    rescue Exception => e
      p "Locate exception from #{as_string}: #{e}"
      p "geocoder: #{GeoMap.geo_coder.instance}"
    end
    self
  end
  
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
      if !point_string.blank?        
        begin             
          loc = TiramizooApp.geocoder.geocode as_string
          address = create_address loc.country_code, loc.address_hash
          address.location = Location.new loc.location_hash
          return address
        rescue Exception => e
          p "Locate exception from #{as_string}: #{e}"
          p "geocoder: #{GeoMap.geo_coder.instance}"
        end
      end 
      create_empty
    end

    def create_empty
      Address::Empty.new
    end

    def create_address country = :de, address_options = {}
      case country.to_s.downcase.to_sym 
      when :de 
        create_germany address_options
      else
        create_canada address_options
      end
    end

    def create_from city = :munich
      address = create_address country_code[city], :street => streets[city].pick_one , :city => city
      address.locate!
    end

    protected
    
    def streets city = :munich
      {
        :munich     => ['Mullerstrasse 43', 'Rosenheimerstrasse 108', 'Marienplatz 14', 'Karlzplatz 32'],
        :vancouver  => ['Bladestreet 18', 'Grand plaza 35', 'Jenny street 23', 'Sidewalk 100']
      }
    end 

    def countries city = :munich
      {
        :munich     => 'Germany',
        :vancouver  => 'Canada'
      }
    end

    def country_codes city = :munich
      {
        :munich     => :de,
        :vancouver  => :ca
      }
    end    
  end

  countries_available.map(&:to_s).each do |country|
    class_eval %{
      def self.create_#{country} *args
        p "create_germany called with \#{args.inspect}"
        Address::#{country.to_s.classify}.new *args
      end
    }
  end


  protected
  
  def set_country
    self.country = get_country
  end  
end
