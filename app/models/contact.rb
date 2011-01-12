class Contact
  include Mongoid::Document

  embeds_one :name, :class => 'Person::Name'
  embeds_one :contact_info, :class => 'Contact::Info'

  class << self
    def create_from city = :munich
      co = Contact.new
      co.name = Person::Name.create_from city
      # co.contact_info = Contact::Info.create_from city
      co      
    end
  end    
  
  # validates_presence_of :first_name, :last_name   
  # validates :email, :email => true
  
  validate do |contact|
    contact.errors.add_to_base("Contact must have a phone or an email") if contact.phone.blank? && contact.email.blank?
  end  
end
