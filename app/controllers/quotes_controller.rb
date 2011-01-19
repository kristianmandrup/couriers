class QuotesController < InheritedResources::Base

  def create      
    quote = params[:quote]
    pickup_point  = quote[:pickup_point].strip
    dropoff_point = quote[:dropoff_point].strip
    vehicle       = quote[:vehicle]
    
    puts "pickup_point: #{pickup_point}"
    puts "dropoff_point: #{dropoff_point}"
    # 
    pickup_address   = Address.create_from_point pickup_point
    dropoff_address  = Address.create_from_point dropoff_point

    puts "pickup_address: #{pickup_address.inspect}"
    puts "dropoff_address: #{dropoff_address.inspect}"

    # 
    # pickup_address   = Address::Book.get_contact_details @pickup_point
    # dropoff_address  = Address::Book.get_contact_details @dropoff_point
    # 
    # vehicle  = params[:vehicle]

    @booking = Booking.new :city => 'Munich'
    @booking.pickup_address = pickup_address
    @booking.dropoff_address = dropoff_address

    # @booking.build_pickup_address :street => pickup_address.street

    # @pa = PickupAddress.new :street => pickup_address.street
    # @booking.pickup_address = @pa    
    
     # :vehicle => vehicle, :pickup_address => pickup_address, :dropoff_address => dropoff_address
    
    puts "Pickup address: #{@pa}"
    
    session[:booking] = @booking
    
    puts "CREATED session[:booking]: #{session[:booking]} " 
        
    redirect_to new_booking_path
  end
    
  def new    
  end
end
