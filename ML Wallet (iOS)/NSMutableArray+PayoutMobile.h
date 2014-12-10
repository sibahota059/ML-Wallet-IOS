//
//  NSMutableArray+PayoutMobile.h
//  ML Wallet
//
//  Created by ml on 12/10/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableData (PayoutMobile)
/*
 NSString* kptnNo = self.txtInsuffi_kptn.text;
 NSString* wallet = walletno;
 NSString* princpal = principal;
 NSString* cusID = custid;
 double lng = [self Longtitude];
 double lat = [self Latitude];
 NSString *deviceID = [[DeviceID alloc] NSGetDeviceID];
 NSString* location = [self location];
 */
-(NSMutableData*) mobilePayout_kptn:(NSString*)kptn
                           WalletNo:(NSString*)walletno
                          Principal:(NSString*)principal
                             CustID:(NSString*)custID
                                lng:(double)lng
                                lat:(double)lat
                           DeviceID:(NSString*)deviceID
                           Location:(NSString*)location
                           Delegate:(id)delegate;

@end
