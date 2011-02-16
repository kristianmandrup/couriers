require 'order/place_ext/api'
require 'order/place_ext/class_methods'
require 'order/place_ext/proxies'

class Order
  class Place
    include Mongoid::Document

    field       :notes, :type => String
    
    embeds_one  :contact
    embeds_one  :address

    extend  Order::PlaceExt::ClassMethods
    include Order::PlaceExt::Api
    include Order::PlaceExt::Proxies

    def self.inherited(base)
      base.extend Order::PlaceExt::ClassMethods
      base.send :include, Order::PlaceExt::Proxies
    end

    def to_s
    %Q{
contact: 
#{contact}

address: 
#{address}

notes: #{notes}
}
    end
  end
end