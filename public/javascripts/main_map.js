/**
 * Controller with utility function for the map
 */
 
TIRAMIZOO = {};
TIRAMIZOO.map = (function ($) {
    var pubsub = TIRAMIZOO.pubsub,
    map,
    mapOptions = {
        zoom: 14,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    },
    geolocation,
    geolocationOptions = {
        enableHighAccuracy:false,
        maximumAge:30000,
        timeout:10000},
    currentLocation,
    currentLocationMarker,
    courierLocations = [],
    courierLocationMarkers = [],

    setupMap = function() {
        console.log("setupMap");  
        mapContainerElem = document.getElementById("map-canvas");
        if (mapContainerElem) {
          map = new google.maps.Map(mapContainerElem, mapOptions);
          currentLocationMarker = new google.maps.Marker({
              map: map,
              title: "YOU!"});          
        } else {
          console.log("Element 'map-canvas' not found")
        }
    },

    setMapCenter = function(position) {
        text = position.text || "You";
        console.log("setMapCenter: lat:" + position.latitude + ", long:" + position.longitude);
        currentLocation = new google.maps.LatLng(position.latitude, position.longitude);
        currentLocationMarker.title = text
        currentLocationMarker.setPosition(currentLocation);
        map.setCenter(currentLocation);
    };

    setCourierLocation = function(position) {
        text = position.text || "A Courier";
        console.log("setCourierLocation: lat:" + position.latitude + ", long:" + position.longitude + " text:" + text);
        courierLocation = new google.maps.LatLng(position.latitude, position.longitude);

        var icon = '/images/bike32.png';                

        courierLocationMarker = new google.maps.Marker({
            map: map,
            title: text,
            icon: icon
        });
        
        courierLocationMarker.setPosition(courierLocation);

        courierLocations.push(courierLocation);
        courierLocationMarkers.push(courierLocation);
    };
    

    $(document).ready(function() {
        console.log("map ready");
        setupMap();
    })
    
    return {
      setMapCenter: setMapCenter,
      setCourierLocation: setCourierLocation
    };
}(jQuery));