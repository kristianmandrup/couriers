require 'spec_helper'

describe Order::Dropoff do 
  context 'a dropoff' do
    before do
      @dropoff = Order::Dropoff.create_for  
    end

    it "should be a valid dropoff" do
      if !@dropoff.valid?
        puts "errors: #{@dropoff.errors}"
        puts @dropoff.address
        p @dropoff.address
      end      
      @dropoff.should be_valid
    end

    it 'should create a dropoff' do
      @dropoff.address.city.should match('unich')
      @dropoff.contact.full_name.should_not be_blank
    end  
  end
end

