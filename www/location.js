var exec = cordova.require('cordova/exec');


module.exports = {
    getCurrentPosition: function(success, error, args) {     
        exec(success, error, "Location", "getCurrentPosition", []);
    },

    watchPosition: function(success, error, args) {
        
    },

    clearWatch: function(pluginWatchId) {
      
    }
};

