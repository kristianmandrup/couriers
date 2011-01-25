module Api
  class DeliveriesController < ActionController::Base
    # before_filter :authenticate_user!

    respond_to :json

    helper Api::DeliveriesHelper
    helper Api::ResponseHelper    

    # Get details about a specific delivery
    # Send back different data depending on the state of the delivery.
    # In accepted state pickup.contact and dropoff.contact are not sent back
    # 
    # courier/deliveries/1/info :get
    # {
    #   id: "1",
    #   state: "accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed"    
    #   travel_mode: "biking|driving",
    #   pickup:   {
    #           location: {
    #                   position:   {
    #                           latitude: 150.644,
    #                           longitude: -34.397
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
    #                           latitude: 150.644,
    #                           longitude: -34.397
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
    def info                 
      # A delivery has ALWAYS been accepted and is owned by a courier
      # hence the delivery should contain all info, including contact info
      begin
        delivery = Delivery.where(:number => delivery_id)
        reply_get delivery, :info
      rescue
        reply_get_error :info
      end
    end

    protected
  
    # Set the state of a specific delivery:
    # 
    # courier/deliveries/1/state :put
    # {
    #   state: "cancelled|arrived_at_pickup|arrived_at_dropoff|billed"
    #   location: {
    #           longitude: -34.397,
    #           latitude: 150.644
    #         }
    # }
    
    # This only works on a delivery "owned" by the current courier
    def update_state         
      begin
        current_courier.deliveries.where(:number => delivery_id)
        # sends delivery offer info without contact information to each courier
        delivery.location = Location.create_from_params location
        delivery.set_state state
        
        reply_update delivery, :info

      rescue
        reply_update_error :state
      end
    end    

  end
end
