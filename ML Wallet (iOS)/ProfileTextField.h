//
//  ProfileTextField.h
//  Account
//
//  Created by mm20-18 on 3/8/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTextField : UITextField <UITextFieldDelegate>

- (id)initWithFrame:(CGRect)frame word:(NSString *)word;


- (id)initWithFrame:(CGRect)frame word:(NSString *)word viewController:(id)viewController;

@end
