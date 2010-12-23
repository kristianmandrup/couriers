require 'spec_helper'

describe Bicycle do
  it 'should create a Bicycle with a count of 1 if no count given' do
    bicycle = Bicycle.create
    car.name.should == 'Bicycle'    
    bicycle.count.should == 1
  end

  it 'should create a Bicycle with a count of 3' do
    bicycle = Bicycle.create count: 3 
    bicycle.count.should == 3
  end
end  

describe Car do
  it 'should create a Car with a count of 1 if no count given' do
    car = Car.create
    car.name.should == 'Car'
    car.count.should == 1    
  end

  it 'should create a Car with a count of 3' do
    car = Car.create count: 3 
    car.count.should == 3
  end
end  

