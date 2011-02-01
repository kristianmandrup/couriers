module Order                       
  # resources :quotes, :only => [:new, :create]     
  class QuotesController < InheritedResources::Base

    # formtastic can provide a namespace for your form to ensure uniqueness of id attributes on form elements

    def create      
      quote = params[:order_quote]
      pickup_point  = quote[:pickup_point].strip
      dropoff_point = quote[:dropoff_point].strip
      vehicle       = quote[:vehicle]
    
      @booking = Order::Booking.create_empty
      @booking.pickup.address   = Address.create_from_point pickup_point
      @booking.dropoff.address  = Address.create_from_point dropoff_point
    
      session[:booking] = @booking
            
      redirect_to new_order_booking_path
    end    
  end
end