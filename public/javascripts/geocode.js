TIRAMIZOO.namespace("geoAutocompleteField");
TIRAMIZOO.geoAutocompleteField = (function ($, app) {
	// initialize your private vars from the options object and app dependencies here
	var events = app.events,
	mapAuto = app.mapAuto,
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

  		select: onSelect
  },
  
  otherOptions = {
  	geocoder_region:  'Munich',
  	geocoder_types:   'street_address',

  	mapwidth: 75,
  	mapheight: 75,
  	geocoder_address: true,
  	maptype: 'roadmap',
		notify: {
		  selector: '#notifier',
		  message: 'You must write a full street address'
	  },

  	select: function (_event, _ui) { 
  	  console.log('inside onSelect:', valid);
    }  		
  };  
	
	// call init here or remove this call, make init public and call it later
	function init(id) {
	  console.log('geoAutocompleteField init:', id);
	  autoCompleteField = $("#" + id);
		// setup your autocomplete field here
    console.log('ui_geocode_options:', ui_geocode_options);
    if (!ui_geocode_options) {
      // ui_geocode_options.select = onSelect;
      console.log('ui_geocode_options:', ui_geocode_options);
    }        
    // console.log('map', mapAuto.getMap());
		autoCompleteField.geo_autocomplete(otherOptions);  
	}


	// this is your select change handler which is attached to the autocomplete field
	function onSelect(_event, _ui) {
	  valid = true;
	  console.log('inside onSelect:', valid);
		// do some stuff and dispatch an event
		events.dispatch("geoAutocompleteFieldChange", isValid);
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
}(jQuery, TIRAMIZOO));


TIRAMIZOO.namespace("geocoder");
TIRAMIZOO.geocoder = function (options) {
  var callback = options.callback;
  
  function init(options) {
	  console.log('geocoder init:', options);    
    callback = options.callback;
  }
}

TIRAMIZOO.geocoder.instance = new google.maps.Geocoder();

TIRAMIZOO.main = (function (app, $) {
    var courier = app.courier,
    map = app.map,
    mapAuto = app.mapAuto,
    events = app.events,
    geolocation = app.geolocation,
    pubsub = app.pubsub;

    function init() {
        console.log('main init', map);
        map.init(); 
    }

    return {
        init: init
    }

}(TIRAMIZOO, jQuery));

$(document).ready(function() {
  TIRAMIZOO.main.init();    

  TIRAMIZOO.geoAutocompleteField.init('customer_order_booking_pickup_attributes_street');
  // TIRAMIZOO.geoAutocompleteField.init('customer_order_booking_dropoff_attributes_street');  
  // $('#customer_order_booking_pickup_attributes_street').geo_autocomplete();    
  $('#customer_order_booking_dropoff_attributes_street').geo_autocomplete();
});



