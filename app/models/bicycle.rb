class Bicycle < Vehicle
  include Mongoid::Document

  before_validation :setup
  
  private
  
  def setup
    self.name = 'Bicycle'
  end  
end
