class Booking
  include Mongoid::Document

  embeds_one :pickup_address  
  embeds_one :dropoff_address  
  
  def for_json
    {:pickup_address => pickup_address.for_json, :dropoff_address => dropoff_address.for_json}
  end

  def into_json
    for_json.to_json
  end
  
  accepts_nested_attributes_for :pickup_address, :allow_destroy => true    
  accepts_nested_attributes_for :dropoff_address, :allow_destroy => true    
end

# class Booking
#   include Mongoid::Document
# 
#   embeds_one :pickup_address #,   :class => 'Address'
#   embeds_one :dropoff_address #,  :class => 'Address'
#   # 
#   embeds_one :vehicle
# 
#   field :city, :type => String
#   field :street, :type => String
# 
#   accepts_nested_attributes_for :pickup_address, :allow_destroy => true  
#   
#   def self.create quote
#     # create from a quote
#   end
# end
