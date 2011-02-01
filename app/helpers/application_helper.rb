module ApplicationHelper
  # def current_user
  #   puts "app helper: current_user"
  #   super
  # end

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
    %Q{$('##{field}').geo_autocomplete(new google.maps.Geocoder, {
	mapkey: '#{map_key}', 
	selectFirst: false,
	minChars: 3,
	cacheLength: 50,
	width: 300,
	scroll: true,
	scrollHeight: 330
}).result(function(_event, _data) {
	if (_data) {
	  TIRAMIZOO.mapAuto.fitBounds(_data.geometry.viewport);
	}
});
}
  end
  
  def courier_location_script loc, text = ''
    ""
    s = "jQuery(function(){
    TIRAMIZOO.map.setCourierLocation({
      latitude: #{loc.lat}, 
      longitude: #{loc.lng}, 
      text: '#{text}'
  });
});"    
  end

  # TIRAMIZOO.map.setMapCenter({
  #   latitude: #{loc.lat}, 
  #   longitude: #{loc.lng}, 
  #   text: '#{text}'
  # });
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
