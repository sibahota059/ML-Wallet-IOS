//
//  ServiceConnection.m
//  ML Wallet
//
//  Created by ml on 6/19/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "ServiceConnection.h"

#define URLService @"https://192.168.12.204:4443/mobile/client/mobilekp_wcf/service.svc/"
#define URLMapService @"https://192.168.12.204:4443/Mobile/Client/MapService/MapService.svc/getCoordinates/";
#define URLLocationService @"Http://maps.google.com/maps/api/geocode/json?";

@implementation ServiceConnection

- (NSString *) NSgetURLService
{
    return URLService;
}

- (NSString *) NSgetLocationService
{
    return URLLocationService;
}

- (NSString *) NSGetMapService
{
    return URLMapService;
}

@end
