class Contact
  include Mongoid::Document

  field :first_name, :type => String
  field :last_name, :type => String
  
  field :phone, :type => String
  field :email, :type => String
  
  validates_presence_of :first_name, :last_name 
  
  validates :email, :email => true
  
  validate do |contact|
    contact.errors.add_to_base("Contact must have a phone or an email") if contact.phone.blank? && contact.email.blank?
  end  
end
