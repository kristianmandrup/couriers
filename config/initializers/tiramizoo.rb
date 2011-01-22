require 'pubnub'

module TiramizooApp
  def self.geocoder
    GeoMagic.geo_coder(:env => :rails).instance
  end   
              
  # "http://pubnub-prod.appspot.com/js-api?pub-key=demo&sub-key=demo&origin=pubsub.pubnub.com&ssl=&java=&devmode=1"
  def self.pubnub
    @pubnub ||= Pubnub.new( 'demo', 'demo', '', false )
  end
end
  