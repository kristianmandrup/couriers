class Order::Booking
  include Mongoid::Document

  field       :number,              :type => String
  field       :description,         :type => String

  embeds_one  :pickup,              :class_name => 'Order::Pickup'
  embeds_one  :dropoff,             :class_name => 'Order::Dropoff'

  embedded_in :waybill,         :inverse_of => :booking
  embedded_in :delivery_state,  :inverse_of => :booking

  field       :selected_couriers,         :type => Array

  after_initialize :setup
  
  def for_json
    {:pop => pickup.for_json, :pod => dropoff.for_json, :description => description }
  end

  def to_s
    %Q{#{number}
desc: #{description}
pickup: #{pickup}
dropoff: #{dropoff}
}
  end

  def selected_couriers= courier_ids
    value = courier_ids.reject{|i| i.blank?}.map(&:to_i)
    write_attribute(:selected_couriers, value)
  end

  class << self
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
  
  accepts_nested_attributes_for :pickup,  :allow_destroy => true
  accepts_nested_attributes_for :dropoff, :allow_destroy => true

  protected

  def counter
    Order::Counter::Booking
  end
  
  def setup
    self.number = counter.next
  end
end
