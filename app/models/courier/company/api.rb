class Courier
  class Company < ::Courier
    module Api
      def for_json
        {:email => email, :company => company.for_json}.merge super
      end
    end
  end
end
