class Client < Profile
  include Mongoid::Document
  
  embeds_one :company
  embeds_one :person    
end

# company client:
# {
#   username: 'mike',
#   password: 'xxxxx',  
#   language: 'de',
# 
#   company: {
#     name: FastAndFurious,
#     address: {
#   
#     } 
#     contact: {
#   
#     }
#     profile: {
#   
#     }
#     phone: '+49 18188228',
#     email: 'abc@mail.de'      
#   }  
# }

# person client:
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
# }
