require 'spec_helper'

describe Order::Counter do 
  context "New counter" do
    before do
      @counter = Order::Counter.instance
      Order::Counter.reset_numbers
    end 

    it "should have number == 0" do
      @counter.number.should == 0
    end

    it "should have booking_number == 0" do
      @counter.booking_number.should == 0
    end       

    it "should have delivery_number == 0" do
      @counter.delivery_number.should == 0
    end
  end
end