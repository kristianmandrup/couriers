class Courier::Company < Courier
  include Mongoid::Document
  
  embeds_one  :company  
  embeds_one  :location

  after_create :set_number

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
      co = Courier::Company.new :company => Company.create_from(city)
      # geo_location = GeoMagic::Location      
      co.location = Location.new :latitude => 48 + delta, :longitude => 11.35 + delta
      co 
    end      

    def delta
      (rand(1000) - 500).to_f / 100000.0
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