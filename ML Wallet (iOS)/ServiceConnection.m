//
//  ServiceConnection.m
//  ML Wallet
//
//  Created by ml on 6/19/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "ServiceConnection.h"

//-- Local
#define URLHttps_IP @"https://192.168.12.204:4443"

#define URLService @"/mobile/client/mobilekp_wcf/service.svc/"
#define URLMobilePdf @"/Mobile/Client/Mobilepdf/Mobilepdf.svc/"
#define URLMapService @"/mobile/Client/MapService/MapService.svc/getCoordinates/"


//- Production
/*
#define URLHttps_IP @"https://mlmobileweb.mlhuillier1.com"
 
#define URLService @"/mobile/client/1.3/mobilekp_wcf/service.svc/"
#define URLMobilePdf @"/Mobile/Client/1.3/Mobilepdf/Mobilepdf.svc/"
#define URLMapService @"/mobile/Client/1.2/MapService/MapService.svc/getCoordinates/"
*/

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
