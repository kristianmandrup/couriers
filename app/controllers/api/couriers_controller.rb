module Api
  class CouriersController < ActionController::Base
    respond_to :json

#    before_filter :authenticate_user!

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
      p "API state"
      update_state if request.post?
      get_state if request.get?      
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

    protected

    def update_state
      p "update_state"

      courier_user = Courier::Individual.create_from :munich

      body = request.body.read      
      json = JSON.decode(body)      
      
      p "json: #{json}"
      
      courier_user.work_state = json['work_state']
      
      respond_with(courier_state.json_workstate)
    end

    def get_state
      p "get_state"
       
      courier_user = Courier::Individual.create_from :munich
      delivery = courier_user.delivery
      # work_state = courier_user.work_state
      # 
      p "delivery: #{delivery}"
        
      courier_state = Courier::State.new # :current_delivery => delivery, :work_state => work_state
      
      p "state: #{courier_state}"
      p "work state: #{courier_state.json_workstate.inspect}"
      respond_with(courier_state.json_workstate)
    end
  end
end