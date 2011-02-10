class Order::Offer
  module Api
    def for_json    
      # number.to_s
      {:id => "1", :pop => pickup.for_json, :pod => dropoff.get_overview }
    end

    def get_state
      self
    end

    def get_initial_info
      {:id => "1", :pop => pickup.get_overview, :pod => dropoff.get_overview }
    end
  end
end