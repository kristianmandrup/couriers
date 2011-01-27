require 'spec_helper'

describe Order::Booking do 
  context "Random booking from munich" do
    before do
      @booking = Order::Booking.create_empty_from :munich      
    end 

    it "should not have a description" do
      @booking.package_description.should be_nil
    end       

    it "should have an empty pickup" do
      @booking.pickup.should_not be_nil
    end       

    it "should have an empty dropoff" do
      @booking.dropoff.should_not be_nil
    end
  end
  
  context "Random booking from munich" do
    before do
      @booking = Order::Booking.create_from :munich
    end

    it "should have a random description" do
      @booking.package_description.should_not be_nil
    end

    it "should have a random pickup" do
      @booking.pickup.should_not be_nil
    end

    it "should have a random dropoff" do
      @booking.dropoff.should_not be_nil
    end
  end
end


