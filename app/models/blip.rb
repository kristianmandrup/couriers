class Blip
  include Mongoid::Document
  
  field :number, :type => Integer

  after_initialize :set_number
  # before_create :set_number
  # after_create :set_number
  # 
  # before_save :set_number
  # before_update :set_number
  # before_validation :set_number
  # 
  # after_save :set_number
  # after_update :set_number
  # after_validation :set_number

  protected
  
  def set_number
    puts "set_number: #{Courier::Counter.current_number}"
    self.number = Courier::Counter.increment
    save    
  end
  
end