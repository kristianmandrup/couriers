module Api
  class CouriersController < ApplicationController
    respond_to :json

    # before_filter :authenticate_user!

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

      avail = Courier.available
      courier_points = avail.as_map_points
      nearby_couriers = courier_points.within_rectangle(rectangle).extend Positionable

      render_json nearby_couriers.positions.map(&:for_json)
    end  

    protected

    def current_location 
      @current_location ||= (longitude || latitude) ? Location.new(latitude, longitude) : current_user.find(params[:id]).location
    end

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

    def update_state
      courier_user = Courier::Individual.create_from :munich
      body = request.body.read
      work_state = decode_state_from(body)

      puts "work state to set: #{work_state}"
      courier_user.work_state = work_state
      courier_user.save
      ws = WorkState.new courier_user.work_state
      puts "work state to be sent: #{ws.for_json}"      
      render_json(ws)
    end
    
    # Note: The Courier::State contains both the workstate and delivery info
    def get_state
      courier_user = Courier::Individual.create_from :munich
      delivery = courier_user.delivery
      courier_state = Courier::State.new # :current_delivery => delivery, :work_state => work_state
      render_json(courier_state.json_workstate)
    end
    
    private 
    
    def decode_state_from body
      begin
        return uncover(body) if !body.match(/#{Regexp.escape('{')}/)          
        json = ActiveSupport::JSON.decode(body)        
        json['work_state'] || 'not_available'
      rescue
        uncover body        
      end
    end      
    
    def uncover body
      return 'not_available' if body.match(/not_available/)
      return 'available' if body.match(/available/)
      'unknown'
    end
  end
end