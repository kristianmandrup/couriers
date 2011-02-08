require 'spec_helper'

describe Order::Booking do 
  context "Random booking from munich" do
    before do
      @booking = Order::Booking.create_empty
    end 

    it "should not have a description" do
      @booking.description.should be_nil
    end       

    it "should have an empty pickup" do
      @booking.pickup.should_not be_nil
    end       

    it "should have an empty dropoff" do
      @booking.dropoff.should_not be_nil
    end
    
    it "should have an empty pickup street" do
      puts @booking.pickup
      @booking.pickup.street.should be_nil
    end           

    it "should have an empty dropoff street" do
      @booking.dropoff.street.should be_nil
    end
  end
  
  context "Random booking from munich" do
    before do
      @booking = Order::Booking.create_for
    end

    it "should be a valid booking" do
      if !@booking.valid?
        puts "errors: #{@booking.errors}"
      end      
      @booking.should be_valid
    end

    it "should have a random description" do
      @booking.description.should_not be_nil
    end

    it "should have a random pickup" do
      @booking.pickup.should_not be_nil
    end

    it "should have a random dropoff" do
      @booking.dropoff.should_not be_nil
    end
  end
end


