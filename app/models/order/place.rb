class Order
  class Place
    include Mongoid::Document

    field       :notes, :type => String
    
    embeds_one  :contact
    embeds_one  :address

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
  end
end