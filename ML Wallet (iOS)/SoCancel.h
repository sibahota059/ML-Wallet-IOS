//
//  SoCancel.h
//  ML Wallet
//
//  Created by ml on 7/29/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SoCancel;
@protocol SoCancelDelegate <NSObject>

@required
-(void)didFinishLoadingCancellation:(NSString *)indicator andError:(NSString *)getError;

@end

@interface SoCancel : NSObject
@property (weak, nonatomic) id<SoCancelDelegate>delegate;
@property (strong, nonatomic) NSString *respcode;
@property (strong, nonatomic) NSString *respmessage;

-(void)soCancel:(NSString *)walletNo andKptn:(NSString *)kptn andLatitude:(NSString *)lat andLongitude:(NSString *)lon andDeviceId:(NSString *)deviceId andLocation:(NSString *)location;
@end
