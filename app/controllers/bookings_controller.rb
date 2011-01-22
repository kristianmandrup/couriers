class BookingsController < ApplicationController 

  # InheritedResources::Base

  def new
    @booking = session[:booking]
    @available_couriers = Courier.available
    @your_location = Location.create_from session[:location]
  end   

  # Push new delivery from server to client
  # 
  # channel: tiramizoo-courier-delivery
  # {
  #     action: "new_delivery",
  #     data: {
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
  #                                     }
  #                         notes: "Big box"
  #                     }
  #             }
  # }
  # --------------------------------------------------------------------------------  
  def update        
    TiramizooApp.pubnub.publish({
        'channel' => 'tiramizoo-courier-delivery',
        'message' => message        
    }) 
    
    redirect_to new_booking_path    
  end
  
  protected
  
  def message
    {
      directions: "3,5km to target",
      pickup: Order::Pickup.create_from(:munich).for_json,
      dropoff: Order::Dropoff.create_from(:munich).for_json, 
    }
  end    
end
