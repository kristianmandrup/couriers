require 'spec_helper'

describe Courier do 
  describe 'Generate random couriers' do  
    context '10 random couriers generated' do
      before do
        @couriers = Courier.create_random 10, :from => :munich, :work_state => 'available'
      end
    
      it "should create 10 couriers" do
        @couriers.size.should == 10
      end

      it "first courier should be a valid courier" do
        courier = @couriers.first
        courier.name.should_not be_nil
        courier.address.should_not be_nil
        courier.location.should_not be_nil
      end
    end
  end
end
