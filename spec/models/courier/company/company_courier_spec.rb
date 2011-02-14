require 'spec_helper'

describe Courier::Company do 
  context 'A random courier company from munich' do
    before do
      @courier = Courier::Company.create_from :munich
    end

    it "should be valid and should be able to save it" do    
      if !@courier.valid?
        p "errors: #{@courier.errors}"
      end
      @courier.valid?.should be_true
      lambda { @courier.save! }.should_not raise_error
    end

    it "should have a positive number" do    
      @courier.number.should > 0
    end

    it "should have a company" do    
      @courier.company.should_not be_nil
    end
    
    it "should have a valid travel mode" do
      @courier.travel_mode.should match /\S+/
    end
    
    it "should be available" do
      @courier.available?.should be_true
    end

    it "should have a name" do
      @courier.name.should match /\S+/
    end

    it "should have an address" do
      address = @courier.address

      address.should_not be_nil 
      address.street.should match /\S+/
      address.city.should match /\S+/
      address.country.should match /\S+/
    end

    it "should have a location" do
      location = @courier.location
      location.should_not be_nil 
      location.latitude.should_not be_nil 
      location.longitude.should_not be_nil
    end
  end
end

    
