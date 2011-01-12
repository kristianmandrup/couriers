class Courier < User 
  include Mongoid::Document  
    
  embeds_one :bank_account
  embeds_one :price_structure
  
  embeds_many :vehicles  

  def eta
    '20 min'
  end

  def rating
    '5'
  end

  def price
    '20 euro'
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
        res << get_random_from city
        res 
      end
    end
  end
end
