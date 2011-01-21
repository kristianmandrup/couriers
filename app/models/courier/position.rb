# See Courier::List

class Courier::Position
  attr_accessor :number, :location, :vehicle

  def for_json    
    {:id => number, :location => location.for_json, :vehicle => vehicle }
  end
  
  def initialize attributes = {}
    attributes.each do |name, value|
      send "#{name}=", value
    end
    self.vehicle = 'bicycle'
    self.number = rand(10) +1
  end
end