class Courier::Info
  include ActiveModel::Validations
  include ActiveModel::Conversion  
  extend  ActiveModel::Naming
  extend  ActiveModel::Callbacks

  attr_accessor :number  
  attr_accessor :travel_mode
  attr_accessor :current_delivery
  attr_accessor :work_state

  def for_json
    state = {:work_state => work_state}    
    state.merge!(:current_delivery => current_delivery.for_json) if current_delivery          
    state
  end

  # use custom validators!
  validates :work_state, :work_state => true
  validates :travel_mode, :travel_mode => true

  def available?
    work_state == 'available'
  end

  def available= value
    self.work_state = value ? 'available' : 'not_available'
  end
  
  def initialize attributes = {}
    attributes.each do |name, value|
      method_name = "#{name}="
      send(method_name, value) if respond_to? method_name
    end
    post_init
  end  

  protected
  
  def post_init
    set_defaults
  end
  
  def set_defaults
    self.work_state = 'not_available' if self.work_state.blank?
    self.travel_mode = 'driving' if self.travel_mode.blank?
  end
end
