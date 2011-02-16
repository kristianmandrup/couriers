class Contact
  module ChannelExt
    module Api
      def for_json
        {:phone => phone, :email => email}
      end
    end
  end
end