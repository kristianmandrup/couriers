class Order
  module OfferExt
    module State    
      class AlreadyTakenError < StandardError; end
      class TimeOutError      < StandardError; end

      def set_courier_state courier, new_state
        raise TimeOutError, "Your response was too late" if time_out? new_state
        raise AlreadyTakenError, "Customer accepted delivery response of another courier" if locked? new_state
        set_state new_state
      end

      protected

      def set_state new_state
        self.state = new_state

        delivery_request = delivery_request_for(courier)
        delivery_request.set_state(new_state)

        self.accepted_courier = courier if accepted?
        save
      end

      def locked? new_state
        new_state.to_sym == :accepted ? accepted? : false
      end

      def accepted?
        state? :accepted
      end

      def state? s
        self.state.to_sym == s.to_sym
      end

      def time_out? new_state
        case new_state.to_sym
        when :accepted
          @time_notified - Time.now > 20.seconds
        end
        false
      end
    end
  end
end