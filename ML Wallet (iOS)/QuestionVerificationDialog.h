//
//  QuestionVerificationDialog.h
//  Account
//
//  Created by mm20-18 on 3/7/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionVerificationDialog : UIView <UITextFieldDelegate>

@property (strong, nonatomic)UIButton *updateButton;
@property (strong, nonatomic)UIView *dialog;

- (id)initWithFrame:(CGRect)frame addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents)events;





@end
