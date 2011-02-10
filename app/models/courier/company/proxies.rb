class Courier::Company < Courier
  module Proxies
    def company_name
      company.name
    end

    def company_name= name
      company.name = name
    end

    alias_method :name, :company_name
    alias_method :name=, :company_name=

    # full name of contact
    def full_name
      company.full_name
    end

    def full_name= full_name
      company.full_name = full_name
    end

    def address
      company.address
    end

    def address= adr
      company.address = adr
    end    
  end
end