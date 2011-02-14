require 'contact/channel/class_methods'

class Contact::Channel
  include Mongoid::Document
  
  field :phone, :type => String
  field :email, :type => String

  embedded_in :contact, :inverse_of => :channel
  embedded_in :company, :inverse_of => :channel

  # validates :phone, :presence => true
  # validates :email, :presence => true

  extend ClassMethods

  def for_json
    {:phone => phone, :email => email}
  end

  def to_s
    %Q{phone: #{phone}
email: #{email}
}
  end  
end