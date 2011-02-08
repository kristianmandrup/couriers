class Courier < User
  include Mongoid::Document

  # field :location, :type => Array
  # index [[ :location, Mongo::GEO2D ]], :min => -180, :max => 180
  field       :number,            :type => Integer, :default => 1
  
  embeds_one  :working_hours,     :class_name => TimePeriod  
  embeds_one  :bank_account
  embeds_one  :price_structure
  
  embeds_many :vehicles,          :class_name => 'Courier::Vehicle'

  references_one :delivery
  
  field       :current_vehicle,   :type => String
  field       :work_state,        :type => String
  
  # a delivery offer can reference the courier of that offer
  referenced_in :offer,   :inverse_of => :courier, :class_name => "Delivery::Offer"  
  referenced_in :request, :inverse_of => :courier, :class_name => "Delivery::Request"  
  
  validates :work_state, :work_state => true
  
  after_initialize :set_work_state, :set_number

  # API methods
  include Api

  # def location= args
  #   @location = args.kind_of?(String) ? args.split(",").map(&:to_f) : args
  # end

  def current_delivery
    delivery
  end
  
  def travel_mode
    Vehicle.travel_mode_of current_vehicle
  end
  
  def available= value
    self.work_state = value ? 'available' : 'not_available'
  end
  
  def available?
    false
  end
  
  def accepted_delivery?
    "No"
  end
  
  def location
    raise "#location method must be implemented by subclass"    
  end
    
  def address
    raise "#address method must be implemented by subclass"    
  end
  
  def eta
    x = rand(3) > 1 ? rand(200) : rand(30)
    TimePeriod.to_s rand(100) + 60 + x
  end
  
  def rating
    rand(3) + rand(3) + 1    
  end
  
  def price  
    p = rand(10) + rand(6) + 5
    "#{p} euro"
  end
    
  protected
  
  def set_work_state
    self.work_state = 'not_available' if work_state.blank?
  end
  
  def set_number
    self.number = Courier::Counter.current_number
    save
  end 
  
  class << self
    include ::OptionExtractor
    
    def valid_work_states
      [:available, :not_available]
    end    
          
    def available
      in_db = Courier.all.to_a
      in_db.empty? ? create_random(6, :from => :munich, :type => :individual) : in_db
    end
    
    def create_one_random options = {}
      create_courier(options)
    end
    
    def create_random number, options = {}
      number.times.inject([]) do |res, n| 
        res << create_one_random(options)
        res 
      end
    end
  end  
end
