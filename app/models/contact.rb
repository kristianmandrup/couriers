require 'contact_ext/class_methods'
require 'contact_ext/api'
require 'contact_ext/proxies'

class Contact
  include Mongoid::Document

  embeds_one :name,     :class_name => 'Person::Name'
  embeds_one :channel,  :class_name => 'Contact::Channel'

  embedded_in :person,  :inverse_of => :contact
  embedded_in :company, :inverse_of => :contact

  extend  ContactExt::ClassMethods
  include ContactExt::Api
  include ContactExt::Proxies

  def to_s
    %Q{name: #{name}
#{channel}
}
  end
  
  # validates_presence_of :first_name, :last_name   
  # validates :email, :email => true
  
  validate do |contact|
    contact.errors.add_to_base("Contact must have a phone or an email") if contact.phone.blank? && contact.email.blank?
  end  
end
