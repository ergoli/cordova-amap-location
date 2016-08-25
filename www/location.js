var exec = cordova.require('cordova/exec');
module.exports = {
    getCurrentPosition: function(success, error, args) { 
    	console.log('getCurrentPosition');    
        exec(success, error, "Location", "getCurrentPosition", []);
    },

    watchPosition: function(success, error, args) {
        console.log('watchPosition');    
        exec(success, error, "Location", "watchPosition", []);
    },

    clearWatch: function(pluginWatchId) {
       console.log('clearWatch'); 
       exec(success, error, "Location", "clearWatch", [pluginWatchId]);
    }
};

