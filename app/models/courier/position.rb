# See Courier::List

class Courier::Position
  attr_accessor :number, :latitude, :longitude, :vehicle
  
  def initialize attributes = {}
    attributes.each do |name, value|
      send "#{name}=", value
    end
  end
end