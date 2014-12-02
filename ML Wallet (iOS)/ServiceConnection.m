//
//  ServiceConnection.m
//  ML Wallet
//
//  Created by ml on 6/19/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "ServiceConnection.h"
#import "CryptLib.h"

#define _key @"mlhuillier_philippines"

#define URLHttps_IP @"https://192.168.12.204:4443"


#define URLService @"/Mobile/Client/AES_IOS_ANDROID/mobileKP_WCF/Service.svc/" ///mobile/client/test/mobilekp_wcf/service.svc/
#define URLMapService @"/mobile/Client/MapService/MapService.svc/getCoordinates/"
//MAP Service
#define URLLocationService @"Http://maps.google.com/maps/api/geocode/json?"

//Albert Added MobilePdf
#define URLMobilePdf @"/Mobile/Client/Mobilepdf/Mobilepdf.svc/"

#define URLCreateAccountService @"insertMobileAccounts"
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

-(NSString *) NSGetCustomerIDService{
    return [NSString stringWithFormat:@"%@%@",URLHttps_IP,URLService];
}
-(NSString *) NSCreateAccountService{
    return [NSString stringWithFormat:@"%@%@",URLHttps_IP,URLService];
}

- (NSString *) NSGetKey
{    
    return [[StringEncryption alloc] sha256:_key length:32];;
}

@end
