require 'spec_helper'

describe Courier::Delivery do 
  it 'should create a delivery' do    
    
    Courier::Delivery.create
    
    orig = Courier::Counter.current_number
    counter = Courier::Counter.increment
    counter.should == orig + 1
    counter = Courier::Counter.increment
    counter.should == orig + 2    
  end
end
