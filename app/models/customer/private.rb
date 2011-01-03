# Customer is a business
class Customer::Private < User 
  include Mongoid::Document
  
  embeds_one :person
end
