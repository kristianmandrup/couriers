class ContactInfo
  include Mongoid::Document
  
  field :phone, :type => String
  field :email, :type => String
end