//
//  QuestionVerificationDialogPad.h
//  ML Wallet
//
//  Created by mm20-18 on 8/4/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionVerificationDialogPad : UIView <UITextFieldDelegate>


@property (strong, nonatomic)UIButton *updateButton;
@property (strong, nonatomic)UIView *dialog;

@property (strong, nonatomic)NSString *question1;
@property (strong, nonatomic)NSString *question2;
@property (strong, nonatomic)NSString *question3;
@property (strong, nonatomic)NSString *finalQuestion;
@property (strong, nonatomic)NSString *finalAnswer;

@property (strong, nonatomic)UITextField *answer;



- (id)initWithFrame:(CGRect)frame addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents)events;


- (id)initWithFrame:(CGRect)frame addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents) events addQuestion1:(NSString *)question1_par addQuestion2:(NSString *)question2_par addQuestion3:(NSString *)question3_par;

@end
