TIRAMIZOO.geocodeScreenConfigs.quote = (function (app, $) {
  var map = app.map,
  popId = "order_quote_pickup_point",
  podId = "order_quote_dropoff_point",
  callbacks = {
    popGeocoded : function (geocoded_location) {
       // create a marker positioned at a lat/lon
       // IMPORTANT: distinct marker icon here!
       var geocode_marker = new map.g.Marker({
         map: map, 
         position: geocoded_location.point
       });
       popPoint = geocoded_location.point;
       updateMap(geocoded_location);
    },      
    podGeocoded : function (geocoded_location) {
       // create a marker positioned at a lat/lon
       // IMPORTANT: distinct marker icon here!
       var geocode_marker = new map.g.Marker({
         map: map, 
         position: geocoded_location.point
       });
       podPoint = geocoded_location.point;
       updateMap(geocoded_location, geocode_marker);
    }      
  };
}(TIRAMIZOO, jQuery));

(function ($) {
  quote_step = $('#tab-content-1.tab-content').find('%li#step_1');
  switch_tabs(quote_step);  
}(jQuery));


TIRAMIZOO.namespace("quote");
TIRAMIZOO.quote = (function (app, $) {
    // configure geocoding for the booking page!
    app.geocodeFieldConfig($, app, app.geocodeScreenConfigs.quote);
}(TIRAMIZOO, jQuery));


