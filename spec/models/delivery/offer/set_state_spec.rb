require 'spec_helper'

describe Delivery::Offer do 
  context 'A delivery offer' do
    before do
      @couriers = Courier.create_random 3
      @offer    = Delivery::Offer.create_for @couriers
      
      @courier_1 = @couriers.first
      @courier_2 = @couriers[1]
      @courier_3 = @couriers[2]
    end

    it "should be valid and should be able to save it and be valid after save" do    
      if !@offer.valid?
        p "errors: #{@offer.errors}"
      end
    
      lambda {@offer.save!}.should_not raise_error
    
      @offer.state.should == 'ready'
    end

    it "should set state to accepted for first courier to accept" do
      
      @offer.set_courier_state @courier_1, :accepted
      @offer.state.should == 'accepted'
      @offer.accepted_courier.should == @courier_1
    end

    it "should raise an error when second courier accepts after offer is already accepted" do      
      lambda {@offer.set_courier_state @courier_2, :accepted}.should raise_error(DeliveryAlreadyTakenError)
    end

    it "should not change accepted courier when second courier accepts" do            
      @offer.state.should == 'accepted'      
      @offer.accepted_courier.should == @courier_2
    end

    it "should raise timeout exception when courier responds too late" do            
      Timecop.travel(1.min.from_now) do
        lambda {@offer.set_courier_state @courier_3, :accepted }.should raise_error(DeliveryTimeOutError)
      end
    end
  end
end