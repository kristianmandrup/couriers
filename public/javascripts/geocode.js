TIRAMIZOO.namespace("mapAuto");
TIRAMIZOO.mapAuto = (function (app, $) {
    var events = app.events,
    geolocation = app.geolocation,
    g = google.maps,
    map,
    mapOptions = {
        zoom: 10,
        center: new g.LatLng(48.1359717, 11.572207),
        mapTypeId: g.MapTypeId.ROADMAP,
        mapTypeControl: false
    };
    
    function init() {
        map = new g.Map(document.getElementById("map-canvas-auto"), mapOptions);
    } 
    
    function fitBounds(bounds) {
      map.fitBounds(bounds);
    }
           
    return  { 
        fitBounds: fitBounds,
        init: init
    }
}(TIRAMIZOO, jQuery));


TIRAMIZOO.namespace("geoAutocompleteField");
TIRAMIZOO.geoAutocompleteField = function ($, app) {
	// initialize your private vars from the options object and app dependencies here
	var events = app.events,
	options = opts,
	autoCompleteField,
	valid = false,
  ui_geocode_options = {
    	geocoder_region:  'Munich',
    	geocoder_types:   'street_address',
      geocoder_address: false, // true = use the full formatted address, false = use only the segment that matches the search term

      mapwidth:   100, // width of static map thumbnail
      mapheight:  100, // height of static map thumbnail
      maptype:    'terrain', // see http://code.google.com/apis/maps/documentation/staticmaps/#MapTypes
      mapsensor:  false, // see http://code.google.com/apis/maps/documentation/staticmaps/#Sensor

      minLength:  3, // see http://jqueryui.com/demos/autocomplete/#option-minLength
      delay:      300, // see http://jqueryui.com/demos/autocomplete/#option-delay

  		select: this.onSelect
  };
	
	// call init here or remove this call, make init public and call it later
	function init(newOptions) {
	  options = newOptions;
	  autoCompleteField = $("#" + options.fieldID);
		// setup your autocomplete field here
		autoCompleteField.geo_autocomplete(ui_geocode_options);  
	}


	// this is your select change handler which is attached to the autocomplete field
	function onSelect(_event, _ui) {
	  valid = true;
  	if (_ui.item.viewport) {  	  
  	  TIRAMIZOO.mapAuto.fitBounds(_ui.item.viewport);
    }
		// do some stuff and dispatch an event
		events.dispatch("geoAutocompleteFieldChange", valid);
	}
	
	// create all your other internal functions
  function isValid() {
		return valid;
	}

	// return the functions you want to make public here
  return  {
    isValid: isValid,
    init : init
  }
};


TIRAMIZOO.namespace("geocoder");
TIRAMIZOO.geocoder = function ($, app) {

  var options = opts, 
  instance;

  function init(options) {
    callback = options.callback;
  	instance = options.gc;
  }
}


