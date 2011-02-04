jQuery(function ($) {

    $('tr.courier_item').click(clickCourierItem);    

    $('form#new_order_booking input[type=checkbox]').each(function() {
      $(this).attr('checked', false);
    });    

    // html body.bp div#container-top div#maincontent div#booking_form.left form#new_order_booking.formtastic li#order_booking_couriers_input.check_boxes

    $('form#new_order_booking #order_booking_couriers_input').each(function() {
      $(this).hide();
    });    

    var maxCouriers = 3;    
    var couriersSelected = $('form#new_order_booking input[type=checkbox]:checked').length;

    classesSelected = [];

    function clickCourierItem() {
      elem = $(this);
      number = elem.find('td.number').text().trim();
      checkbox = $('form#new_order_booking').find('input[type=checkbox][value=' + number + ']');
      if (!checkbox.is(':checked')) {
        if (couriersSelected < maxCouriers) {          
          couriersSelected += 1; 
          clsName = firstClassNotSelected(classesSelected);
          classesSelected.push(clsName);
          elem.addClass(clsName);          
          checkbox.attr('checked', true);
          displaySelected(couriersSelected);
        } else {
          warnMaxSelected();
        }
      } 
      else {
        if (checkbox.is(':checked')) {
          if (couriersSelected > 0) {
            clsName = whichClass(elem);
            removeSelectedClass(clsName)
            elem.removeClass(clsName);
            couriersSelected -= 1;
          }
          checkbox.attr('checked', false);
        }
        displaySelected(couriersSelected);
      }      
    }
    
    displaySelected(couriersSelected);

    function firstClassNotSelected(list) {
      found = [1, 2, 3].filter(function(elem, i) {
        return list.indexOf("selected_" + elem) < 0;
      });
      return "selected_" + found[0];
    }

    function removeSelectedClass(clsName) {
      $.each([1, 2, 3], function(i, val) {
        if (classesSelected[i] == clsName) {
          classesSelected.splice(i, 1);
        }
      });
    }

    function whichClass(obj) {
      found = [1, 2, 3].filter(function(elem, i) {
        return obj.hasClass("selected_" + elem);
      });
      return "selected_" + found[0];
    }

    function warnMaxSelected() {
      $('#couriers_msg .warning').text('You can only select up to ' + maxCouriers + ' couriers ');      
    }
    
    function displaySelected(number) {
      $('#couriers_msg .warning').text('');      
      $('#couriers_msg .notify').text('You have selected '+ couriers(number));
    }
    
    function couriers(n) {
      if (n == 1) {
        return '1 courier';
      } else {
        return n + ' couriers';        
      }
    }
});



// $().ready(function() {
//  $('#order_booking_pickup_address_street').geo_autocomplete({
//    mapkey: 'ABQIAAAAUzkItq4p7LYo2YIR_gtjpRTJQa0g3IQ9GZqIMmInSLzwtGDKaBSzEc8_FNxIfQLkpKOh9R4JB87Rig',
//    geocoder_region: 'Munich',
//    geocoder_types: 'street_address',
//    selectFirst: false,
//    minChars: 3,
//    cacheLength: 30,
//    width: 300,
//    scroll: true,
//    scrollHeight: 200,
//    select: function(_event, _ui) {
//      console.log('event', event);
//      if (_ui.item.viewport) 
//       TIRAMIZOO.mapAuto.fitBounds(_ui.item.viewport);
//    }
//  });
//  
//  $('#order_booking_dropoff_address_street').geo_autocomplete({
//  mapkey: 'ABQIAAAAUzkItq4p7LYo2YIR_gtjpRTJQa0g3IQ9GZqIMmInSLzwtGDKaBSzEc8_FNxIfQLkpKOh9R4JB87Rig',
//  geocoder_region: 'Munich',
//  geocoder_types: 'street_address',
//  selectFirst: false,
//  minChars: 3,
//  cacheLength: 30,
//  width: 300,
//  scroll: true,
//  scrollHeight: 200,
//  select: function(_event, _ui) {
//  console.log('event', event);
//  if (_ui.item.viewport) TIRAMIZOO.mapAuto.fitBounds(_ui.item.viewport);
//  }
//  });}
//  });