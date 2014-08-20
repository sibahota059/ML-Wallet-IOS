//
//  EditEmailWebService.h
//  ML Wallet
//
//  Created by mm20-18 on 8/13/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EditEmailWebService;
@protocol EditEmailDelegate <NSObject>

@required
-(void)didFinishEditingEmail:(NSString *)indicator andError:(NSString *)getError;

@end

@interface EditEmailWebService : NSObject

@property (weak, nonatomic) id<EditEmailDelegate>delegate;
@property (strong, nonatomic) NSString *respcode;
@property (strong, nonatomic) NSString *respmessage;

-(void)wallet:(NSString *)walletNo theEmail:(NSString *)email;
@end
