require 'spec_helper'

describe Company do 
  # describe 'Incomplete company' do
  #   it 'should not create company without a name' do
  #     lambda { Company.create! }.should raise_error
  #   end
  #   
  #   it 'should not create company with a name of one letter' do
  #     lambda { Company.create! name: 'A' }.should raise_error
  #   end
  # 
  #   it 'should not create company with a name of one letter when trimmed' do
  #     lambda { Company.create! name: ' A ' }.should raise_error
  #   end        
  # end

  it 'should create a company with a name and a German address' do
    company = Company.create_from
    puts company.inspect
    company.address.should_not be_nil
  end
  
  # it 'should create a company with a name and a German address' do
  #   company = Company.create name: 'Alpha'
  #   company.address = GermanAddress.create! street: 'sgdsgk 12', postnr: 123456, city: 'Berlin'
  #   company.address.should_not be_nil
  # end
  # 
  # it 'should create a company with a name and a USA address' do
  #   company = Company.create name: 'Alpha'
  #   company.address = UsaAddress.create! street: 'sgdsgk 12', zip_code: 123456, city: 'N.Y', state: 'NY'
  #   company.address.should_not be_nil
  # end
  # 
  # it 'should create a company with a name and a Canadian address' do
  #   company = Company.create name: 'Alpha'
  #   company.address = CanadaAddress.create! street: 'sgdsgk 12', zip_code: 123456, city: 'Vancouver', province: 'Alberta'
  #   company.address.should_not be_nil
  # end
end
