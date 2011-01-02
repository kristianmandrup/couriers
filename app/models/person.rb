class Person
  include Mongoid::Document

  # General info
  embeds_one :name, :class => 'PersonName'

  embeds_one :address
  embeds_one :profile

  validates_associated :address

  validates :address, :presence => true  
end
