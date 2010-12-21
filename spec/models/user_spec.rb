require 'spec_helper'

describe User do 
  it 'should create a user' do
    user_1 = User.create email: 'abc@123.dk', password: '123456', password_confirmation: '123456', role: 'guest'
    puts user_1.inspect
  end
end
