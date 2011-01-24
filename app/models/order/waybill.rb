class Order::Waybill
  include Mongoid::Document

  field :ticket_nr, :type => Integer
    
  embeds_one :booking, :class_name => 'Order::Booking'

  def pickup
    booking.pickup
  end

  def dropoff
    booking.dropoff
  end

  
  def for_json
    {:ticket_nr => ticket_nr, :booking => booking.for_json}
  end

  def into_json
    for_json.to_json
  end

  def to_s
    %Q{
ticket #: #{ticket_nr}
booking: #{booking}
}
  end


  class << self
    def create_from_booking booking
      waybill = self.new :ticket_nr => random_ticket_nr
      waybill.booking = booking
      waybill
    end
    
    def create_from city = :munich
      waybill = self.new :ticket_nr => random_ticket_nr
      waybill.booking = Order::Booking.create_from city      
      waybill
    end   
    
    def random_ticket_nr
      (rand(10000) + 1).to_s
    end
  end  
end