#import "AMapLocation.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>


@implementation AMapLocation

//init Config
-(void) initConfig{
    if(!self.locationManager){
        //set APIKey
        NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString* appKey = [infoDict objectForKey:@"AMapAppKey"];
        [AMapServices sharedServices].apiKey = appKey;
        
        //init locationManager
        self.locationManager = [[AMapLocationManager alloc]init];
        self.locationManager.delegate = self;
        //set DesiredAccuracy
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    }
}

- (void)getCurrentPosition:(CDVInvokedUrlCommand*)command
{
    [self initConfig];
    
    //   定位超时时间，最低2s，此处设置为5s
    self.locationManager.locationTimeout = 5;
    //   逆地理请求超时时间，最低2s，此处设置为5s
    self.locationManager.reGeocodeTimeout = 5;
    
    __weak AMapLocation *weakSelf = self;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error) {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            NSDictionary *addressInfo = @{@"code": [NSNumber numberWithInteger:error.code],
                                          @"message": error.localizedDescription};
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:addressInfo];
            [weakSelf.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDictionary *addressInfo = @{@"latitude": [NSNumber numberWithDouble:location.coordinate.latitude],
                                          @"longitude": [NSNumber numberWithDouble:location.coordinate.longitude],
                                          @"speed": [NSNumber numberWithDouble:location.speed],
                                          @"bearing": [NSNumber numberWithDouble:location.course],
                                          @"accuracy": [NSNumber numberWithDouble:location.horizontalAccuracy],
                                          @"date": [dateFormatter stringFromDate:location.timestamp],
                                          @"address": regeocode.formattedAddress ?: @"",
                                          @"country": regeocode.country ?: @"",
                                          @"province": regeocode.province ?: @"",
                                          @"city": regeocode.city ?: @"",
                                          @"cityCode": regeocode.citycode ?: @"",
                                          @"district": regeocode.district ?: @"",
                                          @"street": regeocode.street ?: @"",
                                          @"streetNum": regeocode.number ?: @"",
                                          @"adCode": regeocode.adcode ?: @"",
                                          @"poiName": regeocode.POIName ?: @"",
                                          @"aoiName": regeocode.AOIName ?: @""};
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:addressInfo];
            [weakSelf.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

- (void)watchPosition:(CDVInvokedUrlCommand*)command
{
    [self initConfig];
    self.callback = command.callbackId;
    [self.locationManager setLocatingWithReGeocode:YES];
    [self.locationManager startUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    CDVPluginResult* result = nil;
    if (reGeocode) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDictionary *addressInfo = @{@"latitude": [NSNumber numberWithDouble:location.coordinate.latitude],
                                      @"longitude": [NSNumber numberWithDouble:location.coordinate.longitude],
                                      @"speed": [NSNumber numberWithDouble:location.speed],
                                      @"bearing": [NSNumber numberWithDouble:location.course],
                                      @"accuracy": [NSNumber numberWithDouble:location.horizontalAccuracy],
                                      @"date": [dateFormatter stringFromDate:location.timestamp],
                                      @"address": reGeocode.formattedAddress ?: @"",
                                      @"country": reGeocode.country ?: @"",
                                      @"province": reGeocode.province ?: @"",
                                      @"city": reGeocode.city ?: @"",
                                      @"cityCode": reGeocode.citycode ?: @"",
                                      @"district": reGeocode.district ?: @"",
                                      @"street": reGeocode.street ?: @"",
                                      @"streetNum": reGeocode.number ?: @"",
                                      @"adCode": reGeocode.adcode ?: @"",
                                      @"poiName": reGeocode.POIName ?: @"",
                                      @"aoiName": reGeocode.AOIName ?: @""};
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:addressInfo];
        
    } else {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    if (result) {
        [result setKeepCallbackAsBool:YES];
        [[self commandDelegate] sendPluginResult:result callbackId: self.callback];
    }
}

- (void)clearWatch:(CDVInvokedUrlCommand*)command
{
    [self initConfig];
    [self.locationManager stopUpdatingLocation];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];
    [[self commandDelegate] sendPluginResult:result callbackId: command.callbackId];
}

@end