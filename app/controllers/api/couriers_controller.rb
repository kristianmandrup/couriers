module Api
  # Get current courier info
  # 
  # couriers/:id/info :get
  # {
  #   work_state: "available|not_available"
  #   current_delivery: > courier/deliveries/{current_delivery_id}/info
  # }
  # 
  # --------------------------------------------------------------------------------
  # Set current courier state
  # 
  # couriers/:id/state :put
  # {
  #   work_state: "available|not_available"
  # }
  # 
  # --------------------------------------------------------------------------------
  # Set current courier location
  # 
  # couriers/:id/location :put
  # {
  #   position:   {
  #     latitude: 150.644,
  #     longitude: -34.397
  #   }
  # }  
  class CouriersController < ApplicationController
    respond_to :json

    include ::Api::CouriersHelper
    include Api::ResponseHelper

    # before_filter :authenticate_user!

    # Get current courier info
    # couriers/:id/info :get
    
    # REQUEST
    #   params[:id]    

    # RESPONSE

    # {
    #     status: {
    #         code: "OK",
    #         message: "Delivery accepted"
    #     }    
    #     data: {
    #       id: "1" # courier number
    #       work_state: "available|not_available",
    #       travel_mode: "biking|driving",
    #       current_delivery: > courier/deliveries/{current_delivery_id}/info
    #    }
    # }
    def info
      begin
        reply_get(current_courier, :info)
      rescue Exception => e
        puts e
        reply_get_error :info
      end
    end

    # couriers/:courier_id/state :post

    # REQUEST
    #   params[:courier_id]
    
    # {
    #   work_state: "available|not_available"
    # }
    
    # {
    #     status: {
    #         code: "OK",
    #         message: "Work state updated"
    #     },
    #     data: {
    #       work_state: "available|not_available",
    #    }
    # }
    
    def state
      begin 
        puts "params: #{params}"        
        current_courier.work_state = p_work_state # see couriers_helper
        current_courier.save!
        puts "updated courier state to: #{p_work_state}, sending it back #{current_courier.work_state}"
        reply_update(current_courier, :state)
      rescue Exception => e
        puts e
        reply_update_error(current_courier, :state)
      end      
    end
    
    # Set current courier location
    # 
    # couriers/:id/location :put
    # REQUEST
    # {
    #   position: {
    #     latitude: 150.644,
    #     longitude: -34.397
    #   }
    # }  

    # RESPONSE
    # {
    #   status: {
    #     code: "OK",
    #     message: "Work state updated"
    #   },
    #   data: {
    #     position:   {
    #       latitude: 150.644,
    #       longitude: -34.397
    #     }
    #   }
    # }  

    def location
      begin    
        puts "service location: #{params}"
        current_courier.location = Location.create_from_params p_location # see couriers_helper
        current_courier.save!
        render_json(reply_ok "courier was relocated")
        # reply_update # (current_courier, :location)
      rescue Exception => e
        puts e
        reply_update_error(current_courier, :location)
      end      
    end

  
    # Get locations of all couriers within my radius
    # 
    # location/nearby_couriers :get

    # REQUEST
    # params: {
    #     ne_latitude: 150.644,
    #     ne_longitude: -34.397,
    #     sw_latitude: 150.644,
    #     sw_longitude: -34.397
    # }
    # 
    # RESPONSE
    # {
    #   status: {
    #     code: "OK",
    #     message: "Work state updated"
    #   },
    #   data: {    
    #   [
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
    #   ]
    #   }
    # } 
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