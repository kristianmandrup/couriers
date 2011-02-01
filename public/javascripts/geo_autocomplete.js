$().ready(function() {
  var latlng = new google.maps.LatLng(-34.397, 150.644);
  var myOptions = {
    zoom: 8,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

  // use all the autocomplete options as documented at http://docs.jquery.com/Plugins/Autocomplete
  /* additional geo_autocomplete options:
  	mapkey : 'ABQ...' (required for Static Maps thumbnails, obtain a key for your site from http://code.google.com/apis/maps/signup.html)
  	mapwidth : 100
  	mapheight : 100
  	maptype : 'terrain' (see http://code.google.com/apis/maps/documentation/staticmaps/#MapTypes)
  	mapsensor : true or false
  */
  $('#location').geo_autocomplete(new google.maps.Geocoder, {
  	mapkey: 'ABQIAAAAbnvDoAoYOSW2iqoXiGTpYBTIx7cuHpcaq3fYV4NM0BaZl8OxDxS9pQpgJkMv0RxjVl6cDGhDNERjaQ', 
  	selectFirst: false,
  	minChars: 3,
  	cacheLength: 50,
  	width: 300,
  	scroll: true,
  	scrollHeight: 330
  }).result(function(_event, _data) {
  	if (_data) map.fitBounds(_data.geometry.viewport);
  });
});