class Contact
  include Mongoid::Document

  embeds_one :name,     :class_name => 'Person::Name'
  embeds_one :channel,  :class_name => 'Contact::Channel'

  embedded_in :person,  :inverse_of => :contact
  embedded_in :company, :inverse_of => :contact

  module Api
    def for_json
      {:name => full_name, :phone => channel.phone, :company_name => 'Flowers4u'} #:email => channel.email
    end
  end
  include Api

  def full_name
    name.full_name
  end

  def phone
    channel.phone if channel
  end

  def email
    channel.email if channel
  end

  def to_s
    %Q{name: #{name}
#{channel}
}
  end

  class << self
    include ::OptionExtractor    

    def create_for options = {}
      contact           = Contact.new
      contact.name      = extract_person_name options
      contact.channel   = extract_channel options
      contact      
    end

    def create_from city = :munich
      contact = Contact.new
      contact.name     = Person::Name.create_from city
      contact.channel  = Contact::Channel.create_from city
      contact      
    end
  end    
  
  # validates_presence_of :first_name, :last_name   
  # validates :email, :email => true
  
  validate do |contact|
    contact.errors.add_to_base("Contact must have a phone or an email") if contact.phone.blank? && contact.email.blank?
  end  
end
