//
//  AppDelegate.h
//  ML Wallet (iOS)
//
//  Created by ml on 2/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class LoginViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) LoginViewController *viewController;
@property(nonatomic) BOOL isShowing;
@end
