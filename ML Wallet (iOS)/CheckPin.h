//
//  GetReceiver.h
//  ML Wallet
//
//  Created by mm20 on 7/16/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CheckPin;
@protocol CheckPinDelegate <NSObject>

@required
-(void)didFinishLoadingPin:(NSString *)indicator andError:(NSString *)getError;

@end
@interface CheckPin : NSObject
@property (weak, nonatomic) id<CheckPinDelegate>delegate;
@property(weak, nonatomic) NSDictionary *getPin;

- (void)getReceiverWalletNo:(NSString *)walleno andReceiverPinNo:(NSString *)pin;
@end