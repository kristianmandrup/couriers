/**
 * Declare TIRAMIZOO global and namespace utility function
 * Used to create namespaces for the module pattern
 */
var TIRAMIZOO = TIRAMIZOO || {};
TIRAMIZOO.namespace = function (namespaceStr) {
    var parts = namespaceStr.split("."),
    parent = TIRAMIZOO,
    i;

    if (parts[0] === "TIRAMIZOO") {
        parts = parts.slice(1);
    }

    for (i = 0; i < parts.length; i += 1) {
        if (typeof parent[parts[i]] === "undefined") {
            parent[parts[i]] = {};
        }
        parent = parent[parts[i]];
    }
    return parent;
};

/**
 * Logging utility
 */
TIRAMIZOO.log = function (obj) {
    console.log(obj);
};


/**
 * Object to hold the courier state
 */
TIRAMIZOO.namespace("model");
TIRAMIZOO.model = (function ($) {
    return {
        courier: {
            AVAILABLE: "available",
            NOT_AVAILABLE: "not_available"
        },
        radar: {}
    };
}(jQuery));


/**
 * Global event bus
 */
TIRAMIZOO.namespace("events");
TIRAMIZOO.events = (function (app, $) {
    function add(event, callback) {
        $(app.events).bind(event, callback);
    }

    function remove(event, callback) {
        $(app.events).unbind(event, callback);
    }

    function dispatch(event, data) {
        $(app.events).trigger(event, data);
    }

    return {
        add: add,
        remove: remove,
        dispatch: dispatch
    }
}(TIRAMIZOO, $));

/**
 * Functions for Geolocation API
 */
TIRAMIZOO.namespace("geolocation");
TIRAMIZOO.geolocation = (function (app, $) {
    var geolocation,
    geolocationOptions = {
        enableHighAccuracy: false,
        maximumAge: 30000,
        timeout: 30000},
    geolocationID;

    function init() {
        geolocation = navigator.geolocation;
        app.log(geolocation ? "hasGeolocation" : "noGeolocation");
        if (geolocation) {
            if (geolocationID) {
                geolocation.clearWatch(geolocationID);
            }
            getCurrentPosition();
            geolocationID = geolocation.watchPosition(geolocationChanged, geolocationError, geolocationOptions);
        } else {
            geolocationError({code:"general"});
        }
    }

    function getCurrentPosition() {
        geolocation.getCurrentPosition(geolocationSuccess, geolocationError, geolocationOptions);
    }

    function geolocationSuccess(geoPosition) {
        app.log("geolocationSuccess");
        updateGeoPosition(geoPosition);
    }

    function geolocationChanged(geoPosition) {
        app.log("geolocationChanged");
        updateGeoPosition(geoPosition);
    }

    function geolocationError(error) {
        switch (error.code) {
            case error.PERMISSION_DENIED:
                app.log("geolocationError: PERMISSION_DENIED");
                break;
            case error.POSITION_UNAVAILABLE:
                app.log("geolocationError: POSITION_UNAVAILABLE");
                getCurrentPosition();
                break;
            case error.TIMEOUT:
                app.log("geolocationError: TIMEOUT");
                getCurrentPosition();
                break;
            default:
                app.log("geolocationError: OTHER");
                break;
        }
    }

    function updateGeoPosition(geoPosition) {
        var position = {
            latitude: geoPosition.coords.latitude,
            longitude: geoPosition.coords.longitude};
        events.dispatch("geolocationUpdated", position);
    }

    return {
        init: init
    }

}(TIRAMIZOO, jQuery));

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

