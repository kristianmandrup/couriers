class Customer
  module Order
    module BookingExt
      module Api
        def for_json
          {:pop => pickup.for_json, :pod => dropoff.for_json, :description => description }
        end
      end
    end
  end
end