module Api
  module DeliveriesHelper
    def courier_id  
      params[:courier_id]
    end

    def delivery_id 
      params[:id]
    end

    def p_state 
      params[:state]
    end

    def p_answer 
      params[:answer]
    end
  end
end
