//
//  EditUsernamePad.m
//  ML Wallet
//
//  Created by mm20-18 on 8/5/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditUsernamePad.h"

@interface EditUsernamePad ()

@end

@implementation EditUsernamePad



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
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(768, 400)];
    
    
    
    
    [self.view addSubview:profileScroll];
    
    [self createUsernameLabel];
    
    [self createUsernameValue];
    
    [self addNavigationBarButton];
}



-(void) createUsernameLabel{

   
    
    
    //Old Username
    UILabel *oldUsernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 200, 250, 30)];
    [oldUsernameLabel setFont:[UIFont fontWithName:nil size:19.0f]];
    [oldUsernameLabel setText:@"Type your old username"];
    
    
    //New Username
    UILabel *newUsernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 270, 250, 30)];
    [newUsernameLabel setFont:[UIFont fontWithName:nil size:19.0f]];
    [newUsernameLabel setText:@"Type your new username"];
    
    
    //Confirm Username
    UILabel *confirmUsernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 340, 250, 30)];
    [confirmUsernameLabel setFont:[UIFont fontWithName:nil size:19.0f]];
    [confirmUsernameLabel setText:@"Confirm your new username"];
    
    
    [profileScroll addSubview:oldUsernameLabel];
    [profileScroll addSubview:newUsernameLabel];
    [profileScroll addSubview:confirmUsernameLabel];
    
}

-(void) createUsernameValue{
    
 

    
    
    
    
    //Old Username
    UIView *oldUsernameOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 230, 434, 35)];
    [oldUsernameOutline setBackgroundColor:[UIColor redColor]];
    UITextField *oldUsername = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [oldUsername setBackgroundColor:[UIColor whiteColor]];
    [oldUsername setFont:[UIFont systemFontOfSize:19.0f]];
    [oldUsername setPlaceholder:@" Old username"];
    [oldUsernameOutline addSubview:oldUsername];
    
    
    
    //New Username
    UIView *newUsernameOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 300, 434, 35)];
    [newUsernameOutline setBackgroundColor:[UIColor redColor]];
    UITextField *newUsername = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [newUsername setBackgroundColor:[UIColor whiteColor]];
    [newUsername setFont:[UIFont systemFontOfSize:19.0f]];
    [newUsername setPlaceholder:@" New username"];
    [newUsernameOutline addSubview:newUsername];
    
    
    //Username
    UIView *confirmUsernameOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 370, 434, 35)];
    [confirmUsernameOutline setBackgroundColor:[UIColor redColor]];
    UITextField *confirmUsername = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [confirmUsername setBackgroundColor:[UIColor whiteColor]];
    [confirmUsername setFont:[UIFont systemFontOfSize:19.0f]];
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
