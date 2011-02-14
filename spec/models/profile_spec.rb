require 'spec_helper'

describe Profile do
  describe '#create' do
    it 'should create a profile' do
      profile = Profile.create description: 'blip', url: 'http://www.ged.de', avatar: 'my_pic.jpg'
      profile.description.should == 'blip'
      profile.url.should == 'http://www.ged.de'
      profile.avatar.should == 'my_pic.jpg'
    end
  end

  describe '#create_for' do  
    it 'should create a profile' do
      profile = Profile.create_for description: 'blip', url: 'http://www.ged.de', avatar: 'my_pic.jpg'
      profile.description.should == 'blip'
      profile.url.should == 'http://www.ged.de'
      profile.avatar.should == 'my_pic.jpg'
    end
  end
end
