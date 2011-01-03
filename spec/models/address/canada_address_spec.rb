require 'spec_helper'

describe 'Address::Canada' do
  describe 'Incomplete Address creation' do
    it 'should not create a Canadian with only a street and zip_code' do
      lambda { Address.create_canada street: 'sgdsgk 12', zip_code: 123456 }.should raise_error
    end

    it 'should not create a Canadian without a state' do
      lambda { Address.create_canada street: 'sgdsgk 12', zip_code: 123456, city: 'N.Y' }.should raise_error
    end

    it 'should not create a Canadian without a city' do
      lambda { Address.create_canada street: 'sgdsgk 12', province: '123456', province: 'N.Y' }.should raise_error
    end

    it 'should not create a Canadian without a street' do
      lambda { Address.create_canada zip_code: 123456, city: 'N.Y', province: 'NY' }.should raise_error
    end
    
    it 'should not create a Canadian address with a postnr' do
      lambda { Address.create_canada street: 'sgdsgk 12', postnr: '123456', city: 'N.Y', province: 'XY' }.should raise_error
    end    

    it 'should not create a Canadian address with a state' do
      lambda { Address.create_canada street: 'sgdsgk 12', zip_code: 123456, city: 'N.Y', state: 'XY' }.should raise_error
    end    
  end

  describe 'Invalid address attributes' do  
    it 'should not create a Canadian address with an invalid (too short) zip_code' do
      lambda { Address.create_canada street: 'sgdsgk 12', zip_code: 1234, city: 'N.Y', province: 'XY' }.should raise_error
    end

    it 'should not create a Canadian address with an invalid (too long) zip_code' do
      lambda { Address.create_canada street: 'sgdsgk 12', zip_code: 1234567, city: 'N.Y', province: 'XY' }.should raise_error
    end
  end

  describe 'Valid address creations' do
    it 'should create a Canadian address' do
      address_1 = Address.create_canada street: 'sgdsgk 12', zip_code: 123456, city: 'N.Y', province: 'Alberta'
      address_1.street.should == 'sgdsgk 12'
      address_1.country.should == 'Canada'
    end
  end
end
