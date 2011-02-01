require 'spec_helper'

describe Person::Name do   
  it "should create a name from options" do
    name = Person::Name.create_for :first_name => 'Michael', :last_name => 'Loehr'
    name.valid?.should be_true    
    name.first_name.should  == 'Michael'
    name.last_name.should   == 'Loehr'
  end
end