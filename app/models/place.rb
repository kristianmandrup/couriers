# require "net/http"
# require 'mongoid'
# require 'active_support'
# require 'rack'

class Place
  include Mongoid::Document

  field :name
  field :street

  field :lat, :type => Float
  field :lng, :type => Float

  def do_geocode!
    response = Net::HTTP.get_response(URI.parse("http://maps.googleapis.com/maps/api/geocode/json?address=#{Rack::Utils.escape(street)}&sensor=false"))
    json = ActiveSupport::JSON.decode(response.body)
    self.lat, self.lng = json["results"][0]["geometry"]["location"]["lat"], json["results"][0]["geometry"]["location"]["lng"]
  rescue Exception => e
    puts e.message  
    puts e.backtrace.inspect
    false # For now, fail silently...
  end
end
              
# place = Place.new
# place.street = "Paris, France"
# place.do_geocode!