require 'spec_helper'

describe Courier::Vehicle do
  context 'Bike' do
    describe 'Create a bike' do
      it 'should create a bike with a count of 1' do
        bike = Courier::Vehicle.create_bike
        bike.name.should == 'bike'    
        bike.count.should == 1
      end
    end
  
    describe 'Create multiple bikes' do  
      it 'should create a bike with a count of 3' do
        bikes = Courier::Vehicle.create_bikes 3 
        bikes.count.should == 3
      end
    end
  end

  context 'Car' do  
    describe 'Create a car' do
      it "should create a car" do
        car = Courier::Vehicle.create_car
        car.name.should == 'car'
        car.to_s.should == 'a Car'
        car.count.should == 1    
      end
    end

    describe 'Create multiple cars' do  
      it "should create 3 cars" do
        cars = Courier::Vehicle.create_cars 3 
        cars.to_s.should == '3 Cars'        
        cars.count.should == 3
      end
    end
  end
end


