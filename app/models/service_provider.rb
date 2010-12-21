class ServiceProvider 
  include Mongoid::Document  

  embeds_one :user
    
  embeds_one :bank_account
  embeds_one :price_structure
end
