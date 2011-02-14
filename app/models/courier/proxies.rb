class Courier < ::User
  module Proxies
    def location
      address.location if address
    end

    def location= loc
      address.location = loc if address
    end
  end
end