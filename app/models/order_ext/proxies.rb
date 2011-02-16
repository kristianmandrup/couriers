module OrderExt
  module Proxies
    proxy_for :waybill, [:pickup, :dropoff]
    proxy_for :courier, [:travel_mode] 
    
    def with_dropoff
      yield dropoff
    end

    def with_pickup
      yield pickup
    end    
  end
end