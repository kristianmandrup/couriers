class Courier::Individual < Courier
  include Mongoid::Document

  embeds_one :person 

  after_create :set_number

  def location
    person.address.location
  end

  def set_number
    self.number = Courier::Counter.inc_courier
  end
  
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
      co = Courier::Individual.new 
      co.person = Person.create_from(city)
      co 
    end
  end
end

