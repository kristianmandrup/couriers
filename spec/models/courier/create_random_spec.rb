require 'spec_helper'

describe Courier do 
  # it "should create random couriers" do
  #   available = Courier.create_random 5, :from => :munich, :work_state => 'available'
  #   puts available.map(&:work_state)    
  #       
  #   not_available = Courier.create_random 3, :from => :munich, :work_state => 'not_available'
  #   puts not_available.map(&:work_state)        
  # end
  
  it "should create steffan" do
    Courier::Counter.reset_numbers
    
    steffan = Courier.create_random(1, :work_state => :available).first # Steffan
    
    p steffan
    p steffan.inspect

    p "-----------------------"
    p "One random"
    p "-----------------------"
    steffan = Courier.create_one_random(:work_state => :available) # Steffan    
    p steffan
    
    # steffan.number.should == 1    
    # steffan.delivery.should be_nil
    # steffan.work_state.should == 'available'    
    # 
    # matthias = Courier.create_random 1, :work_state => :available # 2 Matthias
    # matthias.delivery = Delivery.create_from(:munich).state = 'accepted'
    # 
    # matthias.number.should == 1
    # matthias.work_state.should == 'available'        
    # matthias.delivery.state.should == 'accepted'
    # 
    # barbie = Courier.create_random 1, :work_state => :not_available, :number => 3 # Barbie
    # barbie.number.should == 1
    # barbie.work_state.should == 'available'            
  end
end

