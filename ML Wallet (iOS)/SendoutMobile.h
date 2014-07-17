//
//  SendoutMobile.h
//  ML Wallet
//
//  Created by mm20 on 7/14/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SendoutMobile;
@protocol SendoutMobileDelegate <NSObject>

@required
-(void)didFinishLoading;

@end

@interface SendoutMobile : NSObject

@property (weak, nonatomic) id<SendoutMobileDelegate>delegate;
@property (strong, nonatomic) NSString *senderFname;
@property (strong, nonatomic) NSString *senderMname;
@property (strong, nonatomic) NSString *senderLname;
@property (strong, nonatomic) NSString *receiverFname;
@property (strong, nonatomic) NSString *receiverMname;
@property (strong, nonatomic) NSString *receiverLname;
@property (strong, nonatomic) NSString *walletNo;
@property (strong, nonatomic) NSString *receiverNo;
@property (strong, nonatomic) NSString *principal;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *deviceId;
@property (strong, nonatomic) NSString *getKptn;

- (instancetype) initWithWalletNo:(NSString*)walletNo senderFname:(NSString*)senderFname senderMname:(NSString*)senderMname senderLname:(NSString*)senderLname receiverFname:(NSString*)receiverFname receiverMname:(NSString*)receiverMname receiverLname:(NSString*)receiverLname receiverNo:(NSString*)receiverNo principal:(NSString*)principal latitude:(NSString*)latitude longitude:(NSString*)longitude location:(NSString*)location deviceId:(NSString*)deviceId;



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
//-(void) loadContent;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
-(void)postDataToUrl;


@end
