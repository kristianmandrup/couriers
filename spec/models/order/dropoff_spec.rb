require 'spec_helper'

describe Order::Dropoff do 
  it "should create random dropoff" do
    dropoff = Order::Dropoff.create_from
    puts dropoff.inspect
    puts dropoff.address.inspect
    puts dropoff.contact.inspect
  end
end


