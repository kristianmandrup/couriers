require 'spec_helper'

describe Courier::Counter do 
  it 'should count from 1' do    
    Courier::Counter.reset_numbers
    orig = Courier::Counter.current_number
    counter = Courier::Counter.increment
    counter.should == orig + 1
    counter = Courier::Counter.increment
    counter.should == orig + 2    
  end
end
