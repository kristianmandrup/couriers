class RegistrationRequest
  include Mongoid::Document

  field :location,      :type => String
  field :company_name,  :type => String
  field :notes,         :type => String

  embeds_one :contact
  embeds_one :vehicle
  
  class << self    
  end
end