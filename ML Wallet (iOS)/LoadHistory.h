//
//  GetReceiver.h
//  ML Wallet
//
//  Created by mm20 on 7/26/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoadHistory;
@protocol LoadHistoryDelegate <NSObject>

@required
-(void)didFinishLoadingHistory:(NSString *)indicator;

@end
@interface LoadHistory : NSObject
@property (weak, nonatomic) id<LoadHistoryDelegate>delegate;
@property(weak, nonatomic) NSDictionary *getHistory;

- (void)getUserWalletNo:(NSString *)walleno;
@end
