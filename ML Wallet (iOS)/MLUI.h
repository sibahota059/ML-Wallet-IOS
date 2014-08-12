//
//  MLUI.h
//  SendMoney
//
//  Created by mm20 on 2/17/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MLSendMoneyViewController;
@class MLPreviewViewController;
@class MLTermsConditionViewController;
@class MLHistoryViewController;
@class MLRatesTableViewController;

@interface MLUI : NSObject

- (void)customTabBar:(UITabBarController *)tabController;
- (void)navigationAppearance;
- (void)navMessageAppearance;
- (UILabel *)navTitle:(NSString *)navtitle;
- (UIBarButtonItem *)navBarButton:(MLSendMoneyViewController *)controller navLink:(SEL)link imageNamed:(NSString *)imagename;
- (UIBarButtonItem *)navBarButtonPreview:(MLPreviewViewController *)controller navLink:(SEL)link imageNamed:(NSString *)imagename;
- (UIBarButtonItem *)navBarButtonTc:(MLTermsConditionViewController *)controller navLink:(SEL)link imageNamed:(NSString *)imagename;
- (UIBarButtonItem *)navBarButtonHistory:(MLHistoryViewController *)controller navLink:(SEL)link imageNamed:(NSString *)imagename;
- (UIBarButtonItem *)navBarButtonRates:(MLRatesTableViewController *)controller navLink:(SEL)link imageNamed:(NSString *)imagename;
- (void)displayAlert:(NSString *)title message:(NSString *)message;
- (NSString *)termsConditions;
- (UIView *)shadowView:(UIView*)viewContent;
@end
