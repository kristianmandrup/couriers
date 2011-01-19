class Courier::State
  extend ActiveModel::Naming
  include ActiveModel::Validation
  include ActiveModel::Conversion  
  
  attr_accessor :current_delivery, :work_state

  # setup custom validators!
  # validates :work_state, :as => :work_state
  
  def initialize attributes = {}
    attributes.each do |name, value|
      send "#{name}=", value
    end
  end  
end
