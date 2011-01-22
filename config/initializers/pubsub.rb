require 'pubnub'

module TiramizooApp
  module PubSub
    # "http://pubnub-prod.appspot.com/js-api?pub-key=demo&sub-key=demo&origin=pubsub.pubnub.com&ssl=&java=&devmode=1"
    class << self    
      def instance
        @pubnub ||= Pubnub.new( 'demo', 'demo', '', false )
      end 

      def delivery_channel id
        Delivery.new("delivery-channel-#{id}")
      end

      module Base
        attr_accessor :channel
        
        def initialize channel
          @channel = channel
        end        
        
        def pubnub
          TiramizooApp.pubsub.instance
        end        
      end

      class Delivery
        include Base
               
        def initialize channel
          super('')
        end
                
        def publish directions, delivery = {}
          pubnub.publish({
              'channel' => channel,
              'message' => message(directions, delivery)
          }) 
        end

        protected

        def message directions, delivery
          {
            directions: "3,5km to target",
            pickup: delivery[:pickup].for_json,
            dropoff: delivery[:dropoff].for_json, 
          }
        end
      end
    end
  end
end