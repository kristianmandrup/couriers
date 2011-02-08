class Order::Place
  include Mongoid::Document

  field       :notes, :type => String
    
  embeds_one  :contact
  embeds_one  :address

  module Api
    def for_json
      {:position => location.for_json, :address => address.get_street, :contact => contact.for_json, :notes => notes }
    end  

    def get_overview
      {:position => location.for_json, :address => address.get_street, :notes => notes }
    end
  end  
  include Api

  def full_name
    contact.full_name
  end

  def street
    address.street
  end

  def street= street
    address.street = street
  end

  def city
    address.city
  end

  def city= city
    address.city = city
  end

  
  def location
    address.location
  end

  def to_s
    %Q{
contact: 
#{contact}

address: 
#{address}

notes: #{notes}
}
  end  

  def self.inherited(base)
    base.extend ClassMethods
  end

  
  module ClassMethods    
    include ::OptionExtractor

    def create_empty
      place = self.new
      place.address  = Address.create_empty
      place.contact  = Contact.create_empty
      place
    end

    def create_from_params params
      place = create_empty
      place.notes   = params[:notes]
      place.address = Address.create_for :street => params[:street] # use geocode
      place.contact = Contact.create_for :channel => params[:contact_info], :name => params[:name]
      place
    end

    def create_for options = {}
      place = self.new
      place.notes   = extract_notes options
      place.contact = extract_contact options
      place.address = extract_address options
      place
    end    
  end    
end