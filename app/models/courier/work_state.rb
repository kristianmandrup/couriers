class WorkState
  include ActiveModel::Validations
  include ActiveModel::Conversion  
  extend  ActiveModel::Naming
  extend  ActiveModel::Callbacks
  
  attr_accessor :work_state
  
  def initialize work_state 
    @work_state = work_state || 'not_available'
  end  
end