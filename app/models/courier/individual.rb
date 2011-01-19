class Courier::Individual < Courier
  include Mongoid::Document

  embeds_one :person 
  embeds_one :location
  
  def type
    'individual'
  end  

  def name
    person.full_name
  end

  def for_json
    {:email => email, :person => person.for_json}.merge super
  end
  
  class << self
    def create_from city = :munich       
      p = Person.create_from(city)
      co = Courier::Individual.new 
      co.person = p
      
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
