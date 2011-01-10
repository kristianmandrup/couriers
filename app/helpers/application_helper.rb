module ApplicationHelper
  def login_or_logout
    login_form if !user_signed_in?
    link_to 'Logout', destroy_user_session_path if user_signed_in?
  end
  
  def login_form
    render :partial => 'users/sign_in'
  end
end
