module ApplicationHelper
  def login_or_logout
    link_to 'Login', user_session_path if logged_in?
    link_to 'Logout', destroy_user_session_path if !logged_in?
  end
end
