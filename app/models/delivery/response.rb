class Delivery::Response
  include Mongoid::Document

  field :state,         :type => String
  references_one        :courier, :class_name => 'Courier'  
  
  validates :state, :delivery_response => true
  
  def to_s
    %Q{state: #{state}
courier: #{courier.full_name}
}
  end

  def set_state new_state
    @state = new_state
  end

  class << self      
    def valid_states
      [:accepted, :declined]
    end    
        
    def create_for courier, state = :accepted
      response = self.new :state => state
      response.courier = courier
      response
    end
  end
  
  protected  
end