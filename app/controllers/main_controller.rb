class MainController < InheritedResources::Base  
  before_filter :geo_location, :init_user

  # http://www.devarticles.com/c/a/Ruby-on-Rails/Shopping-Cart-Implementation/3/
  
  # use this to initialize booking etc. ?
  # before_filter :initialize_cart

  geo_magic :remote # include GeoMagic::Remote

  # :index creates an empty quote for the Quote form on the main page
  # submit - quote#create fills out quote, and then redirects to booking#new which uses GPS to fill out inital booking  
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
