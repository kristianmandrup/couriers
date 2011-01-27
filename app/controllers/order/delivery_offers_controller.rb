module Order                     
  # waiting screen (awaiting biddings)
  # :show - display delivery offer and real time status of delivery responses from couriers
  # when accepted then redirect to payment#new (new payment)
  # if not accepted redirect to booking#new
  # resources :delivery_offer, :only => [:show]
  
  class DeliveryOffersController < ApplicationController 
    # Creates a delivery from an accepted Delivery Offer (from waiting screen)

    # Pushes new delivery from server to client
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
    def show
      # sends delivery offer info without contact information to each courier
      couriers_to_notify.each do |id|
        p "sending deliver info to delivery channel for courier: #{id}"
        courier_channel(id).publish :directions => '3,5km to...', :delivery_offer => delivery_offer.for_json
      end
    end    

    protected
    
    def couriers_to_notify
      couriers_to_notify = couriers_selected + courier_companies_subscribing_to_zip(current_booking.zip)
    end  
  end
end