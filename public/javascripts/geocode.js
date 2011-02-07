// function geo_autocompletion_for(field, type) {
//   $('#' + field).geo_autocomplete(ui_geocode_options(type));  
// }

TIRAMIZOO.namespace("geoAutocompleteField");
TIRAMIZOO.geoAutocompleteField = function ($, app, opts) {
	// initialize your private vars from the options object and app dependencies here
	var events = app.events,
	options = opts,
	validPickupLocation = false,
	validDropoffLocation = false,
	autoCompleteField = $("#" + opts.fieldID),
	valid;
	
	// call init here or remove this call, make init public and call it later
	init();

	function init() {
		// setup your autocomplete field here
		autoCompleteField.geo_autocomplete(ui_geocode_options);  
	}

  var ui_geocode_options = {
    	geocoder_region:  'Munich',
    	geocoder_types:   'street_address',
      geocoder_address: false, // true = use the full formatted address, false = use only the segment that matches the search term

      mapwidth: 100, // width of static map thumbnail
      mapheight: 100, // height of static map thumbnail
      maptype: 'terrain', // see http://code.google.com/apis/maps/documentation/staticmaps/#MapTypes
      mapsensor: false, // see http://code.google.com/apis/maps/documentation/staticmaps/#Sensor

      minLength: 3, // see http://jqueryui.com/demos/autocomplete/#option-minLength
      delay: 300, // see http://jqueryui.com/demos/autocomplete/#option-delay

  		select: this.onSelect
  };  

	// this is your select change handler which is attached to the autocomplete field
	function onSelect(_event, _ui) {
	  valid = false;
  	if (_ui.item.viewport) {
  	  valid = true;
  	  TIRAMIZOO.mapAuto.fitBounds(_ui.item.viewport);
    }
		// do some stuff and dispatch an event
		events.dispatch("geoAutocompleteFieldChange");
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
TIRAMIZOO.geocoder = function ($, app, opts) {

  var options = opts, 
  instance;

  init(options);

  function init(options) {
    callback = options.callback;
  	instance = options.gc;
  }
}


