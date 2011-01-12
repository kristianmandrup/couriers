class Courier < User 
  include Mongoid::Document  
    
  embeds_one :bank_account
  embeds_one :price_structure
  
  embeds_many :vehicles  

  def eta
    x = rand(3) > 1 ? rand(200) : rand(30)
    TimePeriod.to_s rand(100) + 20 + x
  end

  def rating
    rand(3) + rand(3) + 1    
  end

  def price  
    p = rand(10) + rand(6) + 5
    "#{p} euro"
  end

  
  class << self
    def create_individual options = {}
      ci = Courier::Individual.new      
      ci.person = options[:person] if options[:person]
      ci.person.address = options[:address] if options[:address]
      ci
    end

    def get_random_from city = :munich
      person = Person.get_random_from :munich
      person.address = Address.get_random_from :munich
      courier = Courier.create_individual :person => person
      courier
    end
    
    def available city = :munich
      number = rand(10) +1
      number.times.inject([]) do |res, n| 
        res << get_random_from(city)
        res 
      end
    end
  end
end
