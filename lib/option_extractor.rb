require 'factory'

module OptionExtractor
  include Factory

  def get_options options = {}
    opts = {}
    city = extract_city options
    opts.merge!(options) if options.kind_of? Hash
    opts.merge(:city => city)
  end
    

  def extract_courier_type options
    type = options[:type]
    type ||= [:individual, :company].pick_one
  end

  def extract_max_couriers options
    options[:max] || 3
  end
  
  def extract_booking options
    booking = options[:booking]
    case booking
    when Hash
      create_booking(booking)
    when Customer::Order::Booking
      booking
    else            
      create_booking
      # raise ArgumentError, "Booking option is not valid: #{booking.inspect}"
    end
  end

  def extract_pickup options
    pickup = options[:pickup]
    case pickup
    when Hash
      create_pickup(pickup)
    when Order::Pickup
      pickup
    else            
      create_pickup      
      # raise ArgumentError, "Pickup option is not valid: #{pickup.inspect}"
    end
  end

  def extract_dropoff options
    dropoff = options[:dropoff]
    case dropoff
    when Hash
      create_dropoff(dropoff)
    when Order::Pickup
      dropoff        
    else
      create_dropoff
      # raise ArgumentError, "Dropoff options is not valid: #{dropoff.inspect}"
    end        
  end

  def extract_url options
    options[:url] || options[:url] || random_url
  end

  def extract_desc options
    options[:description] || random_desc
  end

  def random_url
    ['www.couriers.com', 'messengers.com'].pick_one      
  end


  def random_desc
    descriptions.pick_one      
  end
  
  def descriptions
    ["Big box", "Small box", "Large cylinder", "Heavy box", "Box with wineglasses - be careful!"]
  end

  def extract_profile options
    profile = options[:profile]
    case profile
    when Hash
      create_profile(profile)
    when Profile
      profile        
    else
      create_profile
      # raise ArgumentError, "Dropoff options is not valid: #{dropoff.inspect}"
    end        
  end

  def extract_description options
    options[:description] || random_profile_desc
  end

  def random_profile_desc
    profile_descriptions.pick_one      
  end
  
  def profile_descriptions
    ["My profile", "Nice profile", "I'm cool"]
  end


  def extract_avatar options
    options[:avatar] || random_avatar
  end

  def random_avatar
    ['pic1.jpg', 'my_avatar.png'].pick_one      
  end

  def extract_notes options
    options[:notes] || random_notes
  end

  def random_notes
    ['Drop it!', 'Beware of dog', 'Knock 3 times on door', 'Break the window to enter'].pick_one
  end

  def extract_order_state options
    options[:state] || random_order_state
  end

  def random_order_state
    Order.valid_states.pick_one
  end

  def extract_city options = {}
    city = case options
    when Symbol
      options
    else
      options[:from] || options[:city] || :munich
    end
    get_city city    
  end

  # {:couriers => [1,2,3]}
  # return list of Courier instances with matching number from database
  def extract_couriers  options = {}
    case options
    when Array
      Courier.where(:number.in => options[:couriers].map(&:to_i))
    else
      random_couriers
    end
  end

  def random_couriers
    Courier.available.pick_some.flat_uniq
  end

  def random_courier_ids
    random_couriers.map(&:number)
  end

  def get_city city
    :munich
    # return :munich if city.to_s.downcase =~ /m.*ch.*/
    # :vancouver
  end

  def extract_person_name options
    name = options[:name]
    name = {:first_name => extract_first_name(options), :last_name => extract_last_name(options)} if !name
    case name
    when Hash
      create_person_name(name)
    when Person::Name
      name
    else
      create_person_name
      # raise ArgumentError, "Name option is not valid: #{name.inspect}"
    end    
  end

  def extract_first_name options
    options[:first_name] || random_first_name(options)
  end

  def extract_last_name options
    options[:last_name] || random_last_name(options)
  end

  def first_names
    {
      :munich     => ['Michael', 'Florian', 'Martin', 'Mathias', 'Julia', 'Lena'],
      :vancouver  => ['Mike', 'David', 'John', 'Sandy', 'Rick', 'Tracy'],
    }
  end 

  def last_names
    {
      :munich     => ['Loehr', 'Walz', 'Blau', 'Schwarz'],
      :vancouver  => ['Jackson', 'Smith', 'Johnson', 'Meeker', 'Donovan', 'Gray'],
    }
  end 

  def random_first_name options
    first_names[extract_city options].pick_one
  end

  def random_last_name options
    last_names[extract_city options].pick_one
  end

  def extract_work_state options
    options[:work_state] || random_work_state
  end

  def random_work_state
    Courier.valid_work_states.pick_one
  end

  def extract_person options
    person = options[:person]
    case person
    when Hash
      create_person(person)
    when Person
      person
    else           
      create_person
      # raise ArgumentError, "Person option is not valid: #{person.inspect}"
    end
  end

  def extract_channel options
    channel = options[:channel]
    case channel
    when Hash
      create_channel(channel)
    when Contact::Channel
      channel
    else            
      create_channel
      # raise ArgumentError, "Channel option is not valid: #{channel.inspect}"
    end
  end

  def extract_location options
    location = options[:location]
    case location
    when Hash
      create_location(location)
    when Location
      location
    else
      create_location
      # raise ArgumentError, "Location option is not valid: #{location.inspect}"
    end
  end    

  def extract_waybill options
    waybill = options[:waybill]
    case waybill
    when Hash
      create_waybill(waybill)
    when Order::Waybill
      waybill
    else
      create_waybill
      # raise ArgumentError, "Location option is not valid: #{location.inspect}"
    end
  end    
  
  def extract_contact options
    contact = options[:contact]
    case contact
    when Hash
      create_contact(contact)
    when Contact
      contact
    else
      create_contact
      # raise ArgumentError, "Contact option is not valid: #{contact.inspect}"
    end
  end    

  def extract_address options
    address = options[:address]
    case address
    when Hash
      create_address(address)
    when Address
      address
    else
      create_address
      # raise ArgumentError, "Address option is not valid: #{address.inspect}"
    end
  end    
  
end  