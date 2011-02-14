require 'spec_helper'

describe Person do 
  it 'should create a person with a name and a German address' do
    person = Person.create first_name: 'Mike', last_name: 'Loehr'
    person.address = Address.create_german street: 'sgdsgk 12', postnr: 123456, city: 'Berlin'
    person.address.should_not be_nil
  end

  it 'should create a person with a name and a USA address' do
    person = Person.create first_name: 'Mike', last_name: 'Loehr'
    person.address = Address.create_usa street: 'sgdsgk 12', zip_code: 123456, city: 'N.Y', state: 'NY'
    person.address.should_not be_nil
  end

  it 'should create a person with a name and a Canadian address' do
    person = Person.create first_name: 'Mike', last_name: 'Loehr'
    person.address = Address.create_canada street: 'sgdsgk 12', zip_code: 123456, city: 'Vancouver', province: 'Alberta'
    person.address.should_not be_nil
  end
end