class Courier::Price::BeyondHours
  include Mongoid::Document

  field :price,                 :type => Float # price outside biz hours
  field :business_hours_start,  :type => Time 
  field :business_hours_end,    :type => Time 
  
  def initialize price, time_range
    self.distance_limit = distance_limit
    self.business_hours = time_range
  end
  
  def business_hours= time_range
    # shit!
  end
end
