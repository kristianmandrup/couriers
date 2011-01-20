class Order
  include Mongoid::Document

  field :number, :type => Integer
      
  embeds_one :booking
end