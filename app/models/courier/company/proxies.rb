class Courier
  class Company < ::Courier
    module Proxies
      def company_name
        company.name if company
      end

      def company_name= name
        company.name = name if company
      end

      alias_method :name, :company_name
      alias_method :name=, :company_name=

      # full name of contact
      def full_name
        company.full_name if company
      end

      def full_name= full_name
        company.full_name = full_name if company
      end

      def address
        company.address if company
      end

      def address= adr
        company.address = adr if company
      end    
    end
  end
end