class Courier < User
  module Proxies
    def location
      address.location
    end

    def location= loc
      address.location = loc
    end
  end
end