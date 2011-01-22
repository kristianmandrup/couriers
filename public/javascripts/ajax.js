
/**
 * Ajax helpers
 */
TIRAMIZOO.namespace("ajax");
TIRAMIZOO.ajax = (function ($) {
    function getJSON(options) {
        var paramsStr = "";
        if (options.params) {
            paramsStr = "?" + $.param(options.params);
        }
        $.ajax({
            type: "GET",
            url: "/" + options.action + ".json" + paramsStr,
            dataType: "json",
            contentType: "application/json",
            processData: false,
            success: function(data) {
                options.callback(data)
            }
        });
        //$.getJSON("/" + options.action + ".json" + paramsStr, options.callback);
    }

    function postJSON(options) {
        $.ajax({
            type: "POST",
            url: "/" + options.action + ".json",
            dataType: "json",
            contentType: "application/json",
            processData: false,
            data: JSON.stringify(options.params),
            success: function(data) {
                options.callback(data)
            }
        });
        //$.post("/" + options.action + ".json", JSON.stringify(options.params), options.callback);
    }

    return {
        getJSON: getJSON,
        postJSON :postJSON
    };
}(jQuery));
