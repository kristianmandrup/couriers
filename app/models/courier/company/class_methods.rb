class Courier
  class Company < ::Courier
    module ClassMethods
      include ::OptionExtractor
    
      def create_empty
        courier = Courier::Company.new
      end
    
      def create_from city = :munich
        create_for :address => {:city => city}
      end

      def create_for options = {}   
        courier = create_empty
        courier.random_user
        courier.company     = Company.create_for options
        # courier.order       = Order.create_empty #for #options
        courier.work_state  = extract_work_state options
        courier
      end    
    end
  end
end