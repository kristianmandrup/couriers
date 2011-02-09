class Courier::Individual < Courier
  include Mongoid::Document

  field       :courier_number,  :type => Integer
  field       :company_name,    :type => String

  embeds_one  :person

  # API methods

  module Api
    def for_json
      {:email => email, :person => person.for_json}.merge super
    end
    
    def get_location
      {:location => address.location.for_json}
    end    
  end
  include Api
  
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

  def to_s
    %Q{
number: #{courier_number}
type: #{type}
person: #{person}
}
  end

  protected

  def counter
    Courier::Counter::Individual
  end

  def set_number    
    self.courier_number = counter.next
    super
    save
  end
  
  class << self
    include ::OptionExtractor
    
    def create_for options = {}   
      courier = Courier::Individual.new
      courier.random_user
      courier.person      = Person.create_for options
      courier.delivery    = Delivery.create_for options
      courier.work_state  = extract_work_state options
      courier
    end    
  end
end

