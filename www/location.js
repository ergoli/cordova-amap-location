var exec = cordova.require('cordova/exec');
module.exports = {
    getCurrentPosition: function(success, error, args) { 
    	console.log('getCurrentPosition');    
        exec(success, error, "AMapLocation", "getCurrentPosition", []);
    },

    watchPosition: function(success, error, args) {
        console.log('watchPosition');    
        exec(success, error, "AMapLocation", "watchPosition", []);
    },

    clearWatch: function(pluginWatchId) {
       console.log('clearWatch'); 
       exec(success, error, "AMapLocation", "clearWatch", [pluginWatchId]);
    }
};

