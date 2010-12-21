class Company
  include Mongoid::Document

  field :name, :type => String
  
  embeds_one :address 

  embeds_one :contact
  embeds_one :profile   

  field :phone, :type => String
  field :email, :type => String
end
