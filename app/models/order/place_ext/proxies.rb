class Order
  module PlaceExt
    module Proxies      
      proxy_accessors_for :contact, [:full_name]
      proxy_accessors_for :address, [:street, :city, :location]
    end
  end
end