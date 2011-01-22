class QuotesController < InheritedResources::Base

  # formtastic can provide a namespace for your form to ensure uniqueness of id attributes on form elements

  def create      
    p "params: #{params.inspect}"
    quote = params[:order_quote]
    pickup_point  = quote[:pickup_point].strip
    dropoff_point = quote[:dropoff_point].strip
    vehicle       = quote[:vehicle]
    
    pickup_address   = Address.create_from_point pickup_point
    dropoff_address  = Address.create_from_point dropoff_point

    @booking = Order::Booking.create_empty_from :city => 'Munich'
    @booking.pickup.address   = pickup_address
    @booking.dropoff.address  = dropoff_address
    
    session[:booking] = @booking
    
    puts "CREATED session[:booking]: #{session[:booking]} " 
        
    redirect_to new_order_booking_path
  end
    
  def new    
  end
end
