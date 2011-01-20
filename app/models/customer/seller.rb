class Customer::Seller < Customer
  include Mongoid::Document
  
  embeds_one :company
end