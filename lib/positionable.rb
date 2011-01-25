module Positionable
  def positions
    self.map {|courier| Courier::Position.new(:number => courier.number, :location => courier.location, :vehicle => courier.vehicles.first) }
  end
  
  def locations
    positions.map(&:for_json)
  end  
end