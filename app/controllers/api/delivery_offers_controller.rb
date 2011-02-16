module Api
  class DeliveryOffersController < ActionController::Base
    # before_filter :authenticate_user!

    respond_to :json  

    include Api::CouriersHelper
    include Api::DeliveriesHelper
    include Api::ResponseHelper    

    # Set response for a specific delivery offer:
    # 
    # couriers/:id/delivery_offers/:delivery_id/response :put
    # REQUEST
    # {
    #   response: "accepted|declined"
    # }

    # RestClient.put('http://localhost:3000/api/couriers/1/delivery_offers/1/answer.json', response: 'accepted')

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
        puts "params: #{params}"
        puts "state: #{p_answer}, courier id: #{courier_id}"

        booking = Customer::Order::Booking.create_from :munich

        couriers = Courier.limit(3)

        delivery_offer = Delivery::Offer.create_for_couriers_only couriers
        
        puts "delivery_offer: #{delivery_offer}"

        delivery_offer.set_state(p_answer, current_courier)

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
