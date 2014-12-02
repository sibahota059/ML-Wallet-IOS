//
//  DeviceID.m
//  ML Wallet
//
//  Created by ml on 6/11/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "DeviceID.h"

@implementation DeviceID

- (NSString *)NSGetDeviceID
{
//    CFUUIDRef theUUID = CFUUIDCreate(NULL);
//    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
//    CFRelease(theUUID);
//    return (__bridge NSString *)string;
    
    UIDevice *deviceId = [UIDevice currentDevice];
    return [[deviceId identifierForVendor] UUIDString];
}

@end
