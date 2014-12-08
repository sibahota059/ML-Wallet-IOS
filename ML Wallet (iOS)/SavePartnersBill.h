//
//  SavePartnersBill.h
//  ML Wallet
//
//  Created by ml on 12/6/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SavePartnersDelegate <NSObject>

@required
-(void)didFinishLoadingPartnersSendout:(NSString *)indicator andError:(NSString *)getError;

@end
@interface SavePartnersBill : NSObject
@property (weak, nonatomic) id<SavePartnersDelegate>delegate;
@property(weak, nonatomic) NSDictionary *partnersSendout;

- (void)getReceiverWalletNo:(NSString *)walleno andOperatorId:(NSString *)operatorId andBarcode:(NSString *)bcode andZoneCode:(NSString *)zcode andKptn:(NSString *)kptn andPartnersId:(NSString *)partnersId andAccountNo:(NSString *)accountNo andAmountPaid:(NSString *)amount andCustomerCharge:(NSString *)customerCharge andPartnersCharge:(NSString *)partnersCharge andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude andDeviceId:(NSString *)deviceId andLocation:(NSString *)location;
@end
