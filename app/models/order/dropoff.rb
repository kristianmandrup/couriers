class Order::Dropoff
  include Mongoid::Document
  
  embedded_in :booking, :inverse_of => :dropoff  
    
  embeds_one :contact
  embeds_one :address
  
  field :notes, :type => String
  
  def for_json
    {:contact => contact.for_json, :address => address.for_json}
  end  
  
  class << self
    def create_from city = :munich
      address = DropoffAddress.new :street => Address.streets[city].pick_one , :city => city, :country => Address.countries[city]
      address.locate!
    end    
    
    def create_from city = :munich
      adr = create_from city
      adr.contact = Contact.create_from city
      adr
    end
  end  
end