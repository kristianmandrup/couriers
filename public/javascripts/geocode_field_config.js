TIRAMIZOO.geocodeScreenConfig = {};

TIRAMIZOO.namespace("geocodeFieldConfig");
TIRAMIZOO.geocodeFieldConfig = function ($, app, opts) {
  // then somewhere in your code instantiate the objects here with all your custom options
  console.log('app', app);
  console.log('options', opts);

	var options = opts,
	popFieldId  = options.popId,
	podFieldId  = options.podId,

	popAutoComplete = app.geoAutocompleteField($, app).init({fieldID: popFieldId}),
  podAutoComplete = app.geoAutocompleteField($, app).init({fieldID: podFieldId}),

	map             = app.map, 
	gc              = new google.maps.Geocoder(),
	route           = app.route,

	popGeocoder = geocodeConfig($, app).init({geocoder: gc}),
	podGeocoder = geocodeConfig($, app).init({geocoder: gc}),

  popGeocoder.callback = options.callbacks.podGeocoded,
  podGeocoder.callback = options.callbacks.popGeocoded,

	podPoint = null, // will be filled out on successful geocoding!
	popPoint = null;

  function updateMap(geocoded_location, geocode_marker) {
    var address = geocoded_location.locality + ", " + geocoded_location.region;
  }
  
  function geocodeField(fieldId, geocoder) {
   var address = {};
   address.address = $(fieldId).value;
   geocoder.instance.geocode(address, geocoder.callback);
  }
  
  function bothPointsAreValid() {
      return popAutoComplete.isValid() && podAutoComplete.isValid();
  }
  
  function popIsValid() {
      return popAutoComplete.isValid();
  }
  
  
  function podIsValid() {
    return podAutoComplete.isValid();    
  }

  function updateNearbyCouriers() {
    map.getNearbyCouriers(function () {
      console.log("nearby couriers updated!");
    });
  } 
  
  app.events.add("validPop", function() {
    geocodeField(popFieldId, popGeocoder);
    updateNearbyCouriers();    
  });
  
  app.events.add("validPod", function() {
    geocodeField(podFieldId, podGeocoder);   
  });
  
  app.events.add("validPopAndPod", function() {
      map.showRoute(route(podPoint, popPoint))
  });
  
  app.events.add("geoAutocompleteFieldChange", function() {
    if (popIsValid()) {
      events.dispatch("validPop");
    }
  
    if (podIsValid()) {
      events.dispatch("validPod");
    }
  
    if (bothPointsAreValid()) {
      events.dispatch("validPopAndPod");
    }
  });
};

