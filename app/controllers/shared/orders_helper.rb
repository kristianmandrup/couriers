module Shared
  module OrdersHelper
    def couriers_to_notify
      couriers_selected # + courier_companies_subscribing_to_zip(current_booking.zip)
    end  

    def booking
      @booking ||= session[:booking]
    end

    def current_booking    
      @current_booking ||= Order::Booking.by_number(booking[:number]).first
    end

    def couriers_selected
      @couriers_selected ||= Courier.by_number(current_booking.selected_couriers).to_a
    end
  end
end     
    