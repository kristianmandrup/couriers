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

  function ui_geocode_options {
    return {
    	geocoder_region:  'Munich',
    	geocoder_types:   'street_address',
      geocoder_address: false, // true = use the full formatted address, false = use only the segment that matches the search term

      mapwidth: 100, // width of static map thumbnail
      mapheight: 100, // height of static map thumbnail
      maptype: 'terrain', // see http://code.google.com/apis/maps/documentation/staticmaps/#MapTypes
      mapsensor: false, // see http://code.google.com/apis/maps/documentation/staticmaps/#Sensor

      minLength: 3, // see http://jqueryui.com/demos/autocomplete/#option-minLength
      delay: 300, // see http://jqueryui.com/demos/autocomplete/#option-delay

  		select: onSelect
    }
  }  

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
    init : init,
    onDropoffUpdated,
    onPickupUpdated    
  }
};


TIRAMIZOO.namespace("geocoder");
TIRAMIZOO.geocoder = function ($, app, options) {

  var mapstraction,
  options = opts,
  geocoder;

  // SAMPLE
  // function geocode_return(geocoded_location) {
  //  
  //  // display the map centered on a latitude and longitude (Google zoom levels)
  //  mapstraction.setCenterAndZoom(geocoded_location.point, 15);
  // 
  //  // create a marker positioned at a lat/lon
  //  var geocode_marker = new mxn.Marker(geocoded_location.point);
  // 
  //  var address = geocoded_location.locality + ", " + geocoded_location.region;
  //  geocode_marker.setInfoBubble(address);
  //  
  //  // display marker
  //  mapstraction.addMarker(geocode_marker);
  // 
  //  // open the marker
  //  geocode_marker.openBubble();
  // }

  init(options);

  function init(options) {
  	// create mxn object                              
  	apis = options.apis || 'googlev3'
  	mapstraction = new mxn.Mapstraction('map-canvas', apis);
  	geocoder = new mxn.Geocoder(apis, geocode_return);		
  }
}(jQuery, TIRAMIZOO, {});

// then somewhere in your code instantiate the objects here with all your custom options
(function($, app) {

	var popFieldId  = "order_quote_pickup_point",
	podFieldId      = "order_quote_dropoff_point",
	popAutoComplete = app.geoAutocompleteField($, app, {fieldID: popFieldId}),
	podAutoComplete = app.geoAutocompleteField($, app, {fieldID: podFieldId}),
	map = app.map, 
	geocoder = app.geocoder,
	mapstraction = geocoder.mapstraction,
	route = app.route,

	popGeocoder = geocoder, // init here? should each have a seperate instance!
	podGeocoder = geocoder,

	podPoint = null,
	popPoint = null;

  // customize how to handle geocode return for pod
  popGeocoder.geocode_return = function (geocoded_location) {
    
     // create a marker positioned at a lat/lon
     // IMPORTANT: distinct marker icon here!
     var geocode_marker = new mxn.Marker(geocoded_location.point);
     popPoint = geocoded_location.point;
     
     updateMap(geocoded_location);
  }

  // customize how to handle geocode return for pod
  podGeocoder.geocode_return = function (geocoded_location) {    
     // create a marker positioned at a lat/lon
     // IMPORTANT: distinct marker icon here!
     var geocode_marker = new mxn.Marker(geocoded_location.point);
     podPoint = geocoded_location.point;
     
     updateMap(geocoded_location, geocode_marker);    
  }

  function updateMap(geocoded_location, geocode_marker) {
    // display the map centered on a latitude and longitude (Google zoom levels)
    mapstraction.setCenterAndZoom(geocoded_location.point, 15);

    var address = geocoded_location.locality + ", " + geocoded_location.region;
    geocode_marker.setInfoBubble(address);
    
    // display marker
    mapstraction.addMarker(geocode_marker);
   
    // open the marker
    geocode_marker.openBubble();    
  }

  function geocodeField(fieldId, geoCoder) {
		var address = {};
		address.address = $(fieldId).value;
		geoCoder.geocode(address);
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
	  geocodeField(podFieldId, , podGeocoder);	  
  });

	app.events.add("validPopAndPod", function() {
    map.showRoute(route(podPoint, popPoint))
  });

	app.events.add("geoAutocompleteFieldChange", function() {
    if popIsValid() {
      events.dispatch("validPop");
    }

    if podIsValid() {
      events.dispatch("validPod");
    }

		if (bothPointsAreValid()) {
      events.dispatch("validPopAndPod");
		}
	})
})(jQuery, TIRAMIZOO);

// FOR REFERENCE:

// geocode_callback: function(results, status){
//  var return_location = {};
// 
//  if (status != google.maps.GeocoderStatus.OK) {
//    this.error_callback(status);
//  } 
//  else {
//    return_location.street = '';
//    return_location.locality = '';
//    return_location.region = '';
//    return_location.country = '';
// 
//    var place = results[0];
//    
//    for (var i = 0; i < place.address_components.length; i++) {
//      var addressComponent = place.address_components[i];
//      for (var j = 0; j < addressComponent.types.length; j++) {
//        var componentType = addressComponent.types[j];
//        switch (componentType) {
//          case 'country':
//            return_location.country = addressComponent.long_name;
//            break;
//          case 'administrative_area_level_1':
//            return_location.region = addressComponent.long_name;
//            break;
//          case 'locality':
//            return_location.locality = addressComponent.long_name;
//            break;
//          case 'street_address':
//            return_location.street = addressComponent.long_name;
//            break;
//        }
//      }
//    }
//    
//    return_location.point = new mxn.LatLonPoint(place.geometry.location.lat(), place.geometry.location.lng());
//    
//    this.callback(return_location);
//  }
// }