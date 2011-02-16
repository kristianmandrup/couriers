class Order
  module WaybillExt
    module Api
      def for_json
        {:ticket_nr => ticket_nr, :booking => booking.for_json}
      end
    end
  end
end