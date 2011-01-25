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
  # Create new delivery offer and pushes it to the selected couriers 
  # Also use the zip of the pickup to find Companies who subscribe to that zip and send offer to those companies
  def create
    session[:couriers_selected] = couriers_selected

    delivery_offer = Delivery::Offer.create_for(current_booking, couriers_selected)

    # sends delivery offer info without contact information to each courier
    couriers_to_notify.each do |id|
      p "sending deliver info to delivery channel for courier: #{id}"
      courier_channel(id).publish :directions => '3,5km to...', :delivery_offer => delivery_offer.for_json
    end

    redirect_to wait_for_couriers_response_path    
  end    
    
  def couriers_to_notify
    couriers_to_notify = couriers_selected + courier_companies_subscribing_to_zip(current_booking.zip)
  end  
end