//
//  AccountCreationTermsAndConditionsController.h
//  ML Wallet
//
//  Created by ml on 8/19/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountCreationTermsAndConditionsController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *termsAndconditionTextView;

@property (strong, nonatomic) IBOutlet UIButton *btnAccept;
@property (strong, nonatomic) IBOutlet UIButton *btnDecline;
@property (strong, nonatomic) IBOutlet UIView *pinConfirmationView;
@property (strong, nonatomic) IBOutlet UIView *errorNotificationView;
@property (strong, nonatomic) IBOutlet UIButton *btnRetry;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@end
