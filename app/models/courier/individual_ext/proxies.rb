class Courier
  module IndividualExt
    module Proxies    
      def full_name
        person.full_name if person
      end

      def full_name= name
        person.full_name = name if person
      end

      def name= name
        full_name = name
      end

      def name
        full_name
      end

      def address
        person.address
      end

      def address= adr
        person.address = adr
      end
    end
  end
end