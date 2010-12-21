require 'spec_helper'

describe Person do 
  it 'should create a person' do
    person_1 = Person.create first_name: 'Mike', last_name: 'Loehr'
    # person_1.create_address 
    # person_1.create_profile
    
    puts person_1.inspect
  end
end



