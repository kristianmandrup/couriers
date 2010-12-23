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

  protected
  
  def set_country
    self.country = get_country
  end  
end
