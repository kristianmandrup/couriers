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
    
    def available
      person = Person.create_with first_name: 'Mike', last_name: 'Loehr'
      person.address = Address::Usa.create! street: 'sgdsgk 12', zip_code: 123456, city: 'N.Y', state: 'NY'
      courier = Courier.create_individual :person => person #, :address => address
      [courier, courier]
    end
  end
end
