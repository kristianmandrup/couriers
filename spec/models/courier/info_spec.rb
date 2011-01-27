require 'spec_helper'

describe Courier::Info do 
  describe 'Generate random couriers' do  
    context 'Default info (without delivery)' do
      before do
        @info = Courier::Info.new 
      end

      it "workstate should be 'available' " do
        @info.available?.should be_false
      end

      it "travel mode should be 'driving' " do
        @info.travel_mode.should == 'driving'
      end
    end
    
    context 'Info with delivery from Munich and available' do
      before do                                        
        @delivery = Delivery.create_from :munich
        @info = Courier::Info.new :current_delivery => @delivery, :available => true
      end

      it "current delivery should be set correctly" do
        @info.current_delivery.should == @delivery
      end

      it "workstate should be 'available' " do
        @info.work_state.should == 'available'
        @info.available?.should be_true
      end

      it "travel mode should be 'driving' " do
        @info.travel_mode.should == 'driving'
      end
    end
  end
end
