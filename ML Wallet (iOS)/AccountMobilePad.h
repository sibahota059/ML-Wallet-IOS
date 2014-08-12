//
//  AccountMobilePad.h
//  ML Wallet
//
//  Created by mm20-18 on 8/6/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>


@class AccountMobilePad;
@protocol AccountMobilePadDelegate <NSObject>

@required
-(void)didFinishLoadingRates:(NSString *)indicator andError:(NSString *)getError;

@end





@interface AccountMobilePad : NSObject

@property (weak, nonatomic) id<AccountMobilePadDelegate>delegate;
@property(weak, nonatomic) NSDictionary *getAccount;

-(void)loadAccount;

@end
