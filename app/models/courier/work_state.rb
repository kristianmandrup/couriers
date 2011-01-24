class Courier::WorkState
  include ActiveModel::Validations
  include ActiveModel::Conversion  
  extend  ActiveModel::Naming
  extend  ActiveModel::Callbacks
  
  attr_accessor :work_state
  
  validates :work_state, :work_state => true
  
  def initialize work_state 
    @work_state = work_state || 'not_available'
  end  
  
  def self.valid_states
    [:available, :not_available]
  end  
end