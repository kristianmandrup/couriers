require 'spec_helper'
require 'spec/rest-api/courier/state_helper'

describe 'Courier state api' do  
  describe 'Set courier work state' do
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

    context 'Courier is NOT available' do
      before :each do
        # Setup courier
        # Courier.create_random 1, :work_state => :not_available, :number => 3 - Barbie
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