module OrderExt
  module ClassMethods
    include ::OptionExtractor
      
    def valid_states
      [:accepted, :cancelled, :picked_up, :delivered, :billed]
    end    

    def valid_state? state
      valid_states.include? state.to_sym
    end

    def create_from offer
      delivery = create_empty
      delivery.state    = :accepted
      delivery.location = offer.location
      delivery.waybill  = Order::Waybill.create_for :booking => offer.booking
      delivery.courier  = offer.accepted_courier
      delivery.save
      delivery
    end

    def create_empty
      self.new
    end
      
    def create_for options = {}
      delivery = self.new
      delivery.state    = extract_order_state(options)
      delivery.location = extract_location(options)
      delivery.waybill  = extract_waybill(options)      
      delivery
    end    
  end
end