//
//  MLMenuViewController.h
//  SendMoney
//
//  Created by mm20 on 3/1/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLMenuViewController : UIViewController
@property (strong, nonatomic) UITabBarController *tabBarController;
- (IBAction)btnSendMoney:(id)sender;
- (IBAction)btnTransaction:(id)sender;

@end
