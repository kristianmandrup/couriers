require 'spec_helper'

describe PriceStructure do 
  it 'should not create a price structure without a max dimensions' do
    ps = PriceStructure.create :max_weight_kg 3
    ps.errors[:max_dimensions_cm].first.should_not be_nil
  end
  
  it 'should create a price structure with valid weight and dimensions' do
    lambda { PriceStructure.create! :max_weight_kg 3, max_dimensions_cm: '20x30x40'}.should_not raise_error
  end

  it 'should create a price structure with valid weight and dimensions' do
    lambda { PriceStructure.create! :max_weight_kg 3, max_dimensions_cm: '20x30x40', base_price: 4 }.should_not raise_error
  end

  it 'should create a price structure with valid weight and dimensions' do
    lambda { PriceStructure.create! :max_weight_kg 3, max_dimensions_cm: '20x30x40', base_price: 4, km_price: 2 }.should_not raise_error
  end

  it 'should create a price structure with valid weight and dimensions' do
    lambda { PriceStructure.create! :max_weight_kg 3, max_dimensions_cm: '20x30x40', base_price: 4, km_price: 2, km_point: 2 }.should_not raise_error
  end

  it 'should create a price structure with valid weight and dimensions' do
    lambda { PriceStructure.create! :max_weight_kg 3, max_dimensions_cm: '20x30x40', base_price: 4, km_price: 2, km_point: 2, cost_per_stop: 3 }.should_not raise_error
  end

  it 'should create a price structure with valid weight and dimensions' do
    lambda { PriceStructure.create! :max_weight_kg 3, max_dimensions_cm: '20x30x40', base_price: 4, km_price: 2, km_point: 2, cost_per_stop: 3, waiting_time: 3 }.should_not raise_error
  end

  it 'should create a price structure with valid weight and dimensions' do
    lambda { PriceStructure.create! :max_weight_kg 3, max_dimensions_cm: '20x30x40', base_price: 4, km_price: 2, km_point: 2, cost_per_stop: 3, waiting_time: 3, unsuccessful_delivery: 3 }.should_not raise_error
  end

  it 'should create a price structure with valid weight and dimensions' do
    lambda { PriceStructure.create! :max_weight_kg 3, max_dimensions_cm: '20x30x40', base_price: 4, km_price: 2, km_point: 2, cost_per_stop: 3, waiting_time: 3, unsuccessful_delivery: 3, currency: 'usd' }.should_not raise_error
  end
end
