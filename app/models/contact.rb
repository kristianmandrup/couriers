class Contact
  include Mongoid::Document

  embeds_one :name, :class => 'Name'
  embeds_one :channel, :class => 'Contact::Channel'

  def full_name
    name.full_name
  end

  def for_json
    {:name => name.for_json, :channels => channel.for_json}
  end

  class << self
    def create_from city = :munich
      co = Contact.new
      co.name = Name.create_from city
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
