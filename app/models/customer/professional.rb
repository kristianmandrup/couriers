# Customer is a business
class Customer::Professional < Customer
  include Mongoid::Document
  
  embeds_one :company
end
