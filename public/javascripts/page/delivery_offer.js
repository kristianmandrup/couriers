(function ($) {
    function updateCourierState(id, status) {      
      $('#courier_' + id + ' td.status').text(status);
    },
    return {
        updateCourierState: updateCourierState
    };
}(jQuery));

