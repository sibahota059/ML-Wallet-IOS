//
//  UIAlertView+WaitAlertView.m
//  ML Wallet
//
//  Created by ml on 6/23/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "UIAlertView+WaitAlertView.h"

@implementation UIAlertView (WaitAlertView)

+ (void)initWaitAlertViewTitle:(NSString *)title Message:(NSString*)mesasge
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Configuring Preferences\nPlease Wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);
    [indicator startAnimating];
    [alert addSubview:indicator];
}

@end
