require 'spec_helper'

describe Delivery::Offer do 
  context 'Offer from Munich' do
    before do
      @offer = Delivery::Offer.create_for @couriers
    end

    it "should be valid and should be able to save it" do
      if !@offer.valid?
        p "errors: #{@offer.errors}"
      end
      @offer.valid?.should be_true
      lambda { @offer.save! }.should_not raise_error
    end
  end
  
  context 'Offer with a Booking' do
    before do  
      @booking = Order::Booking.create_empty
      @couriers = Courier.create_random 3
      @offer = Delivery::Offer.create_for @couriers, :booking => @booking
    end
    
    it 'should create a new delivery offer from a booking' do
      @offer.valid?.should be_true
    end    
  end 
end
