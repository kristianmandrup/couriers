class Courier < User
  include Mongoid::Document

  # field :location, :type => Array
  # index [[ :location, Mongo::GEO2D ]], :min => -180, :max => 180
  field           :number,            :type => Integer, :default => 1
                  
  field           :tax_number,        :type => String
  field           :insurance_number,  :type => String
                  
  field           :heard_from,        :type => String   # where the courier heard about tiramizoo
                  
  field           :zip_codes,         :type => Array
  field           :gps,               :type => Boolean,   :default => false                   
  field           :current_vehicle,   :type => String

  field           :work_state,        :type => String
  field           :account_state,     :type => String
  
  embeds_one      :working_hours,     :class_name => TimePeriod  
  embeds_one      :bank_account
  embeds_one      :price_structure  

  references_one  :order
  
  embeds_many     :vehicles,          :class_name => 'Courier::Vehicle'

  # a delivery offer can reference the courier of that offer
  referenced_in   :offer,             :class_name => "Order::Offer",    :inverse_of => :courier, 
  referenced_in   :request,           :class_name => "Order::Request",  :inverse_of => :courier, 
  
  validates       :work_state,        :work_state => true
  
  after_initialize :set_work_state, :set_number

  extend ClassMethods

  # API methods
  include Api
  include Proxies
  include Scopes
  include Vehicles
  include Derived

  def current_delivery
    order
  end
    
  def available= value
    self.work_state = value ? 'available' : 'not_available'
  end
  
  def available?
    self.work_state == 'available'
  end
    
  def location
    raise "#location method must be implemented by subclass"    
  end
    
  def address
    raise "#address method must be implemented by subclass"    
  end
      
  protected
  
  def set_work_state
    self.work_state = 'not_available' if work_state.blank?
  end
  
  def set_number
    self.number = Courier::Counter.current_number
    save
  end
end
