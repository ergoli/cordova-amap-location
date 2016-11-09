var AMapLocationPlugin = function () {
};

AMapLocationPlugin.prototype.call_native = function (name, args, success ,error) {
    cordova.exec(success, error, 'AMapLocation', name, args);
};

AMapLocationPlugin.prototype.getCurrentPosition = function (success ,error) {
    this.call_native("getCurrentPosition", [], success ,error);
};

AMapLocationPlugin.prototype.watchPosition = function (success ,error, interval) {
    this.call_native("watchPosition", [interval], success ,error);
};

AMapLocationPlugin.prototype.clearWatch = function (success ,error) {
    this.call_native("clearWatch", [], success ,error);
};

if (!window.plugins) {
    window.plugins = {};
}

if (!window.plugins.aMapLocationPlugin) {
    window.plugins.aMapLocationPlugin = new AMapLocationPlugin();
}

module.exports = new AMapLocationPlugin();