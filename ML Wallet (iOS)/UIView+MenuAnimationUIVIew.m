//
//  UIView+MenuAnimationUIVIew.m
//  ML Wallet
//
//  Created by ml on 2/19/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "UIView+MenuAnimationUIVIew.h"

@implementation UIView (MenuAnimationUIVIew)

#pragma Start #POP-UP Animation
+(void) AnimationPopUp: (UIView *)popUp{
    popUp.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView animateWithDuration:0.3/1.5 animations:^{
        popUp.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3/2 animations:^{
                             popUp.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
                         }completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.3/2 animations:^{
                                 popUp.transform = CGAffineTransformIdentity;
                             }];
                         }];
                     }];
}


@end
