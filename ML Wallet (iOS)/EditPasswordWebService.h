//
//  EditPasswordWebService.h
//  ML Wallet
//
//  Created by mm20-18 on 8/13/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EditPasswordWebService;
@protocol EditPasswordDelegate <NSObject>

@required
-(void)didFinishEditingPassword:(NSString *)indicator andError:(NSString *)getError;

@end



@interface EditPasswordWebService : NSObject

@property (weak, nonatomic) id<EditPasswordDelegate>delegate;
@property (strong, nonatomic) NSString *respcode;
@property (strong, nonatomic) NSString *respmessage;

-(void)wallet:(NSString *)walletNo password:(NSString *)password_par;

@end
