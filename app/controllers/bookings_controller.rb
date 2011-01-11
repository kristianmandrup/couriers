class BookingsController < InheritedResources::Base

  def show
    puts Booking.all.map(&:_id)
    @booking = Booking.find params[:id]
    
    puts "show form for booking: #{@booking.inspect}"
  end

  def new
  end

  def create
    pickup_point  = params[:pickup_point]
    droppof_point = params[:droppof_point]
    
    pickup_point   = Address.create_from_point pickup_point
    dropoff_point  = Address.create_from_point dropoff_point
    
    pickup_address   = AddressBook.get_contact_details @pickup_point
    dropoff_address  = AddressBook.get_contact_details @dropoff_point

    vehicle  = params[:vehicle]

    @booking = Booking.create! :vehicle => vehicle, :pickup_address => pickup_address, :dropoff_address => dropoff_address
    
    redirect_to :show
  end
    
  def new    
  end
end
