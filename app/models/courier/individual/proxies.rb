class Courier::Individual < Courier
  module Proxies
    def full_name
      person.full_name if person
    end

    def full_name= name
      person.full_name = name if person
    end
    
    alias_method :name, :full_name
    alias_method :name=, :full_name=

    def address
      person.address
    end

    def address= adr
      person.address = adr
    end
  end
end