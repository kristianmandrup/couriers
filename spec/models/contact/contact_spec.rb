require 'spec_helper'

describe Contact do  
  it 'should create not a Contact with an invalid email' do
    contact = Contact.create! first_name: 'Mike', last_name: 'Loehr', email: 'blap.dk'
    contact.errors[:email].should_not be_nil
  end
    
  it 'should create a Contact with name and email' do
    contact = Contact.create! first_name: 'Mike', last_name: 'Loehr', email: 'blip@blap.dk'
    puts contact.inspect
    contact.valid?.should be_true    
    contact.errors.should == {}
  end

  it 'should create a Contact with name and phone' do
    contact = Contact.create first_name: 'Mike', last_name: 'Loehr', phone: '+45 33223'
    contact.errors.should == {}    
  end

  it 'should create a Contact with name, phone and email' do
    contact = Contact.create first_name: 'Mike', last_name: 'Loehr', phone: '+45 33223', email: 'blip@blap.dk'
    contact.errors.should == {}    
  end

  it 'should create a Contact with name, phone and email' do
    contact = Contact.create_for :name => {first_name: 'Mike'}
    contact.errors.should == {}    
  end
end  

