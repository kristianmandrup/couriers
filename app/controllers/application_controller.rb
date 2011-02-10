class ApplicationController < ActionController::Base
  # protect_from_forgery  

  before_filter :set_locale
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  include Shared::UsersHelper
  include Shared::LocaleHelper
end
