require 'spec_helper'

describe Order::Pickup do 
  it "should create random pickup" do
    pickup = Order::Pickup.create_from
    puts pickup.inspect
    puts pickup.address.inspect
    puts pickup.contact.inspect
  end
end


