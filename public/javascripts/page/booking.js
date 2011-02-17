// init Main map and Autocomplete map

jQuery(function(){
  // console.log('TIRAMIZOO.map', TIRAMIZOO.map);
  // console.log('TIRAMIZOO.mapAuto', TIRAMIZOO.mapAuto);

  // TIRAMIZOO.map.init();
});

// init courier selection table
jQuery(function(){

    function notification(msg) {
      $('.notification').text(msg);
    }

    $('tr.courier_item').click(clickCourierItem);    
    var form = $('form#new_order_booking');
    var checkboxes = form.find('input[type=checkbox]');
    console.log('checkboxes', checkboxes);

    checkboxes.each(function() {
      $(this).attr('checked', false);
    });    

    var maxCouriers = 3;    
    var couriersSelected = form.find('input[type=checkbox]:checked').length;

    classesSelected = [];

    function clickCourierItem() {
      elem      = $(this);
      number    = elem.find('td.number').text().trim();
      checkbox  = form.find('input[type=checkbox][value=' + number + ']');
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


