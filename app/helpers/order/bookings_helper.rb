module Order
  module BookingsHelper
    # "order_booking"=>{"couriers"=>[""], "pickup_attributes"=>{"street"=>"sdf", "name"=>{"first_name"=>"", "last_name"=>""}, "contact_info"=>{"phone"=>"", "email"=>""}}, "dropoff_attributes"=>{"street"=>"", "name"=>{"first_name"=>"", "last_name"=>""}, "contact_info"=>{"phone"=>"", "email"=>""}}}, "commit"=>"Create Booking", "locale"=>"en"}
    def current_booking
      Order::Booking.create_from_params params, :order_booking
    end
  end
end