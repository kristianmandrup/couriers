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
      order = self.new
      order.address = Address.create_from city
      order.contact = Contact.create_from city
      order.notes = 'Drop it baby!'
      order
    end
  end  
end