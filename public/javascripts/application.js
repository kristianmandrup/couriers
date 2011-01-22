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
 * Object to encapsulate publish/subscribe behaviour
 */
TIRAMIZOO.namespace("pubsub");
TIRAMIZOO.pubsub = (function (pubSubService) {
    function publish(options) {
        pubSubService.publish({
            channel: options.channel,
            message: JSON.stringify({action:options.action, data:options.data}),
            callback: options.callback || onPublished})
    }

    function onPublished(info) {
        console.log(info);
    }

    function subscribe(options) {
        pubSubService.subscribe({
            channel: options.channel,
            callback: function(message) {
                console.log("pubSubService message: " + message);
                console.dir(message);
                if (message.action == options.action) {
                    options.callback(message.data);
                }
            },
            error:options.error || onError});
    }

    function onError(e) {
        console.log(e);
        // info[0] == 1 for success
        // info[0] == 0 for failure

        // info[1] == "D" for "Demo Success" or
        // info[1] == "S" for "Success with Valid Key" or
        // info[1] == "Error..." with reason of failure.

        // if the response is an error, do not re-publish.
        // the failed publish will not re-send.
    }

    return  {
        publish: publish,
        subscribe: subscribe
    }
}(PUBNUB));

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
    var pubsub = app.pubsub;

    function onNewDelivery(data) {
        console.log("onNewDelivery");
        console.dir(data);
        $.jGrowl("New Delivery: " + data.directions + "<br/>" + data.pickup.location.address.street,
            {sticky: true});
        $(this).trigger("newDelivery");
    }

    function mobileInit() {
        //config $.mobile
    }

    $(function() {
        pubsub.subscribe({channel:"tiramizoo-courier-delivery", action:"new_delivery", callback:onNewDelivery});
        $.jGrowl("Tiramizoo 4 teh win!", {sticky:true});
    });

    //RestClient.put('http://tiramizoo-api.heroku.com/bookings/1', :data => 'hello')

    $(document).bind("mobileinit", mobileInit);

}(TIRAMIZOO, jQuery));       

/**
 * Object to encapsulate publish/subscribe behaviour
 */
TIRAMIZOO.namespace("pubsub");
TIRAMIZOO.pubsub = (function (pubSubService) {
    function publish(options) {
        pubSubService.publish({
            channel: options.channel,
            message: JSON.stringify({action:options.action, data:options.data}),
            callback: options.callback || onPublished})
    }

    function onPublished(info) {
        console.log(info);
    }

    function subscribe(options) {
        pubSubService.subscribe({
            channel: options.channel,
            callback: function(message) {
                console.log("pubSubService message: " + message);
                console.dir(message);
                if (message.action == options.action) {
                    options.callback(message.data);
                }
            },
            error:options.error || onError});
    }

    function onError(e) {
        console.log(e);
        // info[0] == 1 for success
        // info[0] == 0 for failure

        // info[1] == "D" for "Demo Success" or
        // info[1] == "S" for "Success with Valid Key" or
        // info[1] == "Error..." with reason of failure.

        // if the response is an error, do not re-publish.
        // the failed publish will not re-send.
    }

    return  {
        publish: publish,
        subscribe: subscribe
    }
}(PUBNUB));

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
    var pubsub = app.pubsub;

    function onDeliveryResponse(data) {
        console.log("onDeliveryResponse");
        console.dir(data);
        id = data['id'];
        status = data['status'];        
        updateCourierState(id, status);
    }

    $(function() {
        pubsub.subscribe({channel:"courier-delivery", action: "delivery_response", callback: onDeliveryResponse});
    });

}(TIRAMIZOO, jQuery));