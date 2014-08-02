//
//  EditPassword.m
//  ML Wallet
//
//  Created by mm20-18 on 8/1/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditPassword.h"

@interface EditPassword ()

@end

@implementation EditPassword

UIScrollView *profileScroll;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 400)];
    

    
    
    [self.view addSubview:profileScroll];
    
    [self createPasswordLabel];
    
    [self createPasswordValue];
    
    [self addNavigationBarButton];
}



-(void) createPasswordLabel{
    

    //Old Password
    UILabel *oldPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 25)];
    [oldPasswordLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [oldPasswordLabel setText:@"Type your old password"];
    
    
    //New Password
    UILabel *newPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 25)];
    [newPasswordLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [newPasswordLabel setText:@"Type your new password"];
    
    
    //Confirm Password
    UILabel *confirmPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 280, 25)];
    [confirmPasswordLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [confirmPasswordLabel setText:@"Confirm your new password"];
    
    
    [profileScroll addSubview:oldPasswordLabel];
    [profileScroll addSubview:newPasswordLabel];
    [profileScroll addSubview:confirmPasswordLabel];
    
}

-(void) createPasswordValue{
    
    
    //Old Password
    UIView *oldPasswordOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 45, 280, 30)];
    [oldPasswordOutline setBackgroundColor:[UIColor redColor]];
    UITextField *oldPassword = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [oldPassword setBackgroundColor:[UIColor whiteColor]];
    [oldPassword setPlaceholder:@"Old Password"];
    [oldPasswordOutline addSubview:oldPassword];
    
    
    
    //New Password
    UIView *newPasswordOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 105, 280, 30)];
    [newPasswordOutline setBackgroundColor:[UIColor redColor]];
    UITextField *newPassword = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [newPassword setBackgroundColor:[UIColor whiteColor]];
    [newPassword setPlaceholder:@"New Password"];
    [newPasswordOutline addSubview:newPassword];
    
    
    //Address
    UIView *confirmPasswordOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 165, 280, 30)];
    [confirmPasswordOutline setBackgroundColor:[UIColor redColor]];
    UITextField *confirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [confirmPassword setBackgroundColor:[UIColor whiteColor]];
    [confirmPassword setPlaceholder:@"Confirm Password"];
    [confirmPasswordOutline addSubview:confirmPassword];
    

    [profileScroll addSubview:oldPasswordOutline];
    [profileScroll addSubview:newPasswordOutline];
    [profileScroll addSubview:confirmPasswordOutline];
    
    
}





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addNavigationBarButton {
    
    
    self.title =@"Password";
    //LEFT NAVIGATION BUTTON
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [backButton setImage:[UIImage imageNamed:@"back_profile.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    
    UIBarButtonItem *backNavButton = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [backNavButton setStyle:UIBarButtonItemStyleBordered];
    
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationItem setLeftBarButtonItem:backNavButton];
    
}


-(void)backPressed:(id)sender{
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}


- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
