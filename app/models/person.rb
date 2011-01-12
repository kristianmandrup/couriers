class Person
  include Mongoid::Document

  # General info
  # embeds_one :name, :class => 'Person::Name'
  embeds_one :name #, :class => 'Person::Name'

  embeds_one :address
  embeds_one :profile

  def full_name
    name.full_name
  end

  class << self   
    
    def get_random_from city = :munich
      Person.create_with Name.create_from(:munich)
    end    
    
    def create_with options = {}
       p = Person.new 
       p.address = options[:address]
       name = Name.new :first_name => options[:first_name], :last_name => options[:last_name]
       p.name = name 
       p
    end
  end

  validates_associated :address
  validates :address, :presence => true  
end
