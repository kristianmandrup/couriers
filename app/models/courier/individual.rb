class Courier::Individual < Courier
  include Mongoid::Document

  field :courier_number, :type => Integer
  embeds_one :person 

  # API methods

  def for_json
    {:email => email, :person => person.for_json}.merge super
  end

  def get_location
    {:location => address.location.for_json}
  end

  # convenience methods

  def address
    person.address
  end

  def location
    address.location
  end

  def location= loc
    address.location = loc
  end

  def city
    address.city
  end

  def zip
    address.zip
  end

  def available?
    work_state == 'available'
  end
  
  def type
    'individual'
  end  

  def full_name
    person.full_name if person
  end
  alias_method :name, :full_name

  protected

  def set_number    
    self.courier_number = Courier::Counter.inc_courier
    super
    save
  end
  
  class << self
    include ::AddressHelper
    
    def all_from city = :munich
      where :city => city
    end

    def create_from options = {}
      city = extract_city options
      co = Courier::Individual.new
      co.random_user
      co.person = Person.create_from city
      co 
    end
  end
end

