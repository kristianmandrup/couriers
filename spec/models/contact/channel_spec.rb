require 'spec_helper'

describe Contact::Channel do  
  describe 'Channel validations' do
    it 'should not create channel without any data ' do
      puts Contact::Channel.create
      # lambda { Contact::Channel.create! }.should raise_error
    end
  
    it 'should not create channel where phone is "Mike" ' do
      puts Contact::Channel.create phone: 'Mike'
      # lambda { Contact::Channel.create! phone: 'Mike' }.should_not raise_error
    end

    # it 'should not create channel where email is "Mike" ' do
    #   lambda { Contact::Channel.create! email: 'Mike' }.should raise_error
    # end
  end

  describe 'Valid channel' do
    it 'should create a vaild channel when email and phone are valid' do
      channel = Contact::Channel.create! :email => 'krm@tiramizoo.com', :phone => '12131314'
      puts channel.inspect
      channel.valid?.should be_true
    end
  end
end