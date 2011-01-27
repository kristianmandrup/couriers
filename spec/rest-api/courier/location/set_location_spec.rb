require 'spec_helper'
require 'spec/rest-api/courier/location/location_helper'

describe 'Delivery Offer api' do  
  describe 'Post courier Delivery Offer response' do
    let(:host)    { 'http://localhost:3000' }
    let(:service) { "#{host}/couriers/:id/location" }

    include CourierStateHelper

    # courier/state :post
    # REQUEST
    # courier/location :put
    # {
    #   position:   {
    #                     latitude: 150.644,
    #                     longitude: -34.397
    #                 }
    # }  

    # RESPONSE
    # {
    #   position:   {
    #                     latitude: 150.644,
    #                     longitude: -34.397
    #                 }
    # }  
    context 'Courier is available' do
      before :each do
        # Setup courier
        # Courier.create_random 1, :work_state => :available, :number => 1 - Steffan
      end

      it 'should set the current work state to "available" ' do
        response = RestClient.put(service_path(:steffan), location(:steffan))
        response.workstate.should == 'available'
      end

      it 'should set the current work state to "not available" ' do
        response = RestClient.put(service_path(:steffan), location(:steffan))
        response.workstate.should == 'not_available'    
      end
    end
  end
end
