class Courier
  module Api
    def for_json
      {:eta => eta, :rating => rating, :price => price}
    end

    def get_settings
      {:current_vehicle => current_vehicle, :working_hours => working_hours}
    end

    def get_state
      {:work_state => work_state}
    end

    # id/number is temporary until we have authentication in place!
    def get_info
      # number.to_s    
      options = {:id => "1", :work_state => work_state, :travel_mode => travel_mode}
      options.merge!(:current_delivery => delivery) if delivery
      options
      # Courier::Info.new options
    end
    
    def get_location
      raise "#location method must be implemented by subclass"    
    end    
  end
end