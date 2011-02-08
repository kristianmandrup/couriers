TIRAMIZOO.geocodeScreenConfigs.booking = {
  popId: "order_booking_pickup_address_street", 
  podId: "order_booking_dropoff_address_street",

  callbacks: {
    popGeocoded : function (geocoded_location) {    
       // create a marker positioned at a lat/lon
       // IMPORTANT: distinct marker icon here!
       var geocode_marker = new mxn.Marker(geocoded_location.point);
       popPoint = geocoded_location.point;

       updateMap(geocoded_location);
    },      
    podGeocoded : function (geocoded_location) {    
       // create a marker positioned at a lat/lon
       // IMPORTANT: distinct marker icon here!
       var geocode_marker = new mxn.Marker(geocoded_location.point);
       podPoint = geocoded_location.point;

       updateMap(geocoded_location, geocode_marker);    
    }      
  }
};

(function ($) {
  // configure geocoding for the booking page!
  app.geocodeFieldConfig($, app, app.geocodeScreenConfig.booking);
  
  booking_step = $('#tab-content-1.tab-content').find('%li#step_2');
  switch_tabs(booking_step);  
}(jQuery));