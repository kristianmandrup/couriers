# Customer is a business
class Customer::Private < User 
  include Mongoid::Document
  
  embeds_one :person
  
  def for_json    
    {:person => person}.merge super.for_json
  end
end
