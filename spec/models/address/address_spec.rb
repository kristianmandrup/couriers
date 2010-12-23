require 'spec_helper'

def test_blank obj, name 
  obj.errors[name.to_sym].first.should == "can't be blank"  
end

def test_blanks obj, *names 
  names.each {|name| test_blank obj, name }
end


describe Address do
  describe 'Incomplete Address creation' do
    it 'should not create an empty address' do
      a = Address.create
      test_blanks a, :street, :city, :country 
    end

    it 'should not create an Address with only a street' do
      a = Address.create street: 'sgdsgk 12'
      test_blanks a, :city, :country 
    end

    it 'should not create an Address with only a street and city' do
      a = Address.create street: 'sgdsgk 12', city: 'blip'
      test_blanks a, :country 
    end

    it 'should not create an Address with only a city and country' do
      a = Address.create city: 'blip', country: 'USA'
      test_blanks a, :street 
    end
  end
end
