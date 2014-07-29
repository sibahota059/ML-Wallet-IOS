//
//  TempConnection.m
//  ML Wallet
//
//  Created by ml on 7/23/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "TempConnection.h"

#define SERVICE_HTTP @"https://"
#define SERVICE_URL @"192.168.12.204"
#define SERVICE_PORT @"4443"
#define SERVICE_PATH @"/Mobile/Client/mobileKP_WCF/service.svc/"
#define SERVICE_PDF @"/Mobile/Client/Mobilepdf/Mobilepdf.svc/";

@implementation TempConnection

- (NSString *)getHttp
{
    return SERVICE_HTTP;
}

- (NSString *)getUrl
{
    return SERVICE_URL;
}

- (NSString *)getPort
{
    return SERVICE_PORT;
}

- (NSString *)getPath
{
    return SERVICE_PATH;
}

- (NSString *)getPdfPath
{
    return SERVICE_PDF;
}

@end
