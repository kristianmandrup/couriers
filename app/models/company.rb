class Company
  include Mongoid::Document

  field :name, :type => String
  
  embeds_one :address
  embeds_one :contact
  embeds_one :profile

  embeds_one :channel, :class_name => 'Contact::Channel'

  def for_json
    {:name => name, :address => address.for_json, :contact => contact.for_json }
  end

  validates :name, :presence => true, :length => {:within => 2..40}, :company_name => true  

  after_initialize :strip_name

  class << self

    def names
      {
        :munich => ['messenger', 'twister', 'courier AG']
      }
    end
    
    def create_from city = :munich
      city ||= :munich
      co = Company.new :name => names[city.to_sym].pick_one
      co.contact = Contact.create_from city
      co.address = Address.create_from city
      co
    end
  end
    
  protected 
  
  def strip_name
    self.name = self.name.strip
  end
end
