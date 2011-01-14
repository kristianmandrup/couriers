class Location
  attr_accessor :address, :lat, :lng

  def initialize(address, lat, lng)
    @address = address
    @lat = lat
    @lng = lng
  end

  def to_s 
    address.to_s
  end
  
  class << self
    attr_accessor :geo

    def from_ip session
      # @remote_ip = request.remote_ip 
      # puts "IP: #{request.remote_ip}"
      puts "Local IP: #{session[:local_ip].inspect}"
      begin
        @geolocation ||= GeoKit::Geocoders::IpGeocoder.do_geocode(session[:local_ip])
      rescue Exception => e
          case e
              when Errno::ECONNRESET
                  p e
              when Errno::ECONNRESET,Errno::ECONNABORTED,Errno::ETIMEDOUT
                  p 2
              else
                  p e
          end
      end      
    end
  end 
  
  # def set_current_ip
  #     if params[:organization] && params[:host]
  #             @getip = Getip.new
  #             @getip.organization = params[:organization]
  #             @getip.host = params[:host]
  #             @getip.dyn_ip = request.env['REMOTE_ADDR']
  #             @getip.save
  #     end
  # end  
end
