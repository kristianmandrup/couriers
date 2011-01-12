class Courier::Individual < Courier
  include Mongoid::Document

  embeds_one :person 
  
  def type
    'individual'
  end  

  def name
    person.full_name
  end
  
  class << self
    def create_from city = :munich       
      p = Person.create_from(city)
      co = Courier::Individual.new 
      co.person = p
      co 
    end      
  end
end

# {
#   username: 'mike',
#   password: 'xxxxx',  
#   language: 'de',
# 
#   person: {
#     first_name: 'mike',
#     last_name: 'loehr',
#     address: {
#       street: 'sfsfsa 133',
#       zip: 12345,
#       city: 'Munchen',
#       country: 'Germany'
#     }
# 
#     profile: {
#       description: 'sdgdsgdgs',
#       webpage_url: 'sdgsdg',
#       avatar: 'assf.jpg'
#     }
#   },    
#         
#   bank_account: {
#     
#   },
#   price_structure: {
#     
#   },
# 
#   vehicles: [
#     { name: Bicycle, count: 2},
#     { name: Car, count: 1}
#   ]    
# }
# 
