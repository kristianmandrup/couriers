module Api
  class DeliveryOffersController < ActionController::Base
    # before_filter :authenticate_user!

    respond_to :json  

    include Api::DeliveriesHelper
    include Api::ResponseHelper    

    # Set response for a specific delivery offer:
    # 
    # couriers/:id/delivery_offers/:delivery_id/response :put
    # REQUEST
    # {
    #   response: "accepted|declined"
    # }

    # RestClient.put('http://localhost:3000/api/couriers/1/delivery_offers/1/state.json', response: 'accepted')

    # RESPONSE
    # {
    #   status: {
    #     code: "OK",
    #     message: "Work state updated"
    #   },
    #   data: {    
    #     id: "1",
    #   }
    # }
    def answer
      begin
        # delivery_offer = Delivery::Offer.where(:number => delivery_id)
        delivery_offer = Delivery::Offer.create_from :munich
        delivery_offer.state = p_state

        reply_update delivery_offer, :state
      rescue DeliveryTimeOutError
        status :DELIVERY_TIMEOUT

      rescue DeliveryAlreadyTakenError
        status :DELIVERY_TAKEN
      rescue Exception => e
        puts e
        reply_update_error delivery_offer, :state
      end
    end    

    protected

    def status event
      status_json = Delivery::Offer.status(event).merge(:id => delivery_id)
      render_json(status_json)
    end         
  end
end
