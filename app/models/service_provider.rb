class ServiceProvider < User 
  include Mongoid::Document  
    
  embeds_one :bank_account
  embeds_one :price_structure
  
  embeds_many :vehicles  
end
