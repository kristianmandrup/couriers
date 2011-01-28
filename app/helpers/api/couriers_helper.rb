module Api
  module CouriersHelper
    def current_courier
      # Courier::Individual.create_from :munich 
      courier = Courier.where(:number => courier_id).first
      if !courier
        puts "Create some seed couriers please!"
        return Courier::Individual.create_from :munich
      end
      courier
    end

    def courier_id
      params[:id]
    end

    def p_location
      params[:location] || params[:position] || params
    end

    def p_work_state
      params[:work_state]
    end

    # for bounding rectangle calculation: nearby couriers
    def ne_longitude
      params[:ne_longitude].to_f
    end      

    def ne_latitude
      params[:ne_latitude].to_f
    end      

    def sw_longitude
      params[:sw_longitude].to_f
    end      

    def sw_latitude
      params[:sw_latitude].to_f
    end
  end
end