module Order
  # :new an initial booking filled out with GPS
  # fill out booking form and select couriers
  # submit - :create complete booking, and create delivery offer (pushes offer to couriers)
  # redirect to delivery_offer#new with new delivery offer and 'empty' delivery requests (waiting responses)
  # resources :bookings, :only => [:new, :create] # updates booking session?
  class BookingsController < ApplicationController 

    # InheritedResources::Base


    # TODO
    # Save session in DB and clean it up!
    # http://asciicasts.com/episodes/243-beanstalkd-and-stalker    
    # http://railscasts.com/episodes/119-session-based-model
    # https://github.com/ncr/background-fu    
    def new
      @booking = session[:booking]
      @available_couriers = Courier.available    
      p @available_couriers
      @your_location = Location.create_from session[:location]
    end   

    def wait_for_couriers_response
      @couriers_to_wait_for = Courier.find(:number => session[:couriers_selected])
      render :wait_for_couriers_response
    end

    # submit - :create complete booking put it in a delivery_offer#create
    # Create new delivery offer and pushes it to the selected couriers 
    # Also use the zip of the pickup to find Companies who subscribe to that zip and send offer to those companies
    def create
      session[:couriers_selected] = couriers_selected # list of courier ids
      @delivery_offer = Delivery::Offer.create_for(current_booking, couriers_selected)

      redirect_to [:new, @delivery_offer]
    end
  
    protected

    [:courier, :individual, :company].each do |name|
      class_eval %{
        def #{name}_channel id
          TiramizooApp.pubsub.delivery_channel(:#{name} => id)
        end      
      }
    end

    # parse pickup
    def pickup
      Courier::Pickup.create_from_params params["pickup"]
    end

    # parse dropoff
    def dropoff
      Courier::Dropoff.create_from_params params["dropoff"]
    end

    def couriers_selected 
      get_selected params["couriers"]
    end

    def companies_selected 
      get_selected params["couriers"]["company"]
    end

    def individuals_selected
      get_selected params["couriers"]["individual"]
    end

    def get_selected selected
      return [] if selected.empty?
      return selected.keys.map(&:to_i) if selected
    end    
    
  end
end