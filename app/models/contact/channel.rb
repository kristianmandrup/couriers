require 'contact/channel_ext/class_methods'

class Contact
  class Channel
    include Mongoid::Document
  
    field :phone, :type => String
    field :email, :type => String

    embedded_in :contact, :inverse_of => :channel
    embedded_in :company, :inverse_of => :channel

    # validates :phone, :presence => true
    # validates :email, :presence => true

    extend  Contact::ChannelExt::ClassMethods
    include Contact::ChannelExt::Api

    def to_s
    %Q{phone: #{phone}
email: #{email}
}
    end  
  end
end