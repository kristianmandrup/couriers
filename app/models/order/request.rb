class Order
  class Request
    include Mongoid::Document

    field :state,         :type => String
    field :time_notified, :type => Time
  
    references_one  :courier
    embedded_in     :offer,  :class_name => 'Order::Offer', :inverse_of => :order_request

    validates :state, :order_request_state => true
  
    after_initialize :setup

    def to_s
      %Q{state: #{state}
  time: #{time_notified}
  courier: #{courier.full_name}
  }
    end

    def set_state new_state
      @state = new_state
    end

    class << self      
      def valid_states
        [:notified, :accepted, :declined]
      end    

      def valid_state? state
        valid_states.include? state.to_sym
      end      
        
      def create_for courier
        delivery_request = self.create
        delivery_request.courier = courier
        delivery_request
      end
    end
  
    protected
  
    def setup
      self.state = 'notified'
      self.time_notified = Time.now 
    end  
  end
end