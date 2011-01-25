module Api
  module CouriersHelper
    def courier_id
      params[:courier_id]
    end

    def location
      params[:location]
    end

    def work_state
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