require 'spec_helper'

describe ServiceProvider do 
  it 'should create a user' do
    user_1 = User.create email: 'abc@123.dk', password: '123456', password_confirmation: '123456', role: 'guest'
    
    service_provider_1 = ServiceProvider.create
    service_provider_1.user = user_1

    service_provider_1.create_bank_account bank_name: 'Deutche Bank', account_number: '2323523523', bank_id: 'DE233'
    service_provider_1.create_price_structure max_weight_kg: 24, max_dimensions_cm: '120x50x30', base_price: 7.5, km_price: 7.2 , km_point: 3, cost_per_stop: 2.5, waiting_time: 4, unsuccessful_delivery: 4.5, currency: 'euro'    

    puts service_provider_1.bank_account.inspect        
    puts service_provider_1.price_structure.inspect
    puts service_provider_1.user.inspect        
  end
end
