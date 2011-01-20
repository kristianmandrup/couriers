require 'spec_helper'

describe Person do 

  describe 'Create random person' do  
    it 'should not create person without a name' do
      pers = Person.create_from :munich
      p pers
    end
  end
    
  
  
  # describe 'Incomplete person' do
  #   it 'should not create person without a name' do
  #     lambda { Person.create! }.should raise_error
  #   end
  #   
  #   it 'should not create person without last name' do
  #     lambda { Person.create! first_name: 'Mike' }.should raise_error
  #   end
  #   
  #   it 'should not create person without first name' do
  #     lambda { Person.create! last_name: 'Loehr' }.should raise_error
  #   end
  #   
  #   it 'should not create person without an address' do
  #     lambda { Person.create! first_name: 'Mike', last_name: 'Loehr' }.should raise_error
  #     person = Person.create first_name: 'Mike', last_name: 'Loehr'
  #     person.errors[:address].first.should == "can't be blank"
  #   end
  # end
  # 
  # it 'should create a person with a name and a German address' do
  #   person_1 = Person.create first_name: 'Mike', last_name: 'Loehr'
  #   person_1.address = GermanAddress.create! street: 'sgdsgk 12', postnr: 123456, city: 'Berlin'
  #   person_1.address.should_not be_nil
  # end
  # 
  # it 'should create a person with a name and a USA address' do
  #   person_1 = Person.create first_name: 'Mike', last_name: 'Loehr'
  #   person_1.address = UsaAddress.create! street: 'sgdsgk 12', zip_code: 123456, city: 'N.Y', state: 'NY'
  #   person_1.address.should_not be_nil
  # end
  # 
  # it 'should create a person with a name and a Canadian address' do
  #   person_1 = Person.create first_name: 'Mike', last_name: 'Loehr'
  #   person_1.address = CanadaAddress.create! street: 'sgdsgk 12', zip_code: 123456, city: 'Vancouver', province: 'Alberta'
  #   person_1.address.should_not be_nil
  # end
end



