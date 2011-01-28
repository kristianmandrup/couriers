require 'spec_helper'

describe Company do 
  describe 'Incomplete company' do
    it 'should not create company without a name' do
      lambda { Company.create! }.should raise_error
    end
    
    it 'should not create company with a name of one letter' do
      lambda { Company.create! name: 'A' }.should raise_error
    end
  
    it 'should not create company with a name of one letter when trimmed' do
      lambda { Company.create! name: ' A ' }.should raise_error
    end        
  end

  context 'Munich company' do
    before do
      @company = Company.create_from :munich
    end

    it "should be valid and should be able to save it" do    
      if !@company.valid?
        p "errors: #{@company.errors}"
      end
      @company.valid?.should be_true
      lambda { @company.save! }.should_not raise_error
    end

    it 'should create a company with a name and a German address' do    
      @company.address.should_not be_nil
    end
    
    it 'should create a company with a name and a German address' do
      company = Company.create name: 'Alpha'
      company.address = Address::Germany.create! street: 'sgdsgk 12', postnr: 123456, city: 'Berlin'
      company.address.should_not be_nil
    end    
  end  

  context 'USA company' do
    before do
      @company = Company.create name: 'Alpha'
      @company.address = Address::Usa.create! street: 'sgdsgk 12', zip_code: 123456, city: 'N.Y', state: 'NY'
    end

    it "should be valid and should be able to save it" do    
      if !@company.valid?
        p "errors: #{@company.errors}"
      end
      @company.valid?.should be_true
      lambda { @company.save! }.should_not raise_error
    end
  
    it 'should create a company with a name and a USA address' do
      @company.address.should_not be_nil
    end
  end

  context 'Canada company' do
    before do
      @company = Company.create name: 'Alpha'
      @company.address = Address::Canada.create! street: 'sgdsgk 12', zip_code: 123456, city: 'Vancouver', province: 'Alberta'
    end

    it "should be valid and should be able to save it" do    
      if !@company.valid?
        p "errors: #{@company.errors}"
      end
      @company.valid?.should be_true
      lambda { @company.save! }.should_not raise_error
    end
        
    it 'should create a company with a name and a Canadian address' do
      @company.address.should_not be_nil
    end
  end  
end
