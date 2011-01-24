require 'spec_helper'

describe Courier do 
  it "should create random couriers" do
    available = Courier.create_random 5, :from => :munich, :work_state => 'available'
    puts available.map(&:work_state)    
        
    not_available = Courier.create_random 3, :from => :munich, :work_state => 'not_available'
    puts not_available.map(&:work_state)        
  end
end

