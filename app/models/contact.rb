class Contact
  include Mongoid::Document

  embeds_one :name, :class_name => 'Person::Name'
  embeds_one :channel, :class_name => 'Contact::Channel'

  embedded_in :person, :inverse_of => :contact
  embedded_in :company, :inverse_of => :contact

  def full_name
    name.full_name
  end

  def phone
    channel.phone if channel
  end

  def email
    channel.email if channel
  end

  def for_json
    {:name => full_name, :phone => channel.phone, :company_name => 'Flowers4u'} #:email => channel.email
  end

  def to_s
    %Q{name: #{name}
#{channel}
}
  end

  class << self
    def create_from city = :munich
      co = Contact.new
      co.name = Person::Name.create_from city
      co.channel = Contact::Channel.create_from city
      co      
    end
  end    
  
  # validates_presence_of :first_name, :last_name   
  # validates :email, :email => true
  
  validate do |contact|
    contact.errors.add_to_base("Contact must have a phone or an email") if contact.phone.blank? && contact.email.blank?
  end  
end
