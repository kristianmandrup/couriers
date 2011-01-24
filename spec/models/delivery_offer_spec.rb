require 'spec_helper'

describe Delivery::Offer do 
  before do
    @booking = Order::Booking.create_from :munich
    @couriers = Courier.create_random 3
  end

  it 'should create a new delivery offer from a city' do
    offer = Delivery::Offer.create_from :munich
    puts "offer: #{offer}"
  end
  
  it 'should create a new delivery offer from a booking' do
    offer = Delivery::Offer.create_from_booking @booking
    puts "offer: #{offer}"
  end

  it 'should create a new delivery offer from a booking and then set courier requests' do
    offer = Delivery::Offer.create_from_booking @booking
    offer.for_couriers @couriers
    puts "offer: #{offer}"
  end
  
  it 'should create a new delivery offer' do    
    offer = Delivery::Offer.create_for @booking, @couriers
    puts "offer: #{offer}"    
    puts "booking: #{offer.booking}"
    puts "requests: #{offer.delivery_requests}"
  end
end
