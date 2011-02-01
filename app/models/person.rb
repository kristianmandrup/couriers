class Person
  include Mongoid::Document

  # General info
  embeds_one :name, :class_name => 'Person::Name'

  embeds_one :address
  embeds_one :profile

  module Api
    def for_json
      {:name => name.for_json, :address => address.for_json}
    end
  end
  include Api

  def full_name
    name.full_name
  end

  def to_s
%Q{
name: #{name}
address:
#{address}
profile:
#{profile}
}    
  end

  class << self   
    include ::OptionExtractor
        
    def create_for options = {}
      person = Person.new 
      options = get_options(options)
      person.address  = extract_address options
      person.name     = extract_person_name options
      person
    end
  end

  # validates_associated :address
  # validates :address, :presence => true  
end
