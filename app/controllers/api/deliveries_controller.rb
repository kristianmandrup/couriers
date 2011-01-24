module Api
  class DeliveriesController < ActionController::Base
    before_filter :authenticate_user!

    respond_to :json

    # Push new delivery from server to client
    # id  - delivery ID
    # 
    # channel: tiramizoo-courier-delivery
    # {
    #     action: "new_delivery",
    #     data: {
    #         id: "34",
    #         directions: "3,5km to target",
    #         pickup:   {
    #                         location: {
    #                                         position:   {
    #                                                         latitude: 150.644,
    #                                                         longitude: -34.397
    #                                                     },
    #                                         address:  {
    #                                                         street: "Sendlinger Straße 1",
    #                                                         zip: "80331",
    #                                                         city: "München"
    #                                                     }
    # 
    #                                     },
    #                         notes: "Big box"
    #                     },
    #         dropoff:  {
    #                         location: {
    #                                         position:   {
    #                                                         latitude: 150.644,
    #                                                         longitude: -34.397
    #                                                     },
    #                                         address:  {
    #                                                         street: "Sendlinger Straße 2",
    #                                                         zip: "80331",
    #                                                         city: "München"
    #                                                     }
    # 
    #                                  }
    #                         notes: "Big box"
    #                     }
    #             }
    # }
    # --------------------------------------------------------------------------------
    # Create new delivery offer and pushes it to the selected couriers 
    # Also use the zip of the pickup to find Companies who subscribe to that zip and send offer to those companies
    def create
      session[:couriers_selected] = couriers_selected

      delivery_offer = Delivery::Offer.create_for(current_booking, couriers_selected)

      couriers_to_notify.each do |id|
        p "sending deliver info to delivery channel for courier: #{id}"
        courier_channel(id).publish :directions => '3,5km to...', :delivery_offer => delivery_offer.for_json
      end

      redirect_to wait_for_couriers_response_path    
    end

    # Get details about a specific delivery
    # 
    # courier/deliveries/1/state :get
    #   :id of delivery
    # POST
    # {
    #   directions: "3,5km to target",
    #   pickup:   {
    #           location: {
    #                   position:   {
    #                           latitude: "150.644",
    #                           longitude: "-34.397"
    #                         },
    #                   address:  {
    #                           street: "Sendlinger Straße 1",
    #                           zip: "80331",
    #                           city: "München"
    #                         }
    # 
    #                 },
    #           contact:  {
    #                   company_name: "Tiramizoo 1",
    #                   name: "Michael Löhr",
    #                   email: "michael.loehr@tiramizoo.com",
    #                   phone: "089123456789"                   
    #                 },
    #           notes: "Big box"
    #         },            
    #   dropoff:  {
    #           location: {
    #                   position:   {
    #                           latitude: "150.644",
    #                           longitude: "-34.397"
    #                         },
    #                   address:  {
    #                           street: "Sendlinger Straße 2",
    #                           zip: "80331",
    #                           city: "München"
    #                         }
    # 
    #                 },
    #           contact:  {
    #                   company_name: "Tiramizoo 2",
    #                   name: "Philipp Walz",
    #                   email: "philipp.walz@tiramizoo.com",
    #                   phone: "089987654321"
    #                 },
    #           notes: "Big box"              
    #         }
    # }

    def state
      get_state if request.get?
      update_state if request.put?
    end

    protected

    def couriers_to_notify
      couriers_to_notify = couriers_selected + courier_companies_subscribing_to_zip(current_booking.zip)
    end 
  
    def get_state
      @delivery = current_courier.deliveries.where(params[:id])
      respond_with(@delivery.format_for_state)
    end

    # Set the state of a specific delivery
    # 
    # courier/deliveries/1/state :put
    # {
    #   state: "ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed"
    #   location: {
    #           longitude: "-34.397", 
    #           latitude: "150.644"
    #         }
    # }  
    def update_state   
      state = params[:state]  
      id = params[:id]    
      delivery = case state.to_sym
      when :accepted
        Delivery.where(:id => id)
      else        
        delivery = current_courier.deliveries.where(:id => id)
      end      

      couriers_selected.each do |id|
        p "sending taken to delivery channel for courier: #{id}"
        courier_channel(id).publish :id => params['id'], :state => 'taken'
      end
      
      delivery.location = Location.create_from_params params[:location]    
      begin
        delivery.set_state params[:state]
        render_json(Delivery::State.courier_got_delivery)
      rescue DeliveryTimeOutError
        render_json(Delivery::State.delivery_timeout)
      rescue Delivery::AlreadyTakenError                
        render_json(Delivery::State.delivery_already_taken)
      end
    end    
  end
end
