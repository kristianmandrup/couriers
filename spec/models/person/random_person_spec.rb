require 'spec_helper'

describe Person do 
  describe 'Create random person' do  
    it 'should create a valid person' do
      person = Person.create_for :address => {:city => 'munich', :random => true}, :person => {:first_name => 'Michael'}
      puts person
      p person.inspect
      p person.address.inspect
      if !person.valid?
        p "errors: #{person.errors}"
      end
      person.should be_valid
    end
  end       
end



