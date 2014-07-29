//
//  TimerUIApplication.h
//  ML Wallet
//
//  Created by ml on 7/28/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kApplicationTimeoutInMinutes 5

#define kApplicationDidTimeoutNotification @"AppTimeOut"

@interface TimerUIApplication : UIApplication
{
    NSTimer *myidleTimer;
}
- (void) resetIdleTimer;
@end
