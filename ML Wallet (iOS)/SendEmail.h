//
//  SendEmail.h
//  ML Wallet
//
//  Created by ml on 7/23/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SendKptnDelegate <NSObject>

@required
-(void)didFinishLoadingEmail:(NSString *)indicator andError:(NSString *)getError;

@end

@interface SendEmail : NSObject
@property (weak, nonatomic) id<SendKptnDelegate>delegate;
@property (strong, nonatomic) NSString *respcode;
@property (strong, nonatomic) NSString *respmessage;

-(void)sendEmail:(NSString *)walletNo andKptn:(NSString *)kptn;
@end
