class Courier < User 
  include Mongoid::Document  
    
  embeds_one :bank_account
  embeds_one :price_structure
  
  embeds_many :vehicles  

  def eta
    x = rand(3) > 1 ? rand(200) : rand(30)
    TimePeriod.to_s rand(100) + 60 + x
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

    def create_company options = {}
      co = Courier::Company.new
      co.company = Company.create_from :munich
      co
    end

    def create_from city = :munich 
      puts "create_from: #{city}"
      # person = Person.create_from :munich
      # person.address = Address.get_random_from :munich

      type = [:individual, :company].pick_one

      case type
      when :individual        
        Courier::Individual.create_from city
      when :company
        Courier::Company.create_from city
      end
    end
    
    def available city = :munich
      number = rand(10) +1
      number.times.inject([]) do |res, n| 
        res << create_from(city)
        res 
      end
    end
  end
end
