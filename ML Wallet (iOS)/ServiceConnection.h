//
//  ServiceConnection.h
//  ML Wallet
//
//  Created by ml on 6/19/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceConnection : NSObject

- (NSString *)NSgetURLService;
- (NSString *) NSgetLocationService;
- (NSString *) NSGetMapService;
//Albert Added
- (NSString *) NSGetMobilePdf;

-(NSString *) NSGetCustomerIDService;
-(NSString *) NSCreateAccountService;
@end
