class Address
  include Mongoid::Document

  field :street,        :type => String
  field :city,          :type => String
  field :country,       :type => String
  field :country_code,  :type => String

  embeds_one  :location

  #  returns the string representing the address / the address
  def to_s
    %Q{#{street}
#{city}
#{country}
}
  end

  def as_string
    [street, city, country].compact.join(', ')
  end

  def locate! point_string = nil
    point_string ||= as_string 
    raise "Address can't be located without a street" if point_string.blank?
    begin             
      loc = TiramizooApp.geocoder.geocode(point_string)
      self.street         = loc.street if loc.street
      self.country        = loc.country if loc.country
      self.country_code   = loc.country_code if loc.country_code
      self.zip            = loc.zip if loc.zip      
      self.location       = Location.new :latitude => loc.latitude, :longitude => loc.longitude
    rescue GeoMagic::GeoCodeError => gle
      p "Geocode error: #{gle}"      
    rescue Exception => e
      p "Locate exception from #{point_string}: #{e}"      
    end
    self
  end

  validates_presence_of :street
  validates_presence_of :city, :country

  class << self 
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

  countries_available.map(&:to_s).each do |country|
    class_eval %{
      def self.create_#{country} *args
        clazz = Address::#{country.to_s.classify}
        address = clazz.new *args
        address.street = clazz.random_street if args.first.delete(:random) || address.street.blank?
        address.locate!        
      end
    }
  end

  protected
  
  def set_country
    self.country = get_country
  end  
end
