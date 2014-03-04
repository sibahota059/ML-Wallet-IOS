//
//  UIAlertView+alertMe.h
//  ML Wallet
//
//  Created by ml on 2/18/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (alertMe)

+ (UIAlertView *)myCostumeAlert :(NSString*)title alertMessage:(NSString*)message delegate:(id)del cancelButton:(NSString*)cancel otherButtons:(NSString*)otherbuttons;

@end
