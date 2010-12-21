require 'spec_helper'

describe Profile do     
  it 'should create a profile' do
    profile_1 = Profile.create description: 'blip', webpage_url: 'http://www.ged.de', avatar: 'my_pic.jpg'
    puts profile_1.inspect
  end
end
