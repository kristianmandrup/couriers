class Customer
  class Order
    class Booking
      module Api
        def for_json
          {:pop => pickup.for_json, :pod => dropoff.for_json, :description => description }
        end
      end
    end
  end
end