class Order::Waybill
  include Mongoid::Document

  field :ticket_nr, :type => Integer
    
  embeds_one :booking
  
  def for_json
    {:ticket_nr => ticket_nr, :booking => booking.for_json}
  end

  def into_json
    for_json.to_json
  end

  class << self
    def create_from city = :munich
      waybill = self.new :ticket_nr => '12345'
      waybill.booking = Order::Booking.create_from city      
      waybill
    end
  end  
end