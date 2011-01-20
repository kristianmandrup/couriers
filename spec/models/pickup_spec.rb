require 'spec_helper'

describe Pickup do 
  it 'should create a Pickup' do
    
    pickup = Pickup.create_from
    pickup.city.should == 'Munich'
    pickup.contact.name.should_not be_empty
  end
end
