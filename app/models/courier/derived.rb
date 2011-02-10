class Courier < User
  module Derived
    def eta
      x = rand(3) > 1 ? rand(200) : rand(30)
      TimePeriod.to_s rand(100) + 60 + x
    end

    def rating
      rand(3) + rand(3) + 1    
    end

    def price  
      p = rand(10) + rand(6) + 5
      "#{p} euro"
    end
  end
end