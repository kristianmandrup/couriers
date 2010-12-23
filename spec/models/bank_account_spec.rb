require 'spec_helper'

describe BankAccount do 
  describe 'Incomplete company' do
    it 'should not create company without a name' do
      lambda { BankAccount.create! }.should raise_error
    end
    
    it 'should not create company with a name of one letter' do
      lambda { BankAccount.create! name: 'A' }.should raise_error
    end

    it 'should not create company with a name of one letter when trimmed' do
      lambda { BankAccount.create! name: ' A ' }.should raise_error
    end        
  end
  
  it 'should create a company with a name and a German address' do
    company = Company.create name: 'Alpha'
    company.address = GermanAddress.create! street: 'sgdsgk 12', postnr: 123456, city: 'Berlin'
    company.address.should_not be_nil
  end
end
