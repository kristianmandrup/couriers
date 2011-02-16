class Order
  module OfferExt
    module Places
      def location
        booking.pickup.location
      end

      def pickup
        booking.pickup
      end

      def dropoff
        booking.dropoff
      end

      def with_dropoff
        yield dropoff
      end

      def with_pickup
        yield pickup
      end
    end
  end
end    
