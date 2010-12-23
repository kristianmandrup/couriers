require 'spec_helper'

describe Contact do  
  describe 'Incomplete contact' do
    it 'should not create Contact without a name' do
      lambda { Contact.create! }.should raise_error
    end
    
    it 'should not create Contact without last name' do
      lambda { Contact.create! first_name: 'Mike' }.should raise_error
    end
    
    it 'should not create Contact without first name' do
      lambda { Contact.create! last_name: 'Loehr' }.should raise_error
    end
    
    it 'should not create Contact without an email or phone' do
      lambda { Contact.create! first_name: 'Mike', last_name: 'Loehr' }.should raise_error
    end
  end

  it 'should create not a Contact with an invalid email' do
    contact = Contact.create first_name: 'Mike', last_name: 'Loehr', email: 'blap.dk'
    contact.errors[:email].should_not be_nil
  end
    
  it 'should create a Contact with name and email' do
    contact = Contact.create first_name: 'Mike', last_name: 'Loehr', email: 'blip@blap.dk'
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
end  

