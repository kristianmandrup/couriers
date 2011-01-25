require 'spec_helper'
require 'spec/rest-api/delivery/info_helper'

describe 'Delivery info api' do
  let(:host)    { 'http://localhost:3000' }
  let(:service) { "#{host}/couriers/:id/deliveries/:delivery_id/info" }

  include DeliveryInfoHelper

  # Get INFO about a specific delivery for a specific courier 
  # 
  # [HOST]/couriers/:id/current_delivery/:delivery_id/info :get
  #   :id of courier
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
  it 'should get the state of a specific delivery' do
    response = RestClient.get(*delivery_info_args(:rolf))

    response.id.should == '1'
    response.directions.should == '3,5km to target'

    address = response.pickup.location.address
    address.street.should match /Sendlinger/
    address.zip.should == '80331'
    
    contact = response.pickup.contact    
    contact.name.should == 'Philipp Walz'
    contact.email.should == 'philipp.walz@tiramizoo.com'

    response.notes.should == 'Big box'    
  end
end
  
