//
//  ServiceConnection.m
//  ML Wallet
//
//  Created by ml on 6/19/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "ServiceConnection.h"

#define URLHttps_IP @"https://192.168.12.204:4443"


#define URLService @"/mobile/client/mobilekp_wcf/service.svc/"
#define URLMapService @"/mobile/Client/MapService/MapService.svc/getCoordinates/"

//MAP Service
#define URLLocationService @"Http://maps.google.com/maps/api/geocode/json?"

//Albert Added MobilePdf
#define URLMobilePdf @"/Mobile/Client/Mobilepdf/Mobilepdf.svc/"

@implementation ServiceConnection

#pragma mark - Return URL Service
- (NSString *) NSgetURLService
{
    return [NSString stringWithFormat:@"%@%@", URLHttps_IP, URLService];
}

- (NSString *) NSGetMapService
{
    return [NSString stringWithFormat:@"%@%@", URLHttps_IP, URLMapService];
}

- (NSString *) NSgetLocationService
{
    return URLLocationService;
}

//Albert Added
- (NSString *) NSGetMobilePdf
{
    return [NSString stringWithFormat:@"%@%@", URLHttps_IP, URLMobilePdf];
}

@end
