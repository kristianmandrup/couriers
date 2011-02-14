class Order
  module Proxies
    def travel_mode
      courier.travel_mode if courier
    end

    def pickup
      waybill.pickup
    end

    def dropoff
      waybill.dropoff
    end 
    
    def with_dropoff
      yield dropoff
    end

    def with_pickup
      yield pickup
    end    
  end
end