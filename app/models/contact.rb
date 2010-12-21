class Contact
  include Mongoid::Document

  field :first_name, :type => String
  field :last_name, :type => String
  
  field :phone, :type => String
  field :email, :type => String
end
