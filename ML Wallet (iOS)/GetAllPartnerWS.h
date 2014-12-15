//
//  GetAllPartnerWS.h
//  ML Wallet
//
//  Created by mm20-18 on 12/9/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GetAllPartnerWSDelegate <NSObject>

@required
-(void)didFinishLoadingPartners:(NSString *)indicator andError:(NSString *)getError;
@end

@interface GetAllPartnerWS : NSObject

@property (weak, nonatomic) id<GetAllPartnerWSDelegate>delegate;
@property(weak, nonatomic) NSDictionary *getPartners;
@property (strong, nonatomic) NSString *respcode;
@property (strong, nonatomic) NSString *respmessage;

-(void)loadPartners;

@end

