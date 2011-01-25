class ApplicationController < ActionController::Base
  # protect_from_forgery
  
  before_filter :set_locale
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  def guest_options
   session[:guest_options] ||= {}
  end

  def current_user   
    if !session[:user_id]
      @guest ||= Guest.create(guest_options) 
      return @guest
    end
    if session[:user_id]  
      begin
        clazz = session[:user_class_name].constantize
        @current_user ||= clazz.find session[:user_id] 
        return @current_user
      rescue Exception => e
        @guest ||= Guest.create(guest_options)
      end
    end
  end

  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale] || extract_locale_from_tld
  end

  def default_url_options(options={})
    # logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  # Get locale from top-level domain or return nil if such locale is not available
  # You have to put something like:
  #   127.0.0.1 application.com
  #   127.0.0.1 application.it
  #   127.0.0.1 application.pl
  # in your /etc/hosts file to try this out locally
  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale  : nil
  end

  # USAGE
  # link_to("Deutsch", "#{APP_CONFIG[:deutsch_website_url]}#{request.env['REQUEST_URI']}")
  # assuming you would set APP_CONFIG[:deutsch_website_url] to some value like http://www.application.de.

  # Get locale code from request subdomain (like http://it.application.local:3000)
  # You have to put something like:
  #   127.0.0.1 gr.application.local
  # in your /etc/hosts file to try this out locally
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale  : nil
  end
end
