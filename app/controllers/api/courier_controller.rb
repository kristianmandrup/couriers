module Api
  class CourierController < ActionController::Base
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
  
    protected

    def update_state
      p "update_state"

      courier_user = Courier::Individual.create_from :munich

      body = request.body.read      

      p "body: #{body}" 

      json = ActiveSupport::JSON.decode(body)      
      
      p "json: #{json}"
      
      courier_user.work_state = json['work_state']
      courier_user.save

      p "respond with work state: #{courier_user.work_state}"
      
      respond_with(WorkState.new, :location => courier_state_path)
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