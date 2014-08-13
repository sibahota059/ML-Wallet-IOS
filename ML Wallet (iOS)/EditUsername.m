//
//  EditUsername.m
//  ML Wallet
//
//  Created by mm20-18 on 8/1/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditUsername.h"

@interface EditUsername ()

@end

@implementation EditUsername



UIScrollView *profileScroll;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 400)];
    
    
    
    
    [self.view addSubview:profileScroll];
    
    [self createUsernameLabel];
    
    [self createUsernameValue];
    
    [self addNavigationBarButton];
}



-(void) createUsernameLabel{
    
    
    //Old Username
    UILabel *oldUsernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 25)];
    [oldUsernameLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [oldUsernameLabel setText:@"Type your old username"];
    
    
    //New Username
    UILabel *newUsernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 25)];
    [newUsernameLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [newUsernameLabel setText:@"Type your new username"];
    
    
    //Confirm Username
    UILabel *confirmUsernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 280, 25)];
    [confirmUsernameLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [confirmUsernameLabel setText:@"Confirm your new username"];
    
    
    [profileScroll addSubview:oldUsernameLabel];
    [profileScroll addSubview:newUsernameLabel];
    [profileScroll addSubview:confirmUsernameLabel];
    
}

-(void) createUsernameValue{
    
    
    //Old Username
    UIView *oldUsernameOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 45, 280, 30)];
    [oldUsernameOutline setBackgroundColor:[UIColor redColor]];
    UITextField *oldUsername = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [oldUsername setBackgroundColor:[UIColor whiteColor]];
    [oldUsername setPlaceholder:@" Old username"];
    [oldUsernameOutline addSubview:oldUsername];
    
    
    
    //New Username
    UIView *newUsernameOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 105, 280, 30)];
    [newUsernameOutline setBackgroundColor:[UIColor redColor]];
    UITextField *newUsername = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [newUsername setBackgroundColor:[UIColor whiteColor]];
    [newUsername setPlaceholder:@" New username"];
    [newUsernameOutline addSubview:newUsername];
    
    
    //Username
    UIView *confirmUsernameOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 165, 280, 30)];
    [confirmUsernameOutline setBackgroundColor:[UIColor redColor]];
    UITextField *confirmUsername = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [confirmUsername setBackgroundColor:[UIColor whiteColor]];
    [confirmUsername setPlaceholder:@" Confirm username"];
    [confirmUsernameOutline addSubview:confirmUsername];
    
    
    [profileScroll addSubview:oldUsernameOutline];
    [profileScroll addSubview:newUsernameOutline];
    [profileScroll addSubview:confirmUsernameOutline];
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addNavigationBarButton {
    
    
    self.title =@"Username";
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
