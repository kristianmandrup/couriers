module Courier::List

  # For each courier
  #     id: "1",
  #     latitude: "150.644",
  #     longitude: "-34.397", 
  #     vehicle: "bike|cargobike|motorbike|car|van"
  
  def positions
    map do |courier|
      Courier::Position.new :number => courier.number, :latitude => courier.location.latitude, :longitude => courier.location.longitude, :vehicle => courier.vehicle.name
    end
  end
end