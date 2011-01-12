class PickupAddress < Address
  include Mongoid::Document
  
  embedded_in :booking, :inverse_of => :pickup_address
  embeds_one :contact
end