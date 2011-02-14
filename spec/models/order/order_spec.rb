require 'spec_helper'

describe Order do 
  before do
    @delivery = Order.create_for
  end

  it 'should create a new valid order' do
    if !@delivery.valid?
      puts "errors: #{@delivery.errors}"
    end
    @delivery.should be_valid
  end

  it 'should have a positive number' do
    @delivery.number.should > 0
  end

  it 'should have a state' do
    @delivery.state.should_not be_blank
  end
end