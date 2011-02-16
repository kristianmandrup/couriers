module CourierExt
  module Proxies    
    proxy_accessors_for :address, :location
    add_proxy_factory :address => [Address, :create_empty]    
  end
end