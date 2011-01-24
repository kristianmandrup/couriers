require 'spec_helper'

describe Order::Waybill do 
  it "should create random waybill" do
    waybill = Order::Waybill.create_from
    puts waybill.inspect
    puts waybill.booking.inspect
  end
end


