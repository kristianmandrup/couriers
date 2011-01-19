module ApplicationHelper
  # def current_user
  #   puts "app helper: current_user"
  #   super
  # end

  def draw_courier_location loc, text = 'I am the greatest!'
    javascript_tag courier_location_script(loc, text)
  end

  def center_map_on_your_location loc, text = 'You'
    javascript_tag your_location_script(loc, text)
  end
  
  def courier_location_script loc, text = ''
    s = "jQuery(function(){
  TIRAMIZOO.map.setCourierLocation({
    latitude: #{loc.lat}, 
    longitude: #{loc.lng}, 
    text: '#{text}'
  });
});"    
  end

  def your_location_script loc, text = ''
    s = "jQuery(function(){
  TIRAMIZOO.map.setMapCenter({
    latitude: #{loc.lat}, 
    longitude: #{loc.lng}, 
    text: '#{text}'
  });
});"    
  end


  def login_or_logout
    login_form if !user_signed_in?
    link_to 'Logout', destroy_user_session_path if user_signed_in?
  end
  
  def login_form
    render :partial => 'users/sign_in'
  end
end