TIRAMIZOO.namespace("map");
TIRAMIZOO.map = (function (app, $) {
    var courier = app.courier,
    events = app.events,
    geolocation = app.geolocation,
    g = google.maps,
    map,
    mapOptions = {
        zoom: 14,
        center: new g.LatLng(48.1359717, 11.572207),
        mapTypeId: g.MapTypeId.ROADMAP,
        mapTypeControl: false,
        navigationControl: true,
        navigationControlOptions: {
            style: g.NavigationControlStyle.ZOOM_PAN,
            position: g.ControlPosition.LEFT_CENTER
        },
        scaleControl: true,
        scaleControlOptions: {
            position: g.ControlPosition.LEFT_CENTER
        }
    },
    currentLocationMarker,
    nearbyCourierMarkers,
    directionsRenderer,
    courierLocations = [],
    courierLocationMarkers = [],
    currentRoute;

    function init() {
        canvas = document.getElementById("map-canvas")
        map = new g.Map(canvas, mapOptions);
        currentLocationMarker = new g.Marker({map: map, position: mapOptions.center, title: "YOU!"});
        updatePosition({latitude: mapOptions.center.lat(), longitude: mapOptions.center.lng()});
        events.add("geolocationUpdated", getlocationUpdated);
    }

    function setCourierLocation(position) {
        text = position.text || "A Courier";
        // console.log("setCourierLocation: lat:" + position.latitude + ", long:" + position.longitude + " text:" + text);
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
    }


    function getlocationUpdated(event, position) {
        updatePosition(position);
    }

    function updatePosition(position) {
        var currentLocation = new g.LatLng(position.latitude, position.longitude);
        currentLocationMarker.setPosition(currentLocation);
        map.setCenter(currentLocation);
    }

    function showMyLocation() {
        map.setCenter(currentLocationMarker.getPosition());
    }

    function getNearbyCouriers(callback) {
        var bounds = map.getBounds(),
        northEast = bounds.getNorthEast(),
        southWest = bounds.getSouthWest();
        courier.getNearbyCouriers({
                northEast: {
                    latitude: northEast.lat(),
                    longitude: northEast.lng()},
                southWest: {
                    latitude: southWest.lat(),
                    longitude: southWest.lng()}},
                function(nearbyCouriers) {
                    showNearbyCouriers(nearbyCouriers);
                    callback();
                });
    }

    function showNearbyCouriers(couriers) {
        var courierData,
        nearbyCourierLocation,
        nearbyCourierLocations = [];

        nearbyCourierMarkers = [];
        for (var i = 0, max = couriers.length; i < max; i++) {
            courierData = couriers[i];
            nearbyCourierLocation = new g.LatLng(courierData.position.latitude, courierData.position.longitude);
            nearbyCourierMarkers.push(new g.Marker({
                map: map,
                position: nearbyCourierLocation,
                title: courierData.id,
                icon: "../images/icon-" + courierData.vehicle + ".png"}));
            nearbyCourierLocations.push(nearbyCourierLocation);
        }
        fitToLocations(nearbyCourierLocations);
    }

    function hideNearbyCouriers() {
        if (nearbyCourierMarkers) {
            for (var i = 0, max = nearbyCourierMarkers.length; i < max; i++) {
                nearbyCourierMarkers[i].setMap(null);
            }
            nearbyCourierMarkers = null;
        }
    }

    function toggleNearbyCouriers(callback) {
        if (nearbyCourierMarkers) {
            hideNearbyCouriers();
            callback(false);
        } else {
            getNearbyCouriers(function() {
                callback(true);
            });
        }
    }

    function showRoute(route) {
        if (route.equals(currentRoute)) {
            return;
        } else {
            hideRoute();
        }

        var travelMode,
        directionsService = new g.DirectionsService(),
        directionsRequest;
       
        directionsRenderer = new g.DirectionsRenderer();
        directionsRenderer.setMap(map);

        switch (courier.getTravelMode()) {
            case courier.BIKING:
                travelMode = g.DirectionsTravelMode.BICYCLING;
                break;
            case courier.DRIVING:
            default:
                travelMode = g.DirectionsTravelMode.DRIVING;
                break;
        }

        directionsRequest = {
            origin: currentLocationMarker.getPosition(),
            waypoints: [{location: new g.LatLng(route.getFrom().latitude, route.getFrom().longitude)}],
            optimizeWaypoints: true,
            destination: new g.LatLng(route.getTo().latitude, route.getTo().longitude),
            travelMode: travelMode,
            unitSystem: g.DirectionsUnitSystem.METRIC
        };

        directionsService.route(directionsRequest, function(directionsResult, status) {
            if (status == g.DirectionsStatus.OK) {
                directionsRenderer.setDirections(directionsResult);
                currentRoute = route;
            }
        });
    }

    function hideRoute() {
        if (directionsRenderer) {
            directionsRenderer.setMap(null);
            directionsRenderer = null;
            currentRoute = null;
        }
    }

    function fitToLocations(locations) {
        if (locations.length == 0) {
            return;
        }
        var bounds = new g.LatLngBounds();
        for (var i = 0, max = locations.length; i < max; i++) {
            bounds.extend(locations[i]);
        }
        map.fitBounds(bounds);
    }

    function fitToPositions(positions) {
        var locations = [];
        for (var i = 0, max = positions.length; i < max; i++) {
            if (positions[i]) {
                locations.push(new g.LatLng(positions[i].latitude, positions[i].longitude));
            }
        }
        fitToLocations(locations);
    }

    function showDefaultState() {
        hideRoute();
        hideNearbyCouriers();
        map.setZoom(mapOptions.zoom);
    }

    function fitBounds(bounds) {
      map.fitBounds(bounds);
    }

    return  { 
        fitBounds: fitBounds,
        init: init,
        setCourierLocation: setCourierLocation,
        showMyLocation: showMyLocation,
        toggleNearbyCouriers: toggleNearbyCouriers,
        hideNearbyCouriers: hideNearbyCouriers,
        showRoute: showRoute,
        fitToPositions: fitToPositions,
        showDefaultState: showDefaultState
    }
}(TIRAMIZOO, jQuery));

/**
 * Object to encapsulate from/to route information
 */
TIRAMIZOO.namespace("route");
TIRAMIZOO.route = function (newFrom, newTo) {
    var from = newFrom,
    to = newTo;

    function getFrom() {
        return from;
    }

    function getTo() {
        return to;
    }

    function equals(route) {
        if (!route) {
            return false;
        }
        return  route.getFrom().latitude == from.latitude &&
                route.getFrom().longitude == from.longitude &&
                route.getTo().latitude == to.latitude &&
                route.getTo().longitude == to.longitude;
    }

    return  {
        equals: equals,
        getFrom: getFrom,
        getTo: getTo
    }
};


/**
 * Object to hold the courier state
 */
TIRAMIZOO.namespace("model");
TIRAMIZOO.model = (function ($) {
    return {
        courier: {
            AVAILABLE: "available",
            NOT_AVAILABLE: "not_available"
        },
        radar: {}
    };
}(jQuery));

/**
 * Main function and initialization
 */
TIRAMIZOO.main = (function (app, $) {
    // var pubsub = app.pubsub;
    // 
    // function onDeliveryResponse(data) {
    //     console.log("onDeliveryResponse");
    //     console.dir(data);
    //     id = data['id'];
    //     status = data['status'];        
    //     updateCourierState(id, status);
    // }
    // 
    // $(function() {
    //     pubsub.subscribe({channel:"courier-delivery", action: "delivery_response", callback: onDeliveryResponse});
    // });

}(TIRAMIZOO, jQuery));