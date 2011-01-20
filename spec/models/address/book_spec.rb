require 'spec_helper'

describe Address::Book do
  describe 'Incomplete Address creation' do
    it 'should create an empty address book' do
      Address::Book.delete_all
      book = Address::Book.create
      book.addresses.size.should == 0      
      book.addresses << Address.create_from(:munich)
      book.addresses.size.should == 1
      p book.addresses
    end 
  end
end
