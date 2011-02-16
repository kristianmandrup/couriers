class Customer
  module Order
    # :new an initial booking filled out with GPS
    # fill out booking form and select couriers
    # submit - :create complete booking, and create delivery offer (pushes offer to couriers)
    # redirect to delivery_offer#new with new delivery offer and 'empty' delivery requests (waiting responses)
    # resources :bookings, :only => [:new, :create] # updates booking session?
    class BookingsController < ApplicationController 

      # InheritedResources::Base

      # http://asciicasts.com/episodes/243-beanstalkd-and-stalker    
      # http://railscasts.com/episodes/119-session-based-model
      # https://github.com/ncr/background-fu    
      def new
        # puts "BookingsController:new"
        @booking = Customer::Order::Booking.create_empty
        render :new
      end   

      # submit - :create complete booking put it in a delivery_offer#create
      # Create new delivery offer and pushes it to the selected couriers 
      # Also use the zip of the pickup to find Companies who subscribe to that zip and send offer to those companies
      def create            
        puts 'BookingsController#create'
        begin
          puts "current_booking being saved: #{current_booking.inspect}"
          current_booking.save!     
          puts "couriers_selected: #{couriers_selected}"
          session[:booking] = {:number => current_booking.number}
          redirect_to new_customer_order_path
        rescue Exception => e
          puts "Booking could not be saved: #{e}"
          render current_booking # new_order_booking_path
        end
      end  
    end
  end
end