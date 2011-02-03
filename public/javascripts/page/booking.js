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

    function clickCourierItem() {
      number = $(this).find('td.number').text().trim();
      checkbox = $('form#new_order_booking').find('input[type=checkbox][value=' + number + ']');
      if (!checkbox.is(':checked')) {
        if (couriersSelected < maxCouriers) {
          couriersSelected += 1;
          checkbox.attr('checked', true);
          displaySelected(couriersSelected);
        } else {
          warnMaxSelected();
        }
      } 
      else {
        if (checkbox.is(':checked')) {
          if (couriersSelected > 0) {
            couriersSelected -= 1;
          }
          checkbox.attr('checked', false);
        }
        displaySelected(couriersSelected);
      }      
    }
    
    displaySelected(couriersSelected);

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

