//
//  LoginViewController.h
//  ML Wallet (iOS)
//
//  Created by ml on 2/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface LoginViewController : UIViewController <NSURLConnectionDelegate, MBProgressHUDDelegate, UITextFieldDelegate, UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
}

@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSMutableData *responseData;
@property (assign, nonatomic) NSUInteger idd;
@property (nonatomic, assign) BOOL navigationBar;

//NEW PIN
@property (strong, nonatomic) IBOutlet UIView *NewPINView;
@property (strong, nonatomic) IBOutlet UITextField *OldPIN;
@property (strong, nonatomic) IBOutlet UITextField *NewPIN;
@property (strong, nonatomic) IBOutlet UITextField *ReNewPIN;
@property (strong, nonatomic) IBOutlet UIButton *btnRate;
@property (strong, nonatomic) IBOutlet UIButton *btnLocation;
@property (strong, nonatomic) IBOutlet UIButton *btnInfo;
- (IBAction)btnNotNow:(id)sender;
- (IBAction)btnRePIN:(id)sender;
- (IBAction)btnSubmit:(id)sender;
- (IBAction)btnInsuffi_submit:(id)sender;
- (IBAction)btnInsuffi_notnow:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtInsuffi_kptn;

@property (strong, nonatomic) IBOutlet UIView *InsufficientView;

@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)btnRegister:(id)sender;
- (IBAction)btnLogin:(id)sender;
- (IBAction)btnLocator:(id)sender;
- (IBAction)btnRates:(id)sender;
- (IBAction)btnResetPIN:(id)sender;
- (IBAction)btnForgotPassword:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txtUser;
@property (strong, nonatomic) IBOutlet UITextField *txtPass;


//Harry added
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil navigationHidden:(BOOL) navigationHidden;

@end
