class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :geolocation
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  def login_or_logout
    login_form if !user_signed_in?
    link_to 'Logout', destroy_user_session_path if user_signed_in?
  end
  
  def login_form
    render :partial => 'users/sign_in'
  end

  def geolocation
    @remote_ip = request.remote_ip
    @geolocation = GeoKit::Geocoders::IpGeocoder.do_geocode(request.remote_ip).country_code
  end

  def get_geo_loc
    cookie = true
    if params['geo']
      @geo_country = params['geo']
      cookie = false
    elsif cookies['geo_country']
      @geo_country = cookies['geo_country']
    else
      @geo_country = GeoKit::Geocoders::IpGeocoder.do_geocode(request.remote_ip).country_code
      @geo_country = 'GB' if @geo_country == 'UK'
    end
    if cookie
      cookies['geo_country'] = {:value => @geo_country, :expire =>; 30.days.from_now}
    else
      cookies.delete 'geo_country'
    end
  end

  # http://stackoverflow.com/questions/4275058/using-devise-with-guest-users

  # def current_user
  #   super || Guest.create # role defaults to 'guest' in the model.
  # end
  # 
  # def user_signed_in?
  #   current_user && !current_user.new_record?
  # end
  # 
  # def user_session
  #   user_signed_in? ? super : session
  # end  
end
