require 'spec_helper'

describe Profile do     
  describe 'Incomplete profile' do
    it 'should create an empty profile without description' do
      lambda { Profile.create! }.should_not raise_error
    end

    it 'should create a profile without description' do
      lambda { Profile.create webpage_url: 'http://www.ged.de', avatar: 'my_pic.jpg' }.should_not raise_error
    end

    it 'should create a profile without webpage' do
      lambda { Profile.create description: 'blip', avatar: 'my_pic.jpg' }.should_not raise_error
    end

    it 'should create a profile without avatar' do
      lambda { Profile.create description: 'blip', avatar: 'my_pic.jpg' }.should_not raise_error
    end
  end
  
  it 'should create a profile' do
    profile_1 = Profile.create description: 'blip', webpage_url: 'http://www.ged.de', avatar: 'my_pic.jpg'
    profile_1.description.should == 'blip'
    profile_1.webpage_url.should == 'http://www.ged.de'
    profile_1.avatar.should == 'my_pic.jpg'
  end
end
