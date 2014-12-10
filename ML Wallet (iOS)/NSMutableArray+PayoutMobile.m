//
//  NSMutableArray+PayoutMobile.m
//  ML Wallet
//
//  Created by ml on 12/10/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "NSMutableArray+PayoutMobile.h"
#import "ServiceConnection.h"
#import "CryptLib.h"
#import "NSData+Base64.h"

@implementation NSMutableData (PayoutMobile)

-(NSMutableData*) mobilePayout_kptn:(NSString*)kptn
                           WalletNo:(NSString*)walletno
                          Principal:(NSString*)principal
                             CustID:(NSString*)custID
                                lng:(double)lng
                                lat:(double)lat
                           DeviceID:(NSString*)deviceID
                           Location:(NSString*)location
                           Delegate:(id)delegate
{
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"payoutMobile"];
    NSString *encrptedString = [NSString stringWithFormat:@"{\"kptn\" : \"%@\",\"walletno\" : \"%@\",\"principal\" : \"%@\",\"custid\" : \"%@\",\"latitude\" : \"%f\",\"longtitude\" : \"%f\",\"deviceid\" : \"%@\",\"location\" : \"%@\"}",
                                kptn,
                                walletno,
                                principal,
                                custID,
                                lng,
                                lat,
                                deviceID,
                                location];
    
    //enc
    NSString* _key = [[ServiceConnection alloc] NSGetKey];
    NSString* _iv = [[StringEncryption alloc] generateIV];
    NSData* encryptedData = [[StringEncryption alloc] encrypt:[encrptedString dataUsingEncoding:NSUTF8StringEncoding]
                                                          key:_key
                                                           iv:_iv];
    NSLog(@"Encrypted Data : %@", [encryptedData base64EncodingWithLineLength:0]);
    
    encrptedString = [NSString stringWithFormat:@"{\"encrypted\" : \"%@\",\"iv\" : \"%@\"}",
                      [encryptedData base64EncodingWithLineLength:0],
                      _iv];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    NSData *requestData = [NSData dataWithBytes:[encrptedString UTF8String] length:[encrptedString length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:request delegate:delegate];
    
    return nil;
}

@end
