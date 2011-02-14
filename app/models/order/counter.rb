class Order::Counter
  include Mongoid::Document
  
  field :order_number,    :type => Integer
  field :booking_number,  :type => Integer
  field :offer_number,    :type => Integer

  def self.instance
    if !Order::Counter.first
      Order::Counter.create :booking_number => 0, :offer_number => 0, :delivery_number => 0
    end
    @instance ||= Order::Counter.first
  end

  module Abstract
    def counter
      Order::Counter
    end
  end

  module Offer
    extend Order::Counter::Abstract
    
    def self.next
      counter.inc_offer
    end
  end

  module Booking
    extend Order::Counter::Abstract
    
    def self.next
      counter.inc_booking
    end
  end

  def current_booking_number
    instance.booking_number
  end

  def current_offer_number
    instance.offer_number
  end

  def current_order_number
    instance.order_number
  end

  def self.next
    inc_order
  end

  def self.reset_numbers
    instance.offer_number = 0
    instance.booking_number = 0
    instance.order_number = 0    
    instance.save
    instance    
  end
  
  def self.inc_booking
    instance.inc(:booking_number, 1)
    instance.save
    instance.booking_number    
  end

  def self.inc_offer
    instance.inc(:offer_number, 1)
    instance.save
    instance.offer_number    
  end  

  def self.inc_order
    instance.inc(:order_number, 1)
    instance.save
    instance.order_number
  end  
end