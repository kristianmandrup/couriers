class Courier
  class Price
    class BeyondTime
      include Mongoid::Document
  
      field :price,         :type => Float # price per kilometer beyond km_point
      field :time_limit,    :type => Time # from this time, the extra price is effective
  
      def initialize price, time_limit
        self.time_limit = time_limit
        self.price = price    
      end
    end
  end
end