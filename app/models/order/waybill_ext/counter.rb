require 'singleton'

class Order
  class Waybill
    class Counter
      include Singleton
      
      def next_ticket_nr
        next_letter << random_numbers(6)
      end    

      def random_numbers count
        count.times.map {|n|  rand(10).to_s }.join
      end
  
      def next_letter
        ('A'..'Z').to_a.pick_one
      end
    end
  end
end