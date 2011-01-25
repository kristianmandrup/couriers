module Api
  class DeliveryOffersController < ActionController::Base
    # before_filter :authenticate_user!

    respond_to :json  

    helper Api::DeliveriesHelper
    helper Api::ResponseHelper    

    # Set response for a specific delivery offer:
    # 
    # courier/delivery_offers/1/response :put
    # REQUEST
    # {
    #   response: "accepted|declined"
    # }

    # RESPONSE
    # {
    #   id: "12"
    # }

    def response
      begin
        delivery_offer = Delivery::Offer.where(:number => delivery_id)
        delivery_offer.set_state state # may raise "business" error (lock)

        status :OK
      rescue DeliveryTimeOutError
        status :DELIVERY_TIMEOUT

      rescue DeliveryAlreadyTakenError
        status :DELIVERY_TAKEN
      end
    end    

    private

    def status event
      render_json(Delivery::Offer.status(event).merge(:id => delivery_id))
    end         
  end
end
