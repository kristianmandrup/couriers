class BookingController < InheritedResources::Base
  before_filter :authenticate_user!

  def new_quote
    pickup_point  = params[:pickup_point]
    droppof_point = params[:droppof_point]
    
    @pickup_point   = Address.create_from_point pickup_point
    @dropoff_point  = Address.create_from_point dropoff_point
    
    render :show_quote
  end

  def show_quote
    AddressBook.get_contact_details @pickup_point
  end

end
