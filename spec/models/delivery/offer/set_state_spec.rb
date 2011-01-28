require 'spec_helper'

describe Delivery::Offer do 
  context 'A delivery offer' do
    before do
      @offer = Delivery::Offer.create_from :munich
    end

    it "should set state to accepted" do
      @offer.state = "accepted"
    end

    it "should be valid and should be able to save it and be valid after save" do    
      if !@offer.valid?
        p "errors: #{@offer.errors}"
      end
    
      lambda {@offer.save!}.should_not raise_error
    
      @offer.state.should == "accepted"
    end
  end
end