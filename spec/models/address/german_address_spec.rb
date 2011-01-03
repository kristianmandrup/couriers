require 'spec_helper'

describe 'Address::Germany' do
  describe 'Incomplete Address creation' do
    it 'should not create a German with only a street and postnr' do
      lambda { Address::Germany.create! street: 'sgdsgk 12', postnr: 123456 }.should raise_error
    end

    it 'should not create a German without a street' do
      lambda { Address::Germany.create! postnr: 123456, city: 'Berlin' }.should raise_error
    end
    
    it 'should not create a German address with a zip_code' do
      lambda { Address::Germany.create! street: 'sgdsgk 12', zip_code: 123456, city: 'Berlin' }.should raise_error
    end    
  end

  describe 'Invalid address attributes' do  
    it 'should not create a German address with an invalid (too short) postnr' do
      lambda { Address::Germany.create! street: 'sgdsgk 12', postnr: 1234, city: 'Berlin' }.should raise_error
    end

    it 'should not create a German address with an invalid (too long) postnr' do
      lambda { Address::Germany.create! street: 'sgdsgk 12', postnr: 1234567, city: 'Berlin' }.should raise_error
    end
  end

  describe 'Valid address creations' do
    it 'should create a German address' do
      address_1 = Address::Germany.create! street: 'sgdsgk 12', postnr: 123456, city: 'Berlin'
      address_1.street.should == 'sgdsgk 12'
      address_1.country.should == 'Germany'    
    end
  end
end
