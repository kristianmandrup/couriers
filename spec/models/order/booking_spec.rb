require 'spec_helper'

describe Order::Booking do 
  it "should create random booking" do
    booking = Order::Booking.create_from
    puts "Booking: #{booking}"
  end
end


