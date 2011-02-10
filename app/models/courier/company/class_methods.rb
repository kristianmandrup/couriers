class Courier::Company < Courier
  module ClassMethods
    include ::OptionExtractor

    def create_for options = {}   
      courier = Courier::Company.new
      courier.random_user
      courier.company     = Company.create_for options
      courier.delivery    = Delivery.create_for options
      courier.work_state  = extract_work_state options
      courier
    end    
  end
end