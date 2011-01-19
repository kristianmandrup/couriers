class CouriersController < ActionController::Base
  before_filter :authenticate_user!

  # Get current courier state
  # 
  # courier/state :get
  # {
  #   work_state: "available|not_available"
  #   current_delivery:   {
  #     state: "ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed",
  #     id: "1"
  #   }
  # 
  # }
  def state    
    the_courier = current_user.find(params[:id])
    delivery = the_courier.delivery
    work_state = the_courier.work_state
    
    courier_state = Courier::State.new :current_delivery => delivery, :work_state => work_state
    
    respond_with(@courier_state)       
  end  
  
  # Get locations of all couriers within my radius
  # 
  # couriers/locations/:radius :get
  # [
  #   {
  #     id: "1",
  #     position : {
  #        latitude: "150.644",
  #       longitude: "-34.397"
  #     }
  #     vehicle: "bike|cargobike|motorbike|car|van"
  #   },  
  #   {
  #     id: "2",
  #     position : {
  #       latitude: "150.644",
  #       longitude: "-34.397"
  #     }
  #     vehicle: "bike|cargobike|motorbike|car|van"
  #   }
  # ]
  def locations    
    radius = params[:radius_km]
    current_location = current_user.find(params[:id]).location

    # should extend array with CourierList 
    nearby_couriers = current_location.nearby_couriers_in :radius => radius        
    respond_with(nearby_couriers.positions)       
  end  
  
end
