//
//  NSURLRequest+NSURLRequestSSLY.m
//  ML Wallet
//
//  Created by ml on 7/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "NSURLRequest+NSURLRequestSSLY.h"

@implementation NSURLRequest (NSURLRequestSSLY)
+(BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host
{
    return YES;
}

@end