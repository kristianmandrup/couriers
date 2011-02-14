require 'order/place/api'
require 'order/place/class_methods'

class Order
  class Place
    include Mongoid::Document

    field       :notes, :type => String
    
    embeds_one  :contact
    embeds_one  :address

    # extend ClassMethods
    include Api

    def full_name
      contact.full_name
    end

    def street
      address.street if address
    end

    def street= street
      address.street = street if address
    end

    def city
      address.city if address
    end

    def city= city
      address.city = city if address
    end

  
    def location
      address.location if address
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
  end
end