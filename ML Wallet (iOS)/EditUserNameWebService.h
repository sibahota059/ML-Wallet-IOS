//
//  EditUserNameWebService.h
//  ML Wallet
//
//  Created by mm20-18 on 8/13/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>


@class EditUserNameWebService;
@protocol EditUserNameDelegate <NSObject>

@required
-(void)didFinishEditingUserName:(NSString *)indicator andError:(NSString *)getError;

@end




@interface EditUserNameWebService : NSObject

@property (weak, nonatomic) id<EditUserNameDelegate>delegate;
@property (strong, nonatomic) NSString *respcode;
@property (strong, nonatomic) NSString *respmessage;

-(void)wallet:(NSString *)walletNo username:(NSString *)username_par;

@end
