module Shared
  module BookingsHelper
    module Params
      def current_booking
        Order::Booking.create_from_params order_booking
      end

      def order_booking
        params[:order_booking]
      end

      # # parse pickup
      # def pickup params
      #   Order::Pickup.create_from_params params[:pickup]
      # end
      # 
      # # parse dropoff
      # def dropoff params
      #   Order::Dropoff.create_from_params params[:dropoff]
      # end
    end

    module Channels
      [:courier, :individual, :company].each do |name|
        class_eval %{
          def #{name}_channel id
            TiramizooApp.pubsub.delivery_channel(:#{name} => id)
          end      
        }
      end
    end

    module CouriersSelection
      def couriers_selected 
        order_booking[:couriers].reject{|i| i.blank?}.map(&:to_i)
      end

      def companies_selected 
        get_selected params[:couriers][:company]
      end

      def individuals_selected
        get_selected params[:couriers][:individual]
      end

      def get_selected selected
        return [] if !selected || selected.empty?
        selected.map(&:to_i)
      end
    end
  end
end