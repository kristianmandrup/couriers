class Courier::Company < Courier
  include Mongoid::Document
  
  embeds_one  :company

  after_create :set_number

  def location
    company.address.location
  end


  def set_number
    self.number = Courier::Counter.inc_company
  end
  
  def type
    'company'
  end

  def name
    company.name
  end

  def for_json
    {:email => email, :company => company.for_json}.merge super
  end

  class << self
    def create_from city = :munich
      co = Courier::Company.new 
      co.company = Company.create_from city
      co
    end
  end
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