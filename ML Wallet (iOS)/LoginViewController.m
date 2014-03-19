//
//  LoginViewController.m
//  ML Wallet (iOS)
//
//  Created by ml on 2/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "LoginViewController.h"
#import "MenuViewController.h"
#import "InfoViewController.h"
#import "EnterCustomerID.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize navigationBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//Harry added
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil navigationHidden:(BOOL) navigationHidden
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        navigationBar = navigationHidden;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationController.navigationBarHidden = navigationBar;

    
    if ([UIScreen mainScreen].bounds.size.height == 568) //4 inch
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground1.png"]]];
    }
        else //4 inc below
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground2.png"]]];
    }
    
    
    [self.loginView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_img.png"]]];
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320, 600)];
    
    
}
- (IBAction)btnInfo:(id)sender {
    
    InfoViewController *gotoInfo = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    [self.navigationController pushViewController:gotoInfo animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)btnRegister:(id)sender {
    
    
    EnterCustomerID *enterCustomer = [[EnterCustomerID alloc] initWithNibName:@"EnterCustomerID" bundle:nil];
    
    [self.navigationController pushViewController:enterCustomer animated:YES];

//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message!" message:@"OK" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    
//    [alert show];
}

- (IBAction)btnLogin:(id)sender {
    
    MenuViewController *menuPage = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    //[self presentViewController:menuPage animated:YES completion:nil];
    [self.navigationController pushViewController:menuPage animated:YES];

}
@end
