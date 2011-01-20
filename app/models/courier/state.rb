class Courier::State
  include ActiveModel::Validations
  include ActiveModel::Conversion  
  extend  ActiveModel::Naming
  extend  ActiveModel::Callbacks
  
  attr_accessor :current_delivery
  attr_accessor :work_state

  def set_work_state
    self.work_state = 'not_available' if self.work_state.blank?
  end

  def for_json
    {:current_delivery => current_delivery.for_json, :work_state => work_state}
  end

  def json_workstate
    {:work_state => work_state}
  end

  # use custom validators!
  validates :work_state, :work_state => true
  
  def initialize attributes = {}
    attributes.each do |name, value|
      send "#{name}=", value
    end
    set_work_state
  end  
end
