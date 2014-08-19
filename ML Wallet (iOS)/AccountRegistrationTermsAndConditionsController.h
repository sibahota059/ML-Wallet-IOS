//
//  AccountRegistrationTermsAndConditionsController.h
//  ML Wallet
//
//  Created by ml on 8/15/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
@interface AccountRegistrationTermsAndConditionsController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *termstxtView;

@property (strong, nonatomic) IBOutlet UIButton *btnDeclineAccReg;
@property (strong, nonatomic) IBOutlet UIButton *btnAcceptAccReg;
@end
