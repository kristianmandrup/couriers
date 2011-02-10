class Person
  class Name
    module ClassMethods
      include ::OptionExtractor

      def create_empty
        Person::Name.new 
      end

      def create_for options
        city = extract_city options
        name = create_empty
        name.first_name = extract_first_name options
        name.last_name  = extract_last_name options
        name
      end
    end
  end
end