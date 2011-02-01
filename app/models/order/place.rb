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

    def create_from_params params
      place = self.new 
      place.notes    = params[:notes]
      place.contact  = Contact.create_from_params params[:contact]
      place.address  = Address.create_from_params params[:address]
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