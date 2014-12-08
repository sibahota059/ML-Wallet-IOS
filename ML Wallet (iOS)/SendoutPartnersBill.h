//
//  SendoutPartnersBill.h
//  ML Wallet
//
//  Created by ml on 12/4/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SendoutPartnersBillDelegate <NSObject>

@required
-(void)didFinishLoadingBills:(NSString *)indicator andError:(NSString *)getError;

@end
@interface SendoutPartnersBill : NSObject
@property (weak, nonatomic) id<SendoutPartnersBillDelegate>delegate;
@property(weak, nonatomic) NSDictionary *getBillsPartners;

- (void)getUserWalletNo:(NSString *)walleno andPartnersId:(NSString *)partnersId andAccountNo:(NSString *) accountNo andAmount:(NSString *) amount;
@end
