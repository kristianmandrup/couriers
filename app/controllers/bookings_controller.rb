class BookingsController < ApplicationController 

  # InheritedResources::Base

  def new
    @booking = session[:booking]
    @available_couriers = Courier.available
    
    puts "current user: #{current_user}"
    @your_location = Location.create_from session[:location]
  end   

  # List deliveries
  def index
    @deliveries = current_courier.deliveries
    respond_with(@deliveries)
  end

  # Updates the booking
  def update
    session[:couriers_selected] = couriers_selected

    delivery = Delivery.create_from_booking current_booking
    delivery.offer_to couriers_selected

    couriers_selected.each do |id|
      p "sending deliver info to delivery channel for courier: #{id}"
      courier_channel(id).publish :id => params['id'], :directions => '3,5km to...', :pickup => pickup, :dropoff  => dropoff
    end

    redirect_to wait_for_couriers_response_path    
  end



  def wait_for_couriers_response
    @couriers_to_wait_for = Courier.find(:number => session[:couriers_selected])
    render :wait_for_couriers_response
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
