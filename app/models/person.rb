class Person
  include Mongoid::Document

  # General info
  field :first_name,  :type => String
  field :last_name,   :type => String

  embeds_one :address

  embeds_one :profile

  embedded_in :courier, :inverse_of => :person
end
