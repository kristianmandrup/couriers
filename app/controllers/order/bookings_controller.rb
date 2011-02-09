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
      @booking = Order::Booking.create_empty
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
        redirect_to new_delivery_path
      rescue Exception => e
        puts "Booking could not be saved: #{e}"
        render current_booking # new_order_booking_path
      end
    end
  
    protected

    def current_booking
      Order::Booking.create_from_params order_booking
    end

    [:courier, :individual, :company].each do |name|
      class_eval %{
        def #{name}_channel id
          TiramizooApp.pubsub.delivery_channel(:#{name} => id)
        end      
      }
    end

    # parse pickup
    def pickup
      Courier::Pickup.create_from_params params[:pickup]
    end

    # parse dropoff
    def dropoff
      Courier::Dropoff.create_from_params params[:dropoff]
    end

    def order_booking
      params[:order_booking]
    end

    def couriers_selected 
      order_booking[:couriers].reject{|i| i.blank?}.map(&:to_i)
    end

    def companies_selected 
      get_selected params[:couriers][:company]
    end

    def individuals_selected
      get_selected params[:couriers][:individual]
    end

    def get_selected selected
      return [] if !selected || selected.empty?
      selected.map(&:to_i)
    end
  end
end