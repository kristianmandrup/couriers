class CourierCompany < ServiceProvider
  include Mongoid::Document
  
  embeds_many :vehicles
  embeds_one  :company  
end
   
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
#       first_name: 'mike',
#       last_name: 'loehr',
#       email: 'dfsd@dfgf.de',
#       phone: '+49 2323232'
#     }
#     profile: {
#   
#     }
#     phone: '+49 18188228',
#     email: 'abc@mail.de'      
#   },
#   
#   bank_account: {},
#   
#   price_structure: {},
#   
#   vehicles: [
#     { name: Bicycle, count: 2}
#     { name: Car, count: 1}
#   ]
# }