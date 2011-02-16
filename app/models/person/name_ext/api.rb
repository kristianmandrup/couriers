class Person
  module NameExt
    module Api
      # API
      def for_json
        {:first => first_name, :last => last_name}
      end
    end
  end
end
