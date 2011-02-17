$().ready(function() {
  var inputElem = $('#customer_order_booking_pickup_attributes_street');  
  console.log('add autocomplete', inputElem)
  inputElem.geo_autocomplete();  
});