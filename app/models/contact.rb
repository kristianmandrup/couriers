class Contact
  include Mongoid::Document

  embeds_one :name, :class => 'Person::Name'
  embeds_one :contact_info
  
  validates_presence_of :first_name, :last_name 
  
  validates :email, :email => true
  
  validate do |contact|
    contact.errors.add_to_base("Contact must have a phone or an email") if contact.phone.blank? && contact.email.blank?
  end  
end
