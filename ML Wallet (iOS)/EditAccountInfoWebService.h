//
//  EditAccountInfoWebService.h
//  ML Wallet
//
//  Created by mm20-18 on 8/14/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>



@class EditAccountInfoWebService;
@protocol EditAccountInfoDelegate <NSObject>

@required
-(void)didFinishEditingAccount:(NSString *)indicator andError:(NSString *)getError;

@end


@interface EditAccountInfoWebService : NSObject

@property (weak, nonatomic) id<EditAccountInfoDelegate>delegate;
@property (strong, nonatomic) NSString *respcode;
@property (strong, nonatomic) NSString *respmessage;

-(void)wallet:(NSString *)walletNo country:(NSString *)countryPar province:(NSString *)provincePar address:(NSString *)addressPar zipcode:(NSString *)zipcodePar gender:(NSString *)genderPar mnumber:(NSString *)mnumberPar work:(NSString *)workPar nationality:(NSString *)nationalityPar photo1:(NSString *)photo1Par photo2:(NSString *)photo2Par photo3:(NSString *)photo3Par photo4:(NSString *)photo4Par;
@end
