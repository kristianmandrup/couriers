class PickupAddress < Address
  include Mongoid::Document
  
  embedded_in :booking, :inverse_of => :pickup_address 
end