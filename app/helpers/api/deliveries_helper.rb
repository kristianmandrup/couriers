module Api
  module DeliveriesHelper
    def courier_id  
      params[:courier_id]
    end

    def delivery_id 
      params[:delivery_id]      
    end

    def state 
      params[:state]      
    end
  end
end
