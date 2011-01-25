module Api
  # Get current courier info
  # 
  # courier/info :get
  # {
  #     work_state: "available|not_available"
  #     current_delivery: > courier/deliveries/{current_delivery_id}/info
  # }
  # 
  # --------------------------------------------------------------------------------
  # Set current courier state
  # 
  # courier/state :put
  # {
  #   work_state: "available|not_available"
  # }
  # 
  # --------------------------------------------------------------------------------
  # Set current courier location
  # 
  # courier/location :put
  # {
  #   position:   {
  #                     latitude: 150.644,
  #                     longitude: -34.397
  #                 }
  # }  
  class CouriersController < ApplicationController
    respond_to :json

    helper Api::CouriersHelper
    helper Api::ResponseHelper

    # before_filter :authenticate_user!

    # Get current courier info
    # 
    # courier/info :get
    # {
    #     id: "1" # courier number
    #     work_state: "available|not_available",
    #     travel_mode: "biking|driving",
    #     current_delivery: > courier/deliveries/{current_delivery_id}/info
    # }
    def info
      begin
        reply_get(current_courier, :info)
      rescue
        reply_get_error :info
      end
    end

    # courier/state :post
    # {
    #   work_state: "available|not_available"
    # }
    def update_state
      begin
        current_courier.work_state = work_state # see couriers_helper
        current_courier.save
        reply_update(current_courier, :state)
      rescue
        reply_update_error(current_courier, :state)
      end      
    end
    
    # Set current courier location
    # 
    # courier/location :put
    # {
    #   position:   {
    #                     latitude: 150.644,
    #                     longitude: -34.397
    #                 }
    # }  
    def update_location
      begin
        current_courier.location = Location.create_from_params location # see couriers_helper
        current_courier.save
        reply_update(current_courier, :location)
      rescue
        reply_update_error(current_courier, :location)
      end      
    end

  
    # Get locations of all couriers within my radius
    # 
    # location/nearby_couriers :get,
    # params: {
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
      begin   
        rectangle = GeoMagic::Rectangle.create_from_coords(ne_latitude, ne_longitude, sw_latitude, sw_longitude) # see couriers_helper
        couriers = Courier::Individual.all_from :munich
        nearby_couriers = couriers.as_map_points.within_rectangle(rectangle).extend Positionable
        reply_get nearby_couriers, :locations
      rescue
        reply_get_error :nearby_couriers
      end
    end
  end
end