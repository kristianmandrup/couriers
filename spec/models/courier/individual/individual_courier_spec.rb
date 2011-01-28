require 'spec_helper'

describe Courier::Individual do 
  describe 'Create random courier' do
    context 'A random courier from Munich' do
      before do
        @courier = Courier::Individual.create_from :munich
      end

      it "should be valid and should be able to save it" do    
        if !@courier.valid?
          p "errors: #{@courier.errors}"
        end
        @courier.valid?.should be_true
        @courier.save
        # lambda { @courier.save! }.should_not raise_error
      end

      it "should have a positive number" do    
        @courier.number.should > 0
      end
      
      it "should have a valid travel mode" do
        @courier.travel_mode.should match /\S+/
      end
      
      it "should not be available" do
        @courier.available?.should be_false
      end

      it "should have a person" do    
        @courier.person.should_not be_nil
      end

      it "should have a full name" do
        @courier.full_name.should match /\S+/
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
end                    
