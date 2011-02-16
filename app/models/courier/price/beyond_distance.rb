class Courier
  class Price
    class BeyondDistance
      include Mongoid::Document

      field :price,           :type => Float # price per kilometer beyond km_point
      field :distance_limit,  :type => String # from this distance, the km_price is effective (fx 5.km)
  
      def initialize price, distance_limit
        self.distance_limit = distance_limit
        self.price = price    
      end
    end
  end
end