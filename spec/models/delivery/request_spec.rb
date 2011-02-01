require 'spec_helper'

describe Delivery::Request do 
  context 'Delivery::Request for first courier' do
    before do
      # @offer = Delivery::Offer.create_from :munich
      @couriers = Courier.create_random 3
      @request = Delivery::Request.create_for @couriers.first
    end

    # it "should be valid and should be able to save it" do      
    #   @offer.delivery_requests << @request
    # end

    it "should start with state :notified" do      
      @request.state.should == 'notified'
    end

    it "should start with state :notified" do      
      @request.courier.should == @couriers.first
    end

    it "should be valid and should be able to save it" do      
      @request.time_notified.should <= Time.now
      @request.time_notified.should > (Time.now - 1.minute)
    end
  end
end



