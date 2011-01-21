require 'spec_helper'

describe 'Pickup' do 
  it 'should create a Pickup' do
    
    pickup = Order::Pickup.create_from
    pickup.address.city.should == 'Munich'
    pickup.contact.name.should_not be_empty
  end
  
  it "should turn pickup into json" do
    p Order::Pickup.create_from(:munich).for_json
  end

  it "should turn dropoff into json" do
    p Order::Dropoff.create_from(:munich).for_json
  end
end
