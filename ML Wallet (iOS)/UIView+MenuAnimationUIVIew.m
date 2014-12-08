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

+ (void)popView:(UIView *)viewToPop
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    NSValue *scale1Value = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5f, 0.5f, 1.0f)];
    NSValue *scale2Value = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2f, 1.2f, 1.0f)];
    NSValue *scale3Value = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)];
    NSValue *scale4Value = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)];
    NSArray *frameValues = [NSArray arrayWithObjects:scale1Value, scale2Value, scale3Value, scale4Value, nil];
    [animation setValues:frameValues];
    
    NSNumber *time1 = [NSNumber numberWithFloat:0.0f];
    NSNumber *time2 = [NSNumber numberWithFloat:0.7f];
    NSNumber *time3 = [NSNumber numberWithFloat:1.0f];
    NSNumber *time4 = [NSNumber numberWithFloat:1.2f];
    NSArray *frameTimes = [NSArray arrayWithObjects:time1, time2, time3, time4, nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 0.2f;
    
    [viewToPop.layer addAnimation:animation forKey:@"popup"];
}

@end
