require 'order/offer/class_methods'
require 'order/offer/api'
require 'order/offer/places'
require 'order/offer/state'

# Every delivery Order can be sent out as an offer to one or more couriers who will respond to that offer
class Order
  class Offer
    include Mongoid::Document

    field :number,          :type => String
    field :max_couriers,    :type => Integer, :default => 3
    field :time_notified,   :type => Time
    field :state,           :type => String

    references_one  :accepted_courier,  :class_name => 'Courier'
    embeds_many     :order_requests,    :class_name => 'Order::Request'

    embedded_in     :order,             :inverse_of => :offer

    validates :booking, :presence => true
    validates :state, :presence => true, :offer_state => true

    after_initialize :setup

    extend ClassMethods
    include Api 

    include Places # dropoff, pickup, location 
    include State 

    def to_s
      %Q{number: #{number}
        booking:
        #{booking}
        requests:
        #{delivery_requests.map(&:to_s)}
      }
    end

    def for_couriers couriers
      self.delivery_requests = []
      couriers.each do |courier|
        self.delivery_requests << self.class.create_request(courier)
      end
      self.save
    end

    def delivery_request_for courier
      delivery_requests.each do |req|
        return req if req.courier.number == courier.number
      end
      nil
    end

    protected

    def counter
      Order::Counter::Offer
    end
  
    def setup
      self.state = :ready
      self.number = counter.next
    end
  end
end