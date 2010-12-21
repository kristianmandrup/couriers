class ServiceProvider  
  include Mongoid::Document  

  embedded_in :user, :inverse_of => :service_provider
    
  embeds_one :bank_account
  embeds_one :price_structure
end
