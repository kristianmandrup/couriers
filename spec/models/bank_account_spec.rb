require 'spec_helper'

describe BankAccount do 
  describe 'Incomplete Bank Account' do
    it 'should not create Bank Account without a name' do
      lambda { BankAccount.create! }.should raise_error
    end
    
    it 'should not create Bank Account with a name of one letter' do
      lambda { BankAccount.create! name: 'A' }.should raise_error
    end

    it 'should not create Bank Account with a name of one letter when trimmed' do
      lambda { BankAccount.create! name: ' A ' }.should raise_error
    end        
  end
  
  it 'should create a Bank Account' do
    bank_account = BankAccount.create name: 'Deutsche Bank', account_number: '1234567890', bank_id: 'DTCHBANK'
  end
end
