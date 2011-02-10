class Order::Quote
  module ClassMethods
    include ::OptionExtractor

    def create_for options = {}
      quote = Order::Quote.new
      quote.dropoff_point = extract_dropoff options
      quote.pickup_point  = extract_pickup options
      quote.vehicle       = Courier::Vehicle.random_vehicle.to_s
      quote
    end
  
    def create_from city = :munich
      quote = Order::Quote.new
      quote.pickup_point  = random_point city
      quote.dropoff_point = random_point city
      quote.vehicle = Courier::Vehicle.random_vehicle.to_s
      quote
    end

    def random_point city
      "#{random_street(city)}, #{city}"
    end

    def random_street city
      street = streets(city).pick_one      
    end
      
    def streets city = :munich
      TiramizooApp.load_streets(city)
    end     
  end
end