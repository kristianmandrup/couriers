require 'spec_helper'

require 'spec_helper'

describe Courier do   
  describe 'Generate random couriers' do  
    context '10 random couriers generated' do
      before do
        @couriers = Courier.create_random 10, :from => :munich, :work_state => 'available'
        @courier = @couriers.first
      end
    
      it "should be valid and should be able to save it" do    
        if !@courier.valid?
          p "errors: #{@courier.errors}"
        end
        @courier.valid?.should be_true
        lambda { @courier.save! }.should_not raise_error
      end

      it "should create 10 couriers" do
        @couriers.size.should == 10
      end

      it "first courier should be a valid courier" do
        @courier.name.should_not be_nil
        @courier.address.should_not be_nil
        @courier.location.should_not be_nil
      end
    end
  end

  it "should create random courier" do
    Courier::Counter.reset_numbers
    
    steffan = Courier.create_random(1, :work_state => :available).first # Steffan
    if !steffan.valid?
      p "errors: #{steffan.errors}"
    end
    steffan.valid?.should be_true
    lambda { steffan.save! }.should_not raise_error
    
    p steffan
    p steffan.inspect

    p "-----------------------"
    p "One random"
    p "-----------------------"
    steffan = Courier.create_one_random(:work_state => :available) # Steffan    
    p steffan
    
    # steffan.number.should == 1    
    # steffan.delivery.should be_nil
    # steffan.work_state.should == 'available'    
    # 
    # matthias = Courier.create_random 1, :work_state => :available # 2 Matthias
    # matthias.delivery = Delivery.create_from(:munich).state = 'accepted'
    # 
    # matthias.number.should == 1
    # matthias.work_state.should == 'available'        
    # matthias.delivery.state.should == 'accepted'
    # 
    # barbie = Courier.create_random 1, :work_state => :not_available, :number => 3 # Barbie
    # barbie.number.should == 1
    # barbie.work_state.should == 'available'            
  end
end

