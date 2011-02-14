require 'spec_helper'

describe Person do   
  describe 'Create random person' do  
    describe '#create_for' do
      it 'should create a valid person in munich' do
        pers = Person.create_for :address => {:city => :munich}
        if !pers.valid? 
          p "errors: #{pers.errors}"
        end
        pers.valid?.should be_true
      end
    end

    describe '#create_from' do
      it 'should create a valid person' do
        pers = Person.create_from :munich      
        if !pers.valid? 
          p "errors: #{pers.errors}"
        end
        pers.valid?.should be_true
      end
    
      it 'should create and save a valid person' do
        pers = Person.create_from :munich
        lambda { pers.save! }.should_not raise_error
        pers.valid?.should be_true      
      end
    end
  end       
end



