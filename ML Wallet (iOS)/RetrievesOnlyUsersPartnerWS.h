//
//  RetrievesOnlyUsersPartnerWS.h
//  ML Wallet
//
//  Created by mm20-18 on 11/27/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>



@class RetrievesOnlyUsersPartnerWS;
@protocol RetrievesOnlyUsersDelegate <NSObject>

@required
-(void)didFinishRetrievingPartners:(NSString *)indicator andError:(NSString *)getError;

@end

@interface RetrievesOnlyUsersPartnerWS : NSObject

@property (weak, nonatomic) id<RetrievesOnlyUsersDelegate>delegate;
@property (strong, nonatomic) NSString *respcode;
@property (strong, nonatomic) NSString *respmessage;
@property(nonatomic, retain) NSDictionary *partners;

-(void)retrievePartners;

@end
