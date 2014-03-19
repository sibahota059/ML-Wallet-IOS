//
//  LoginViewController.h
//  ML Wallet (iOS)
//
//  Created by ml on 2/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign) BOOL navigationBar;
- (IBAction)btnRegister:(id)sender;
- (IBAction)btnLogin:(id)sender;


//Harry added
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil navigationHidden:(BOOL) navigationHidden;
@end
