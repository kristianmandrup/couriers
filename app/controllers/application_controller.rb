class ApplicationController < ActionController::Base
  protect_from_forgery
  
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
