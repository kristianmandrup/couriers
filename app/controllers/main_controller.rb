class MainController < InheritedResources::Base  
  # before_filter :init_user

  # http://www.devarticles.com/c/a/Ruby-on-Rails/Shopping-Cart-Implementation/3/
  
  # :index creates an empty quote for the Quote form on the main page
  # submit - quote#create fills out quote, and then redirects to booking#new which uses GPS to fill out inital booking  
  def index
    redirect_to new_customer_order_booking_path
  end

  # def init_user
  #   return if !current_user
  #   current_user.country      = session[:location].country.name
  #   current_user.country_code = session[:location].country.code
  #   current_user.language     = session[:location].country.code
  #   current_user.save
  # end  
end
