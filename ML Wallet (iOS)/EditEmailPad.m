//
//  EditEmailPad.m
//  ML Wallet
//
//  Created by mm20-18 on 8/5/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditEmailPad.h"

@interface EditEmailPad ()

@end

@implementation EditEmailPad



UIScrollView *profileScroll;






- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(768, 400)];
    
    
    
    
    [self.view addSubview:profileScroll];
    
    [self createEmailLabel];
    
    [self createEmailValue];
    
    [self addNavigationBarButton];
}



-(void) createEmailLabel{
    
    
    //Old Username
    UILabel *oldEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 200, 250, 30)];
    [oldEmailLabel setFont:[UIFont fontWithName:nil size:19.0f]];
    [oldEmailLabel setText:@"Type your old e-mail"];
    
    
    //New Username
    UILabel *newEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 270, 250, 30)];
    [newEmailLabel setFont:[UIFont fontWithName:nil size:19.0f]];
    [newEmailLabel setText:@"Type your new e-mail"];
    
    
    //Confirm Username
    UILabel *confirmEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 340, 250, 30)];
    [confirmEmailLabel setFont:[UIFont fontWithName:nil size:19.0f]];
    [confirmEmailLabel setText:@"Confirm your new e-mail"];
    
    
    [profileScroll addSubview:oldEmailLabel];
    [profileScroll addSubview:newEmailLabel];
    [profileScroll addSubview:confirmEmailLabel];
    
}

-(void) createEmailValue{
    
    
    
    //Old Email
    UIView *oldEmailOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 230, 434, 35)];
    [oldEmailOutline setBackgroundColor:[UIColor redColor]];
    UITextField *oldEmail = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [oldEmail setBackgroundColor:[UIColor whiteColor]];
    [oldEmail setFont:[UIFont systemFontOfSize:19.0f]];
    [oldEmail setPlaceholder:@" Old e-mail"];
    [oldEmailOutline addSubview:oldEmail];
    
    
    
    //New Username
    UIView *newEmailOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 300, 434, 35)];
    [newEmailOutline setBackgroundColor:[UIColor redColor]];
    UITextField *newEmail = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [newEmail setBackgroundColor:[UIColor whiteColor]];
    [newEmail setFont:[UIFont systemFontOfSize:19.0f]];
    [newEmail setPlaceholder:@" New e-mail"];
    [newEmailOutline addSubview:newEmail];
    
    
    //Username
    UIView *confirmEmailOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 370, 434, 35)];
    [confirmEmailOutline setBackgroundColor:[UIColor redColor]];
    UITextField *confirmEmail = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [confirmEmail setBackgroundColor:[UIColor whiteColor]];
    [confirmEmail setFont:[UIFont systemFontOfSize:19.0f]];
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
