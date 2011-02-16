class Order
  module WaybillExt
    module ClassMethods      
      include ::OptionExtractor

      def create_for options = {}
        waybill = Order::Waybill.new options
        waybill.booking = extract_booking(options)
        waybill
      end    
    end  
  end
end