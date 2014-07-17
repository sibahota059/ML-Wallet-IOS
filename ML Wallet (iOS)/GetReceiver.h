//
//  GetReceiver.h
//  ML Wallet
//
//  Created by mm20 on 7/16/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GetReceiver;
@protocol GetReceiverDelegate <NSObject>

@required
-(void)didFinishLoadingReceiver;

@end
@interface GetReceiver : NSObject
@property (weak, nonatomic) id<GetReceiverDelegate>delegate;
@property(weak, nonatomic) NSDictionary *getReceiver;

- (void)getReceiverWalletNo:(NSString *)walleno;
@end
