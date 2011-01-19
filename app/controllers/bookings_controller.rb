class BookingsController < InheritedResources::Base

  def show
    # puts "SHOW booking"        
    # 
    # puts Booking.all.map(&:_id)
    # @booking = Booking.find params[:id]
    # 
    # puts "show form for booking: #{@booking.inspect}"
  end

  def new
    @booking = session[:booking]
    puts "booking: #{@booking}"
    @available_couriers = Courier.available
    @your_location = Location.create_from session[:location]
    puts "@your_location = #{@your_location.inspect}"

    puts "#{@your_location.lat}, #{@your_location.lng}"
    # Location.new("My House", 48.137035, 11.57591948.137035)
    
    puts "available_couriers: #{@available_couriers}"
  end

  # def create
  #   puts "CREATE booking!"    
  #   
  #   pickup_point  = params[:pickup_point]
  #   droppof_point = params[:droppof_point]
  #   
  #   pickup_point   = Address.create_from_point pickup_point
  #   dropoff_point  = Address.create_from_point dropoff_point
  #   
  #   pickup_address   = AddressBook.get_contact_details @pickup_point
  #   dropoff_address  = AddressBook.get_contact_details @dropoff_point
  # 
  #   vehicle  = Vehicle.create_single params[:vehicle]
  # 
  #   @booking = Booking.create! :vehicle => vehicle, :pickup_address => pickup_address, :dropoff_address => dropoff_address
  #   
  #   redirect_to :show
  # end    
end
