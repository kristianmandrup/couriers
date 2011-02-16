require 'order/place'

class Order
  class Pickup < Place
    include Mongoid::Document
      
    embedded_in :booking, :inverse_of => :pickup
  
    def self.create_empty
      place           = Order::Pickup.new
      place.address   = Address.create_empty
      place.contact   = Contact.create_empty
      place
    end
  end
end