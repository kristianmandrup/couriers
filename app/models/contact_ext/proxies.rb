module ContactExt
  module Proxies
    proxy_accessors_for :name, [:full_name, :first_name, :last_name]
    add_proxy_factory :name => Person::Name
    
    def phone
      channel.phone if channel
    end

    def email
      channel.email if channel
    end

    def phone= phone
      self.channel = Contact::Channel.new if !channel
      channel.phone = phone
    end

    def email= email
      self.channel = Contact::Channel.new if !channel
      channel.email = email
    end
  end
end