module Api
  class DeliveriesController < ActionController::Base
    before_filter :authenticate_user!

    respond_to :json

    # Get details about a sepcific delivery
    # 
    # courier/deliveries/1/state :get
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
  
    # TODO: should use built-in #courier method
    def show
      @delivery = current_user.deliveries.find(params[:id])
      respond_with(@delivery)
    end

    def index
      @deliveries = current_user.deliveries
      respond_with(@deliveries)
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
    def update
      post_data = request.body.read
      json_data = JSON.parse(post_data) 
      delivery = current_user.deliveries.find(:id => params[:id])
    
      delivery.location = json_data[:location]    
      delivery.state    = json_data[:state]
    end    
  end
end
