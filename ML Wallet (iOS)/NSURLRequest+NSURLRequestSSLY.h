//
//  NSURLRequest+NSURLRequestSSLY.h
//  ML Wallet
//
//  Created by ml on 7/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (NSURLRequestSSLY)
+(BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;

@end