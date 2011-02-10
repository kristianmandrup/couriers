class Order::Offer
  module ClassMethods
    include ::OptionExtractor
      
    def status event
      Rails.logger.error "Unknown offer event: #{event}" and return if !event_msg[event]
      status_msg event, event_msg[event]
    end

    def create_empty
      self.new
    end

    def create_request courier
      Delivery::Request.create_for courier
    end

    def create_for options = {:max => 3}
      delivery_offer = create_empty
      delivery_offer.max_couriers = extract_max_couriers options
      delivery_offer.booking      = extract_booking options
      delivery_offer.for_couriers extract_couriers options
      delivery_offer
    end

    def valid_states
      [:ready, :accepted, :declined, :timedout]
    end

    def valid_state? state
      valid_states.include? state.to_sym
    end      
  
    private

    def extract_max_couriers options
      options[:max] || 3
    end

    def event_msg
      {
        :OK => 'You got the delivery',
        :DELIVERY_TIMEOUT => 'You responded after the timeout period',
        :DELIVERY_TAKEN => 'Delivery has already been taken'
      }
    end

    def status_msg code, msg
      {:status => {:code => code.to_s, :message => msg} }
    end
  end
end