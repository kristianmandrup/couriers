class Courier::Individual < Courier
  module ClassMethods
    include ::OptionExtractor
  
    def create_for options = {}   
      courier = Courier::Individual.new
      courier.random_user
      courier.person      = Person.create_for options
      courier.delivery    = Delivery.create_for options
      courier.work_state  = extract_work_state options
      courier
    end    
  end
end