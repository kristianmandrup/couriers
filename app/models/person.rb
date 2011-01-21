class Person
  include Mongoid::Document

  # General info
  embeds_one :name, :class_name => 'Person::Name'

  embeds_one :address
  embeds_one :profile

  def full_name
    name.full_name
  end

  def for_json
    {:name => name.for_json, :address => address.for_json}
  end

  class << self   
    
    def create_from city = :munich  
      person = Person.new 
      person.name = Person::Name.create_from city
      person.address = Address.create_from city
      person
    end    
    
    def create_with options = {}
       person = Person.new 
       p.address = options[:address]
       person.name = Person::Name.new :first_name => options[:first_name], :last_name => options[:last_name]
       person
    end
  end

  validates_associated :address
  validates :address, :presence => true  
end
