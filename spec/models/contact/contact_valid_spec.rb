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
end