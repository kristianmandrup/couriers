module ApplicationHelper
  # def current_user
  #   puts "app helper: current_user"
  #   super
  # end

  def courier_channel(id)
    keys = TiramizooApp.pubnub_keys   
    TiramizooApp.pubsub.new(keys.publish, keys.subscribe, keys.secret, keys.ssl_on)
  end

  def current_booking
    session[:booking]
  end

  def current_delivery_offer
    session[:delivery_offer]
  end

  def get_class 
    # controller.controller_name
    # controller.action_name
    'default' # : 'one_col'    
  end

  def map_key
    TiramizooApp.google_key
  end

  def draw_courier_location loc, text = 'I am the greatest!'
    javascript_tag courier_location_script(loc, text)
  end

  def center_map_on_your_location # loc, text = 'You'
    javascript_tag your_location_script #(loc, text)
  end

  def geo_autocomplete_for *fields
    javascript_tag %Q{
$().ready(function() {  
  #{inner_js(fields)} 
});
}
  end

  def inner_js fields
    fields.flat_uniq.inject('') do |res, field|
  	  res << geo_autocomplete_js(field)
    end
  end
      
  def geo_autocomplete_js field        
    s = "geo_autocompletion_for('#{field}', '#{map_key}');\n  " 
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

  def showDeliveryRoute booking
    javascript_tag showDeliveryRoute_script booking
  end
  
  def js_encode(obj)
    ActiveSupport::JSON.encode(obj)
  end

  def showDeliveryRoute_script booking
    return if !booking.pickup || !booking.dropoff
    # booking_obj = js_encode(booking.for_json)
    popPosition = js_encode(booking.pickup.location.for_json)
    podPosition = js_encode(booking.dropoff.location.for_json)
    s = "jQuery(function(){
    TIRAMIZOO.map.showRoute(TIRAMIZOO.route(#{popPosition}, #{podPosition}))
});"    
  end

  def set_pickup_location location
    return if !location
    javascript_tag pickup_location_script(location, 'Pickup')
  end

  def pickup_location_script loc, text = ''
    return if !loc || !loc.lat || !loc.lng
    s = "jQuery(function(){
    TIRAMIZOO.map.setPickupLocation({
      latitude: #{loc.lat}, 
      longitude: #{loc.lng}, 
      text: '#{text}'
  });
});"    
  end

  def set_dropoff_location location
    return if !location
    javascript_tag dropoff_location_script(location, 'Dropoff')
  end

  def dropoff_location_script loc, text = ''
    return if !loc
    s = "jQuery(function(){
    TIRAMIZOO.map.setDropoffLocation({
      latitude: #{loc.lat}, 
      longitude: #{loc.lng}, 
      text: '#{text}'
  });
});"    
  end


  def your_location_script # loc, text = ''
    s = "jQuery(function(){
    TIRAMIZOO.map.init();
    TIRAMIZOO.mapAuto.init();
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
