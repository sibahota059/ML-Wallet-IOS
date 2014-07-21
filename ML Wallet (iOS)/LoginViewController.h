//
//  LoginViewController.h
//  ML Wallet (iOS)
//
//  Created by ml on 2/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface LoginViewController : UIViewController <NSURLConnectionDelegate, MBProgressHUDDelegate, UITextFieldDelegate>
{
    MBProgressHUD *HUD;
}

@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSMutableData *responseData;
@property (assign, nonatomic) NSUInteger idd;
@property (nonatomic, assign) BOOL navigationBar;


@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)btnRegister:(id)sender;
- (IBAction)btnLogin:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txtUser;
@property (strong, nonatomic) IBOutlet UITextField *txtPass;


//Harry added
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil navigationHidden:(BOOL) navigationHidden;

@end
