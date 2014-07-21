//
//  UITextfieldAnimate.m
//  ML Wallet
//
//  Created by ml on 7/21/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "UITextfieldAnimate.h"

@implementation UITextfieldAnimate

- (void) animateTextField: (UITextField*) textField up: (BOOL)up SelfView: (UIView*)view
{
    const int movementDistance      = 80;
    const float movementDuration    = 0.3f;
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    view.frame = CGRectOffset(view.frame, 0, movement);
    [UIView commitAnimations];
}


@end
