class Order
  module PlaceExt
    module Api
      def for_json
        {:position => location.for_json, :address => address.get_street, :contact => contact.for_json, :notes => notes }
      end  

      def get_overview
        {:position => location.for_json, :address => address.get_street, :notes => notes }
      end
    end
  end
end