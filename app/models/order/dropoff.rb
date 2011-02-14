class Order
  class Dropoff < Place
    include Mongoid::Document  
    embedded_in :booking, :inverse_of => :dropoff  
  
    def self.create_empty
      place           = Order::Dropoff.new
      place.address   = Address.create_empty
      place.contact   = Contact.create_empty
      place
    end
  end
end