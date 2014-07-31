//
//  KpRates.h
//  ML Wallet
//
//  Created by mm20 on 7/16/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KpRates;
@protocol KpRatesDelegate <NSObject>

@required
-(void)didFinishLoadingRates:(NSString *)indicator andError:(NSString *)getError;

@end

@interface KpRates : NSObject
@property (weak, nonatomic) id<KpRatesDelegate>delegate;
@property(weak, nonatomic) NSDictionary *getRates;

-(void)loadRates;
@end
