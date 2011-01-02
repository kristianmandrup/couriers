class Address
  include Mongoid::Document

  field :street,    :type => String
  field :city,      :type => String
  field :country,   :type => String
  
  validates_presence_of :street, :city, :country

  def self.country name
    define_method :get_country do
      name
    end
  end

  class << self
    def create_from_point point
      Address.new :street => extract_street(point), :city => extract_city(point), :zip => extract_zip(point)
    end

    # Use Geolocation service here!!!

    def extract_street address
      'Müllerstrasse 34'
    end

    def extract_zip address
      '80469'
    end

    def extract_city address
      'Munich'
    end
  end

  protected
  
  def set_country
    self.country = get_country
  end  
end
