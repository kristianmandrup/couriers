class MainController < InheritedResources::Base  
  before_filter :geo_location, :init_user

  geo_magic :remote # include GeoMagic::Remote
  
  def index
    @quote = Order::Quote.new
  end

  def init_user
    return if !current_user
    current_user.country = session[:location].country.name
    current_user.country_code = session[:location].country.code
    current_user.language = session[:location].country.code
    current_user.save
  end
  
  def geo_location
    session[:ip] ||= GeoMagic::Remote.my_ip
    session[:location] ||= GeoMagic::Remote.my_location
  end
end
