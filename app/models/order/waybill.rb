class Order
  class Waybill
    include Mongoid::Document

    field       :ticket_nr,     :type => Integer    
    embeds_one  :booking,       :class_name => 'Order::Booking'
    embedded_in :order,         :class_name => 'Order',         :inverse_of => :waybill

    module Api
      def for_json
        {:ticket_nr => ticket_nr, :booking => booking.for_json}
      end
    end
    include Api

    def pickup
      booking.pickup
    end

    def dropoff
      booking.dropoff
    end
  
    def to_s
      %Q{
  ticket #: #{ticket_nr}
  booking: #{booking}
  }
    end

    class << self    
      include ::OptionExtractor
    
      def create_for options = {}
        waybill = self.new options
        waybill.booking = extract_booking(options)
        waybill
      end    
    end  
  
    protected

    def counter
      Order::Waybill::Counter    
    end
  
    def setup
      self.ticket_nr = counter.next_ticket_nr
    end  
  end
end