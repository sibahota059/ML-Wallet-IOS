//
//  EditSecretQuestionsWebService.h
//  ML Wallet
//
//  Created by mm20-18 on 8/14/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>



@class EditSecretQuestionsWebService;
@protocol EditSecretQuestionsDelegate <NSObject>

@required
-(void)didFinishEditingQuestions:(NSString *)indicator andError:(NSString *)getError;

@end




@interface EditSecretQuestionsWebService : NSObject
@property (weak, nonatomic) id<EditSecretQuestionsDelegate>delegate;
@property (strong, nonatomic) NSString *respcode;
@property (strong, nonatomic) NSString *respmessage;

-(void)wallet:(NSString *)walletNo secQuestion1:(NSString *)question1 secQuestion2:(NSString *)question2 secQuestion3:(NSString *)question3 secAns1:(NSString *)answer1 secAns2:(NSString *)answer2 secAns3:(NSString *)answer3;
@end
