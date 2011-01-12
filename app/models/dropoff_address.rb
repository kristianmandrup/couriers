class DropoffAddress < Address
  include Mongoid::Document
  embedded_in :booking, :inverse_of => :dropoff_address  
  embeds_one :contact  
end