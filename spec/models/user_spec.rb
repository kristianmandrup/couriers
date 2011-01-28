require 'spec_helper'

describe User do 
  it 'should create a user' do
    user = User.create email: "courier#{rand(1000)}@abc.dk", password: '123456', password_confirmation: '123456', role: 'guest'
    puts user.inspect
    user.save!
  end

  # it 'should create a random user' do
  #   user = User.new
  #   user.random_user    
  #   user.inspect
  #   user.save!
  # end
end
