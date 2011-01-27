require 'spec_helper'
require 'spec/rest-api/delivery_offer/response_helper'

describe 'Delivery Offer api' do  
  describe 'Post courier Delivery Offer response' do
    let(:host)    { 'http://localhost:3000' }
    let(:service) { "#{host}/couriers/:id/state" }

    include CourierStateHelper

    # courier/state :post
    # REQUEST
    # {
    #   work_state: "available|not_available"
    # }

    # RESPONSE
    # {
    #   work_state: "available|not_available"
    # }      
    context 'Courier is available' do
      before :each do
        # Setup courier
        # Courier.create_random 1, :work_state => :available, :number => 1 - Steffan
      end

      it 'should set the current work state to "available" ' do
        response = RestClient.put(service_path(:steffan), available(:steffan))
        response.workstate.should == 'available'
      end

      it 'should set the current work state to "not available" ' do
        response = RestClient.put(service_path(:steffan), available(:steffan))
        response.workstate.should == 'not_available'    
      end
    end
  end
end
