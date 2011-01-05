class Customer::Seller < User
  include Mongoid::Document
  
  embeds_one :company
end