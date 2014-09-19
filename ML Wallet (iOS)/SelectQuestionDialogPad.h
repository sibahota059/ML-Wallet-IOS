//
//  SelectQuestionDialogPad.h
//  ML Wallet
//
//  Created by mm20-18 on 8/5/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectQuestionDialogPad : UIView

@property (strong, nonatomic) UIButton *button;

@property (strong, nonatomic) UIButton *qButtonPad1;
@property (strong, nonatomic) UIButton *qButtonPad2;
@property (strong, nonatomic) UIButton *qButtonPad3;
@property (strong, nonatomic) UIButton *qButtonPad4;
@property (strong, nonatomic) UIButton *qButtonPad5;

- (id)initWithFrame:(CGRect)frame stringArray:(NSArray *)stringArray;

-(NSString *) getSelectedQuestion;

@end
