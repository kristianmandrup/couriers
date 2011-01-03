# Customer is a business
class Customer::Professional < User 
  include Mongoid::Document
  
  embeds_one :company
end
