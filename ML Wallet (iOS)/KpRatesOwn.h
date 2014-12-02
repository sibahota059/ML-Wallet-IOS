//
//  KpRatesOwn.h
//  ML Wallet
//
//  Created by ml on 11/27/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KpRatesDelegateOwn <NSObject>

@required
-(void)didFinishLoadingRatesOwn:(NSString *)indicator andError:(NSString *)getError;

@end



@interface KpRatesOwn : NSObject
@property (weak, nonatomic) id<KpRatesDelegateOwn>delegate;
@property(weak, nonatomic) NSDictionary *getRates;

-(void)loadRates:(NSString *)parameterMethods;
@end
