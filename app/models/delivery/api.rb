class Delivery
  module Api
    def for_json    
      {:id => "1", :state => state, :pop => pickup_json, :pod => dropoff_json}
    end

    def get_state
      self    
    end

    def get_info
      self
    end

    private

    def contact_map
      {
        :accepted     => :pickup,
        :picked_up    => :dropoff
      }
    end

    def contacts 
      [contact_map[state.to_sym]].flatten
    end

    def pickup_json 
      contacts.include?(:pickup) ? pickup.for_json : pickup.get_overview
    end

    def dropoff_json
      contacts.include?(:dropoff) ? dropoff.for_json : dropoff.get_overview
    end
  end
end