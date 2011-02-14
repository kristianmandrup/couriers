module Factory
  def create_individual_courier options = {}
    Courier::Individual.create_for options
  end

  def create_courier_company options = {}
    Courier::Company.create_for options
  end

  def create_courier options = {}
    type = extract_courier_type options
    case type
    when :individual        
      create_individual_courier options
    when :company
      create_courier_company options
    end
  end

  def create_person_name options = {}
    Person::Name.create_for options
  end
  
  def create_booking options = {}
    Order::Booking.create_for options
  end

  def create_location options = {}
    Location.create_for options
  end

  def create_contact options = {}
    Contact.create_for options
  end

  def create_channel options = {}
    Contact::Channel.create_for options
  end

  def create_person options = {}
    Contact::Channel.create_for options
  end

  def create_profile options = {}
    Profile.create_for options
  end

  def create_company options = {}
    Company::Channel.create_for options
  end

  def create_address options = {}
    Address.create_for options
  end
  
  def create_waybill options = {}
    Order::Waybill.create_for options
  end

  def create_location options = {}
    Location.create_for options
  end  

  def create_pickup options = {}
    Order::Pickup.create_for options
  end

  def create_dropoff options = {}
    Order::Dropoff.create_for options
  end
end