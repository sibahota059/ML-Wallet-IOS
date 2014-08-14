//
//  PrintTransaction.h
//  ML Wallet
//
//  Created by ml on 7/29/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PrintTransactionDelegate <NSObject>

@required
-(void)didFinishLoadingTransaction:(NSString *)indicator andError:(NSString *)getError;

@end
@interface PrintTransaction : NSObject
@property (weak, nonatomic) id<PrintTransactionDelegate>delegate;
@property(weak, nonatomic) NSDictionary *getHistory;
@property(strong, nonatomic) NSString *respcode;
@property(strong, nonatomic) NSString *respmessage;

- (void)getUserWalletNo:(NSString *)walleno;
@end
