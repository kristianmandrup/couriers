class Courier
  module IndividualExt
    module Api
      def for_json
        {:email => email, :person => person.for_json}.merge super
      end
  
      def get_location
        {:location => address.location.for_json}
      end    
    end
  end
end