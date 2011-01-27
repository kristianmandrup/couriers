require 'spec_helper'
require 'spec/rest-api/api_helper'
require 'spec/rest-api/courier/info/info_helper'

describe 'Courier info' do
  let(:host)    { 'http://localhost:3000' }
  let(:service) { "#{host}/couriers/:id/info" }

  include CourierInfoHelper

  describe 'Get courier info' do  
    # Note: The Courier::State contains both the workstate and delivery info
    # couriers/1/state :get
    # REQUEST
    # {
    #     id: "1" # courier number
    #     work_state: "available|not_available",
    #     travel_mode: "biking|driving",
    #     current_delivery: > courier/deliveries/{current_delivery_id}/info
    # }
    # RESPONSE
    # {  
    #   status: {
    #     code: 'OK'
    #   },
    #   work_state: "available|not_available"
    #   current_delivery:   {
    #     state: "ready|accepted|cancelled|arrived_at_pickup|arrived_at_dropoff|billed",
    #     id: "1"
    #   }
    # }    
    
    # NOTE: current_delivery only makes sense when the courier is available and has a delivery
    # should thus not be sent back when the courier is NOT available or does NOT currently have a delivery
    
    context 'Courier is available and is biking' do
      context 'Courier does NOT have a delivery'
        before :each do
          # Setup courier
          # Courier.create_random 1, :work_state => :available, :vehicle => 'bike', :number => 1 # Steffan
          Courier.create_random 1, :work_state => :available, :number => 1 # Steffan
        end

        it 'should get OK and work state "available" ' do
          response = RestClient.get(service_path :steffan)
          response.status.code.should == 'OK'
          response.workstate.should == 'available'
          response.current_delivery.should_not be_empty
        end

        it 'should get OK and work state "available" ' do
          response = RestClient.get(service_path :steffan)
          response.status.code.should == 'OK'
          response.workstate.should == 'available'
          response.current_delivery.should_not be_empty
        end
      end 
      context 'Courier has a delivery' do
        before :each do
          # Setup courier with delivery 
          # courier_2 = Courier.create_random 1, :work_state => :available, :vehicle => 'bike', :number => 2 # Matthias
          courier_2 = Courier.create_random 1, :work_state => :available, :number => 2 # Matthias
          courier_2.delivery = Delivery.create_from(:munich).state = 'accepted'
        end

        it 'should get OK and work state "available" and delivery state' do
          response = RestClient.get(service_path :steffan)
          response.status.code.should == 'OK'
          response.workstate.should == 'available'
          response.current_delivery.state.should_not be_empty
          response.current_delivery.id.should_not be_empty          
        end
      end      
    end

    context 'Courier IS NOT available' do
      before :each do
        # Setup courier
        # courier_3 = Courier.create_random 1, :work_state => :not_available, :vehicle => 'bike', :number => 3 # Barbie
        courier_3 = Courier.create_random 1, :work_state => :not_available, :number => 3 # Barbie
      end

      # NOTE: current_delivery only makes sense when the courier is available and 
      # should thus not be sent back when the courier is NOT available      
      it 'should get OK and work state "not_available" ' do
        response = RestClient.get(service_path :steffan)
        response.status.code.should == 'OK'
        response.workstate.should == 'not_available'
        response.current_delivery.should be_empty
      end
    end
  end
end

