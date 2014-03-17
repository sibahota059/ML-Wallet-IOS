//
//  MLTermsConditionViewController.h
//  SendMoney
//
//  Created by mm20 on 2/26/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLTermsConditionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *tv_termsCondition;
@property (weak, nonatomic) IBOutlet UIView *view_tc;
@property (weak, nonatomic) IBOutlet UIView *view_success;
@property (weak, nonatomic) IBOutlet UIView *view_successOption;

- (IBAction)btnDecline:(id)sender;
- (IBAction)btnAgree:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDecline;
@property (weak, nonatomic) IBOutlet UIButton *btnAgree;
@property (weak, nonatomic) IBOutlet UIView *view_dialogHeader;
- (IBAction)btnClose:(id)sender;
- (IBAction)btnSms:(id)sender;
- (IBAction)btnEmail:(id)sender;

@property (strong, nonatomic) UITabBarController *tabBarController;
@end
