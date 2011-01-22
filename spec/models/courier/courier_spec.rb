require 'spec_helper'

describe Courier do 
  it 'should create a Service Provider' do
    
    courier = Courier.create

    user            = User.create email: 'abc@123.dk', password: '123456', password_confirmation: '123456', role: 'guest'
    price_structure = PriceStructure.create! max_weight_kg: 24, max_dimensions_cm: '120x50x30', base_price: 7.5, km_price: 7.2 , km_point: 3, cost_per_stop: 2.5, waiting_time: 4, unsuccessful_delivery: 4.5, currency: 'euro'
    bank_account    = BankAccount.create! bank_name: 'Deutche Bank', account_number: '2323523523', bank_id: 'DE233'

    courier.user             = user
    courier.bank_account     = bank_account
    courier.price_structure  = price_structure

    # service_provider_1.create_bank_account bank_name: 'Deutche Bank', account_number: '2323523523', bank_id: 'DE233'
    # service_provider_1.create_price_structure max_weight_kg: 24, max_dimensions_cm: '120x50x30', base_price: 7.5, km_price: 7.2 , km_point: 3, cost_per_stop: 2.5, waiting_time: 4, unsuccessful_delivery: 4.5, currency: 'euro'    
  end
  
  it "should create random couriers" do
    Courier.create_random 10, :from => :munich, :work_state => 'available'
    Courier.create_random 10, :from => :munich, :work_state => 'not_available'
  end
end
