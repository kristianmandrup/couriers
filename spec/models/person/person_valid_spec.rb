require 'spec_helper'

describe Person do 
  describe 'Validations' do
    it 'should not create person without a name' do
      lambda { Person.create! }.should raise_error
    end
  
    it 'should not create person without last name' do
      lambda { Person.create! first_name: 'Mike' }.should raise_error
    end
  
    it 'should not create person without first name' do
      lambda { Person.create! last_name: 'Loehr' }.should raise_error
    end
  
    it 'should not create person without an address' do
      lambda { Person.create! first_name: 'Mike', last_name: 'Loehr' }.should raise_error
      person = Person.create first_name: 'Mike', last_name: 'Loehr'
      person.errors[:address].first.should == "can't be blank"
    end
  end
end