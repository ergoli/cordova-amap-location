#import <Cordova/CDVPlugin.h>
#import <AMapLocationKit/AMapLocationKit.h>


@interface AMapLocation : CDVPlugin {}

@property (retain, nonatomic) IBOutlet NSString *callback;

@property (nonatomic, strong) AMapLocationManager *locationManager;

- (void) initConfig;

- (void)getCurrentPosition:(CDVInvokedUrlCommand*)command;

- (void)watchPosition:(CDVInvokedUrlCommand*)command;

- (void)clearWatch:(CDVInvokedUrlCommand*)command;

@end