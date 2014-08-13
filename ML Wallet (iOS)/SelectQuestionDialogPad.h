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
@property (strong, nonatomic) NSArray *questions;

- (id)initWithFrame:(CGRect)frame stringArray:(NSArray *)stringArray;

-(NSString *) getSelectedQuestion;

@end
