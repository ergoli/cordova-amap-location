#import "AMapLocation.h"
#import <AMapFoundationKit.h>
#import <AMapLocationKit.h>


@implementation AMapLocation

- (void)getCurrentPosition:(CDVInvokedUrlCommand*)command
{   
    [AMapLocationServices sharedServices].apiKey =@"您的key";

    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =10;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 10 ;

    __weak AMapLocation *weakSelf = self;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        NSLog(@"location:%@", location);
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
             
            NSDictionary *addressInfo = @{@"code":  (long)error.code,
                                          @"message": error.localizedDescription};

            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:addressInfo];
            [weakSelf.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];      
        }else{
            NSDictionary *addressInfo = @{@"latitude": location.coordinate.latitude,
                                          @"longitude": location.coordinate.longitude,
                                          @"address": regeocode.formattedAddress};
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:addressInfo];
            [weakSelf.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];                  
        }
         
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];

    // NSDictionary *appInfoDict = NSBundle.mainBundle.infoDictionary;

    // NSString *identifier = appInfoDict[@"CFBundleIdentifier"];
    // NSString *version = appInfoDict[@"CFBundleShortVersionString"];
    // NSString *build = appInfoDict[@"CFBundleVersion"];

    // NSDictionary *appInfo = @{@"identifier": identifier,
    //                           @"version": version,
    //                           @"build": build};

    // CDVPluginResult* pluginResult = nil;
    // pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:appInfo];
    // [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)watchPosition:(CDVInvokedUrlCommand*)command
{
    // NSString* versionName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

    // CDVPluginResult* pluginResult = nil;
    // pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:versionName];
    // [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void)clearWatch:(CDVInvokedUrlCommand*)command
{
    // NSString* build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];

    // CDVPluginResult* pluginResult = nil;
    // pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:build];
    // [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end