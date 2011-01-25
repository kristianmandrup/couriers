class Delivery::Request
  include Mongoid::Document

  field :time_notified, :type => Time
  field :state,         :type => String
  references_one        :courier, :class_name => 'Courier'  
  
  embedded_in :delivery_offer, :inverse_of => :delivery_request

  validates :state, :delivery_request_state => true
  
  after_initialize :setup

  def to_s
    %Q{state: #{state}
time: #{time_notified}
courier: #{courier.full_name}
}
  end

  def set_state new_state
    raise DeliveryAlreadyTakenError, "Customer accepted delivery response of another courier" if locked? new_state
    raise DeliveryTimeOutError, "Your response was too late" if time_out? new_state
    @state = new_state
  end

  def locked? new_state 
    case new_state.to_sym
    when :accepted
      return  @state != 'ready'
    end
    false
  end

  def time_out? new_state
    case new_state.to_sym    
    when :accepted
      @time_notified - Time.now > 20.seconds
    end
    false
  end

  class << self      
    def valid_states
      [:notified, :accepted, :declined]
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