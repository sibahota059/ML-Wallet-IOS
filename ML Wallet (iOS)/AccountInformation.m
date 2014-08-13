//
//  AccountInformation.m
//  Account
//
//  Created by mm20-18 on 2/20/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "AccountInformation.h"

@interface AccountInformation ()

@end

@implementation AccountInformation

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
    
    UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    [profileImageView setImage:[UIImage imageNamed:@"rene.jpg"]];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 40, 300, 30)];
    [nameLabel setFont:[UIFont fontWithName:nil size:15.0f]];
    [nameLabel setText:@"Harry Cobrado Lingad"];

    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 60, 300, 30)];
    [phoneLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [phoneLabel setText:@"09273444456"];

    
    
    
    
    
    UILabel *walletLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 80, 25)];
    [walletLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [walletLabel setTextColor:[UIColor grayColor]];
    [walletLabel setText:@"KPWallet No:"];
    
    UILabel *balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 80, 25)];
    [balanceLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [balanceLabel setTextColor:[UIColor grayColor]];
    [balanceLabel setText:@"Balance:"];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 80, 25)];
    [addressLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [addressLabel setTextColor:[UIColor grayColor]];
    [addressLabel setText:@"Address:"];
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 80, 25)];
    [emailLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [emailLabel setTextColor:[UIColor grayColor]];
    [emailLabel setText:@"Email:"];
    
    
    UILabel *walletValue = [[UILabel alloc] initWithFrame:CGRectMake(100, 160, 300, 25)];
    [walletValue setFont:[UIFont fontWithName:nil size:13.0f]];
    [walletValue setText:@"140300000000123"];
    
    UILabel *pesoSign = [[UILabel alloc] initWithFrame:CGRectMake(100, 180, 20, 25)];
    [pesoSign setFont:[UIFont fontWithName:nil size:20.0f]];
    [pesoSign setTextColor:[UIColor redColor]];
    [pesoSign setText:@"₱ "];
    
    UILabel *balanceValue = [[UILabel alloc] initWithFrame:CGRectMake(115, 180, 100, 25)];
    [balanceValue setFont:[UIFont fontWithName:nil size:13.0f]];
    [balanceValue setText:@"9,699"];
    
    UILabel *addressValue = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 300, 25)];
    [addressValue setFont:[UIFont fontWithName:nil size:13.0f]];
    [addressValue setText:@"Talamban"];
    
    UILabel *emailValue = [[UILabel alloc] initWithFrame:CGRectMake(100, 220, 300, 25)];
    [emailValue setFont:[UIFont fontWithName:nil size:13.0f]];
    [emailValue setText:@"harry@gmail.com"];
    
    
    
    
    
    
    
    
    
    
    UILabel *accountInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 190, 30)];
    [accountInfoLabel setFont:[UIFont fontWithName:nil size:20.0f]];
    [accountInfoLabel setTextColor:[UIColor redColor]];
    [accountInfoLabel setText:@"Account Information:"];
    
    
    
    
    [self.view addSubview:walletLabel];
    [self.view addSubview:balanceLabel];
    [self.view addSubview:addressLabel];
    [self.view addSubview:emailLabel];
    
    [self.view addSubview:walletValue];
    [self.view addSubview:pesoSign];
    [self.view addSubview:balanceValue];
    [self.view addSubview:addressValue];
    [self.view addSubview:emailValue];
    
    
    
    
    
    [self.view addSubview:profileImageView];
    [self.view addSubview:accountInfoLabel];
    
    [self.view addSubview:nameLabel];
    [self.view addSubview:phoneLabel];
    
    [self addNavigationBarButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addNavigationBarButton {
    
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
