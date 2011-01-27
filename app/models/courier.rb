class Courier < User
  include Mongoid::Document

  field       :number,            :type => Integer
    
  embeds_one  :bank_account
  embeds_one  :price_structure
  
  embeds_many :vehicles,  :class_name => 'Courier::Vehicle'
  embeds_one  :delivery

  field       :current_vehicle,   :type => String
  field       :work_state,        :type => String

  # a delivery offer can reference the courier of that offer
  referenced_in :offer, :inverse_of => :courier

  validates :work_state, :work_state => true
  
  after_initialize :set_work_state, :set_number

  # API methods

  def get_state
    {:work_state => work_state}
  end

  def get_info
    options = {:work_state => work_state, :travel_mode => travel_mode}
    options.merge!(:current_delivery => delivery) if delivery
    Courier::Info.new options
  end

  # convenience methods

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

  def get_location
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

  def for_json
    {:eta => eta, :rating => rating, :price => price}
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
    include ::AddressHelper
    
    def work_states
      [:available, :not_available]
    end    
    
    def create_individual options = {}
      ci = Courier::Individual.new options
      ci.random_user
      ci.person = options[:person] if options[:person]
      ci.person.address = options[:address] if options[:address]
      ci.delivery = Delivery.create_from options
      ci.work_state = work_states[0].to_s
      ci
    end

    def create_company options = {}
      co = Courier::Company.new
      co.company = Company.create_from options
      co
    end

    def create_from options = {}
      city = extract_city options
      type ||= [:individual, :company].pick_one

      case type
      when :individual        
        create_individual options
      when :company
        create_company options
      end
    end
    
    def available
      in_db = Courier.all.to_a
      in_db.empty? ? create_random(6, :from => :munich, :type => :individual) : in_db
    end
    
    def create_one_random options = {}
      create_from(options)
    end
    
    def create_random number, options = {}
      number.times.inject([]) do |res, n| 
        res << create_from(options)
        res 
      end
    end
  end  
end
