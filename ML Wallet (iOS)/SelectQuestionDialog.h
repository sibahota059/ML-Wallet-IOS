//
//  SelectQuestionDialog.h
//  Account
//
//  Created by mm20-18 on 3/10/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectQuestionDialog : UIView

@property (strong, nonatomic) UIButton *button;

- (id)initWithFrame:(CGRect)frame stringArray:(NSArray *)stringArray;

-(NSString *) getSelectedQuestion;

@end
