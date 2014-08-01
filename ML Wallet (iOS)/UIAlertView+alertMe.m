//
//  UIAlertView+alertMe.m
//  ML Wallet
//
//  Created by ml on 2/18/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "UIAlertView+alertMe.h"

@implementation UIAlertView (alertMe)

+ (UIAlertView *)myCostumeAlert :(NSString*)title alertMessage:(NSString*)message delegate:(id)del cancelButton:(NSString*)cancel otherButtons:(NSString*)otherbuttons
{
    UIAlertView *meAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:del cancelButtonTitle:cancel otherButtonTitles:otherbuttons, nil];
    [meAlert show];
 
    int64_t delayInSeconds = 60;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [meAlert dismissWithClickedButtonIndex:meAlert.cancelButtonIndex animated:YES];
    });
    
    return meAlert;
}

@end
