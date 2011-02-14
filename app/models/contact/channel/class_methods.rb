class Contact
  class Channel
    module ClassMethods
      include ::OptionExtractor
  
      def phones
        {:munich => ['125215', '2346436', '343423', '574534523'] }
      end

      def emails
        { :munich => ['blip@mail.de', 'blap.blop@mail.de', 'zander@telekom.de', 'jurgen@flashcom.de'] }
      end

      def create_empty
        Contact::Channel.new
      end

      def create_for options = {}
        city = extract_city options
        channel = create_empty
        channel.phone = phones[city.to_sym].pick_one
        channel.email = emails[city.to_sym].pick_one
        channel
      end
  
      def create_from city = :munich
        Contact::Channel.new :phone => phones[city.to_sym].pick_one, :email => emails[city.to_sym].pick_one
      end
    end
  end
end