class Order::Waybill
  include Mongoid::Document

  field :ticket_nr, :type => Integer
    
  embeds_one :booking
end