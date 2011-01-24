class Order::Dropoff
  include Mongoid::Document
  
  embedded_in :booking, :inverse_of => :dropoff  
    
  embeds_one :contact
  embeds_one :address
  
  field :notes, :type => String

  def location
    address.location
  end
  
  def for_json
    {:contact => contact.for_json, :address => address.for_json}
  end  

  def without_contact
    {:address => address.for_json}
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
  
  class << self
    def create_from_params params
      dropoff = self.new :notes => params[:notes]
      dropoff.contact = Contact.create_from_params params[:contact]
      dropoff.address = Address.create_from_params params[:address]
      dropoff
    end

    def create_from city = :munich
      dropoff = self.new
      dropoff.address = Address.create_from city
      dropoff.contact = Contact.create_from city
      dropoff.notes = 'Drop it baby!'
      dropoff
    end
  end  
end