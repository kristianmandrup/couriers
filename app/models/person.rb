require 'person/class_methods'
require 'person/api'

class Person
  include Mongoid::Document

  # General info
  embeds_one :name, :class_name => 'Person::Name'

  embeds_one :address
  embeds_one :profile

  include Api
  extend ClassMethods

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

  # validates_associated :address
  # validates :address, :presence => true  
end
