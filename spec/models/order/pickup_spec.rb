require 'spec_helper'

describe Order::Pickup do 
  context 'a pickup' do
    before do
      @pickup = Order::Pickup.create_for  
    end

    it "should be a valid pickup" do
      if !@pickup.valid?
        puts "errors: #{@pickup.errors}"
        puts @pickup.address
        p @pickup.address
      end      
      @pickup.should be_valid
    end

    it 'should create a pickup' do
      @pickup.address.city.should match('unich')
      @pickup.contact.full_name.should_not be_blank
    end  
  end
end

