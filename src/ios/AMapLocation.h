#import <Cordova/CDVPlugin.h>



@interface AppInfo : CDVPlugin {}

- (void)getCurrentPosition:(CDVInvokedUrlCommand*)command;

- (void)watchPosition:(CDVInvokedUrlCommand*)command;

- (void)clearWatch:(CDVInvokedUrlCommand*)command;

@end