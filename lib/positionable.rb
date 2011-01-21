module Positionable
  def positions
    self.map {|courier| Courier::Position.new(:number => courier.number, :location => courier.location, :vehicle => courier.vehicles.first) }
  end
end