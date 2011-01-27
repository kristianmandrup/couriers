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

    # RestClient.put('http://localhost:3000/api/couriers/1/delivery_offers/1/response.json', response: 'accepted')

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
    def response
      begin
        # delivery_offer = Delivery::Offer.where(:number => delivery_id)
        # delivery_offer.set_state state # may raise "business" error (lock)
        delivery_offer = Delivery::Offer.create_from :munich

        status :OK
      rescue DeliveryTimeOutError
        status :DELIVERY_TIMEOUT

      rescue DeliveryAlreadyTakenError
        status :DELIVERY_TAKEN
      end
    end    

    protected

    def status event
      render_json(Delivery::Offer.status(event).merge(:id => delivery_id))
    end         
  end
end
