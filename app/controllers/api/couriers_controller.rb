module Api
  class CouriersController < ApplicationController
    respond_to :json

    # before_filter :authenticate_user!

    # Get/Set current courier state
    # 
    def state
      update_state if request.post?
      get_state if request.get?      
    end  
  
    # Get locations of all couriers within my radius
    # 
    # location/nearby_couriers :get,
    # params: {
    #     radius: 20,
    #     ne_latitude: 150.644,
    #     ne_longitude: -34.397,
    #     sw_latitude: 150.644,
    #     sw_longitude: -34.397
    # }
    # 
    # POST
    # [
    #   {
    #     id: "1",
    #     position: {
    #             latitude: 150.644,
    #             longitude: -34.397
    #         },
    #     vehicle: "bike|cargobike|motorbike|car|van"
    #   },  
    #   {
    #     id: "2",
    #     position: {
    #             latitude: 150.644,
    #             longitude: -34.397
    #         },
    #     vehicle: "bike|cargobike|motorbike|car|van"
    #   }
    # ] 
    def nearby_couriers    
      rectangle = GeoMagic::Rectangle.create_from_coords(ne_latitude, ne_longitude, sw_latitude, sw_longitude)

      couriers = Courier.available
      nearby_couriers = couriers.as_map_points.within_rectangle(rectangle).extend Positionable

      render_json nearby_couriers.positions.map(&:for_json)
    end  

    protected

    # courier/state :post
    # {
    #   work_state: "available|not_available"
    # }
    def update_state
      courier_courier.work_state = params[:work_state]
      courier_courier.save
      render_json(WorkState.new courier_user.work_state)
    end
    
    # Note: The Courier::State contains both the workstate and delivery info
    # courier/state :get
    # {
    #   work_state: "available|not_available"
    #   current_delivery:   {
    #     state: "ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed",
    #     id: "1"
    #   }
    # }    
    def get_state      
      render_json(current_courier.state_and_curent_delivery.for_json)
    end

    def current_location 
      @current_location ||= (longitude || latitude) ? Location.new(latitude, longitude) : current_user.find(params[:id]).location
    end

    private

    def unit
      params[:unit]
    end      

    def ne_longitude
      params[:ne_longitude].to_f
    end      

    def ne_latitude
      params[:ne_latitude].to_f
    end      

    def sw_longitude
      params[:sw_longitude].to_f
    end      

    def sw_latitude
      params[:sw_latitude].to_f
    end      
  end
end