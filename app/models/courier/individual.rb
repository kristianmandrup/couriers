class Courier::Individual < Courier
  include Mongoid::Document

  field :courier_number, :type => Integer
  embeds_one :person 

  def location
    person.address.location
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

  protected

  def set_number    
    self.courier_number = Courier::Counter.inc_courier
    super
    save
  end
  
  class << self
    def create_from options = {}
      city = options[:from] || :munich
      co = Courier::Individual.new options
      co.random_user
      co.person = Person.create_from(city)
      co 
    end
  end
end

