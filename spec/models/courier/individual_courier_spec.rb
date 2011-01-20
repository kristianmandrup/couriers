require 'spec_helper'

# A Courier embeds the following
# 
# * Service Provider
#   - User
#   - Bank account
#   - Price structure
# * Person

describe Courier do 
  it "Should create random individual courier" do
    co = Courier::Individual.create_from :munich
    p co.inspect
  end
  
  # it 'should create a Courier with a valid person and nickname' do
  #   person = Person.create first_name: 'Mike', last_name: 'Loehr'
  #   person.address = Address::Usa.create! street: 'sgdsgk 12', zip_code: 123456, city: 'N.Y', state: 'NY'
  # 
  #   courier = Courier.create nick_name: 'Dangho'
  #   courier.person = person
  # 
  #   # Service Provider
  #   # embeds_one :user
  #   # embeds_one :bank_account
  #   # embeds_one :price_structure
  # 
  # 
  #   person.errors.should == {}
  #   courier.errors.should == {}      
  # end
  # 
  # it 'should create a Courier with a valid person and no nickname' do
  #   person = Person.create first_name: 'Mike', last_name: 'Loehr'
  #   person.address = Address::Usa.create! street: 'sgdsgk 12', zip_code: 123456, city: 'N.Y', state: 'NY'
  # 
  #   courier = Courier.create
  #   courier.person = person
  # 
  #   person.errors.should == {}
  #   courier.errors.should == {}      
  # end
  # 
  # it 'should not create a Courier without a person' do
  #   courier = Courier.create
  #   courier.errors.should_not == {}
  # end  
end                    
    
