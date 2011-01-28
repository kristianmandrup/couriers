require 'spec_helper'

describe Person do 
  describe 'Create random person' do  
    it 'should create a valid person' do
      10.times do
        pers = Person.create_from :munich      
        if !pers.valid?
          p "errors: #{pers.errors}"
        end
        pers.valid?.should be_true
      end
    end
    
    it 'should create and save a valid person' do
      pers = Person.create_from :munich
      lambda { pers.save! }.should_not raise_error
      pers.valid?.should be_true      
    end
  end       
end



