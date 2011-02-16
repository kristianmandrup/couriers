require 'person_ext/class_methods'
require 'person_ext/api'

class Person
  include Mongoid::Document

  # General info
  embeds_one :name, :class_name => 'Person::Name'

  embeds_one :address
  embeds_one :profile

  include PersonExt::Api
  extend  PersonExt::ClassMethods

  proxy_for :name, :full_name

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
