class Car < Vehicle
  include Mongoid::Document

  before_validation :setup
  
  private
  
  def setup
    self.name = 'Car'
  end  
end
