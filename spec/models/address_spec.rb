require 'spec_helper'

describe Address do
  it 'should create an American address' do
    address_1 = Address.create street: 'sgdsgk 12', zip: '123456', city: 'N.Y', state: 'NY', country: 'USA'
    puts address_1.inspect
  end

  it 'should not create an American address with an invalid state' do
    address_1 = Address.create street: 'sgdsgk 12', zip: '123456', city: 'N.Y', state: 'XY', country: 'USA'
    puts address_1.inspect
  end

  it 'should not create an American address with a postnr' do
    address_1 = Address.create street: 'sgdsgk 12', zip: '123456', city: 'N.Y', state: 'XY', country: 'USA'
    puts address_1.inspect
  end

  it 'should not create an American address without a zip' do
    address_1 = Address.create street: 'sgdsgk 12', city: 'N.Y', state: 'XY', country: 'USA'
    puts address_1.inspect
  end
  
  # ...

  it 'should create an German address' do
    address_2 = Address.create street: 'sgdsgk 12', postnr: '12345', city: 'Berlin', country: 'Germany'
    puts address_2.inspect
  end
end
