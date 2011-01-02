# The customer is currently always a business

class Customer < User 
  include Mongoid::Document
  
  embeds_one :company
end
