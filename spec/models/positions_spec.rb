require 'spec_helper'

describe 'Positions' do
  it 'should create positions for couriers' do
    couriers = Courier.available.extend Positionable
    couriers_positions =couriers.positions.map(&:for_json)
    # p couriers.inspect
    p couriers_positions.to_json
  end
end