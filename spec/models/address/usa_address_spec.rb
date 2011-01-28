require 'spec_helper'

describe Address::Usa do
  describe 'Incomplete Address creation' do    
    it 'should not create an American with only a street and zip_code' do
      lambda { Address::Usa.create! street: 'sgdsgk 12', zip_code: 123456 }.should raise_error
    end

    it 'should create an American without a state' do
      lambda { Address::Usa.create! street: 'sgdsgk 12', zip_code: 123456, city: 'N.Y' }.should raise_error
    end

    it 'should not create an American without a city' do
      lambda { Address::Usa.create! street: 'sgdsgk 12', zip_code: 123456, state: 'N.Y' }.should raise_error
    end

    it 'should not create an American without a street' do
      lambda { Address::Usa.create! zip_code: 123456, city: 'N.Y', state: 'NY' }.should raise_error
    end
    
    it 'should not create an American address with a postnr' do
      lambda { Address::Usa.create! street: 'sgdsgk 12', postnr: '123456', city: 'N.Y', state: 'XY' }.should raise_error
    end    

    it 'should not create an American address with a province' do
      lambda { Address::Usa.create! street: 'sgdsgk 12', zip_code: 123456, city: 'N.Y', province: 'XY' }.should raise_error
    end    
  end

  describe 'Invalid address attributes' do  
    it 'should not create an American address with an invalid (too short) zip_code' do
      lambda { Address::Usa.create! street: 'sgdsgk 12', zip_code: 1234, city: 'N.Y', state: 'XY' }.should raise_error
    end

    it 'should not create an American address with an invalid (too long) zip_code' do
      lambda { Address::Usa.create! street: 'sgdsgk 12', zip_code: 1234567, city: 'N.Y', state: 'XY' }.should raise_error
    end
  end

  describe 'Valid address creations' do
    it 'should create an American address' do
      address_1 = Address::Usa.create! street: 'sgdsgk 12', zip_code: 123456, city: 'N.Y', state: 'NY'
      address_1.street.should == 'sgdsgk 12'
      address_1.country.should == 'USA'      
    end
  end
end
