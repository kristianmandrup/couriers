require 'spec_helper'

describe Order::Quote do 
  it "should create random quote" do
    quote = Order::Quote.create_from
    puts quote.inspect
  end

  it "should create a random quote" do
    quote = Order::Quote.create_for
    puts quote.inspect
  end
end


