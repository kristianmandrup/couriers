module Api
  module CouriersHelper
    def current_courier
      # puts "current_courier #: #{courier_id}, couriers in DB: #{Courier.all.size} count"
      Courier::Individual.create_from :munich
      # Courier.where(:number => courier_id)
    end

    def courier_id
      params[:id]
    end

    def p_location
      params[:location] || params
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