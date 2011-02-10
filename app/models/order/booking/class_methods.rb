class Order::Booking
  module ClassMethods
    include ::OptionExtractor
  
    def create_empty options = {}
      booking = self.new options

      booking.pickup  = Order::Pickup.create_empty
      booking.dropoff = Order::Dropoff.create_empty
      booking
    end

    # {
    #   "couriers"=>[""], 
    #   "pickup_attributes"=>{"street"=>"sdf", 
    #     "name"=>{"first_name"=>"", "last_name"=>""}, 
    #     "contact_info"=>{"phone"=>"", "email"=>""}}, 

    #   "dropoff_attributes"=>{"street"=>"", 
    #     "name"=>{"first_name"=>"", "last_name"=>""}, 
    #     "contact_info"=>{"phone"=>"", "email"=>""}}}, "commit"=>"Create Booking", "locale"=>"en"}    
    def  create_from_params params
      new_booking = Order::Booking.create_empty 
      new_booking.pickup = Order::Pickup.create_from_params params[:pickup_attributes]
      new_booking.pickup = Order::Dropoff.create_from_params params[:dropoff_attributes]
      new_booking.selected_couriers = params[:couriers]
      new_booking            
    end
    

    def create_for options = {}
      booking = self.new
      booking.description = extract_desc options
      booking.pickup      = extract_pickup options
      booking.dropoff     = extract_dropoff options
      booking
    end
  end
end