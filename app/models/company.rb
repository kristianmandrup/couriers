class Company
  include Mongoid::Document

  field :name, :type => String
  
  embeds_one :address
  embeds_one :contact
  embeds_one :profile #, :class_name => 'Courier::Profile'
  embeds_one :channel, :class_name => 'Contact::Channel'

  def for_json
    {:name => name, :address => address.for_json, :contact => contact.for_json }
  end


  class << self

    def names
      {
        :munich => ['messenger', 'twister', 'courier AG']
      }
    end
    
    def create_from city = :munich
      co = Company.new :name => names[city].pick_one
      co.contact = Contact.create_from city
      co.address = Address.create_from city
      co
    end
  end
  
  validates :name, :presence => true, :length => {:within => 2..40}, :company_name => true  
  before_validation :strip_names
  
  private 
  
  def strip_names
    self.name = self.name.strip
  end
end
