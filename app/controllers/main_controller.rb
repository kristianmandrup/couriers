class MainController < InheritedResources::Base  
  before_filter :geolocation  

  include Geokit::Geocoders
  
  def index
    @location = true # geolocation here!
    @quote = Quote.new      
    
    puts "Remote: #{request.env['REMOTE_ADDR']}"
    puts "Forw: #{request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip }"
    puts "Local: #{local_ip}"
    session[:local_ip] ||= local_ip
  end
  
  def geolocation
    Location.from_ip session
  end   
  
  require 'socket'

  def local_ip
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily

    UDPSocket.open do |s|
      s.connect '64.233.187.99', 1
      s.addr.last
    end
  ensure
    Socket.do_not_reverse_lookup = orig
  end
  
end
