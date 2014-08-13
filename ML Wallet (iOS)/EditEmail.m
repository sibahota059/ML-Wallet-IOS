//
//  EditEmail.m
//  ML Wallet
//
//  Created by mm20-18 on 8/1/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditEmail.h"

@interface EditEmail ()

@end

@implementation EditEmail


UIScrollView *profileScroll;






- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 400)];
    
    
    
    
    [self.view addSubview:profileScroll];
    
    [self createEmailLabel];
    
    [self createEmailValue];
    
    [self addNavigationBarButton];
}



-(void) createEmailLabel{
    
    
    //Old Username
    UILabel *oldEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 25)];
    [oldEmailLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [oldEmailLabel setText:@"Type your old e-mail"];
    
    
    //New Username
    UILabel *newEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 25)];
    [newEmailLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [newEmailLabel setText:@"Type your new e-mail"];
    
    
    //Confirm Username
    UILabel *confirmEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 280, 25)];
    [confirmEmailLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [confirmEmailLabel setText:@"Confirm your new e-mail"];
    
    
    [profileScroll addSubview:oldEmailLabel];
    [profileScroll addSubview:newEmailLabel];
    [profileScroll addSubview:confirmEmailLabel];
    
}

-(void) createEmailValue{
    
    
    //Old Username
    UIView *oldEmailOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 45, 280, 30)];
    [oldEmailOutline setBackgroundColor:[UIColor redColor]];
    UITextField *oldEmail = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [oldEmail setBackgroundColor:[UIColor whiteColor]];
    [oldEmail setPlaceholder:@" Old e-mail"];
    [oldEmailOutline addSubview:oldEmail];
    
    
    
    //New Username
    UIView *newEmailOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 105, 280, 30)];
    [newEmailOutline setBackgroundColor:[UIColor redColor]];
    UITextField *newEmail = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [newEmail setBackgroundColor:[UIColor whiteColor]];
    [newEmail setPlaceholder:@" New e-mail"];
    [newEmailOutline addSubview:newEmail];
    
    
    //Username
    UIView *confirmEmailOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 165, 280, 30)];
    [confirmEmailOutline setBackgroundColor:[UIColor redColor]];
    UITextField *confirmEmail = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [confirmEmail setBackgroundColor:[UIColor whiteColor]];
    [confirmEmail setPlaceholder:@" Confirm e-mail"];
    [confirmEmailOutline addSubview:confirmEmail];
    
    
    [profileScroll addSubview:oldEmailOutline];
    [profileScroll addSubview:newEmailOutline];
    [profileScroll addSubview:confirmEmailOutline];
    
    
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
    
    
    self.title =@"Email";
    //LEFT NAVIGATION BUTTON
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
//    [backButton setImage:[UIImage imageNamed:@"back_profile.png"] forState:UIControlStateNormal];
     [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
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
