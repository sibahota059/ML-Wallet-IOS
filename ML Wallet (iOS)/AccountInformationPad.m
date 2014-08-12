//
//  AccountInformationPad.m
//  ML Wallet
//
//  Created by mm20-18 on 8/5/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "AccountInformationPad.h"
#import "NSDictionary+LoadWalletData.h"

@interface AccountInformationPad ()

@end

@implementation AccountInformationPad


NSDictionary *loadData;

NSString *firstNameValue, *middleNameValue, *lastNameValue,  *addressValue, *mobileNumberValue, *emailValue, *photo1Value, *walletValue, *balanceValue;

UIImageView *profileImage;

UILabel *profileName, *profilePhone;


UILabel *wallet, *balance, *address, *email;

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
    
    
    loadData = [NSDictionary initRead_LoadWallet_Data];

    
    [self createInfo];
    
    [self loadFromPlaylist];
    [self setInfo];
    
    
         [self addNavigationBarButton];
    
}



-(void) loadFromPlaylist{
    
    
    photo1Value =[loadData objectForKey:@"photo1"];
    NSLog(@"test: %@", photo1Value);
    
    firstNameValue = [loadData objectForKey:@"fname"];
    NSLog(@"test: %@", firstNameValue);
    
    middleNameValue = [loadData objectForKey:@"mname"];
    NSLog(@"test: %@", middleNameValue);
    
    lastNameValue = [loadData objectForKey:@"lname"];
    NSLog(@"test: %@", lastNameValue);
    
    mobileNumberValue =[loadData objectForKey:@"mobileno"];
    NSLog(@"test: %@", mobileNumberValue);
    
    walletValue = [loadData objectForKey:@"walletno"];
    NSLog(@"test: %@", firstNameValue);
    
    balanceValue = [loadData objectForKey:@"balance"];
    NSLog(@"test: %@", balanceValue);
    
    
    addressValue =[loadData objectForKey:@"permanentAdd"];
    NSLog(@"test: %@", firstNameValue);
    
    emailValue =[loadData objectForKey:@"emailadd"];
    NSLog(@"test: %@", emailValue);

    
    
}



-(void) setInfo{
    
    //CONVERTING STRING INTO IMAGE=================================================
    NSData *data = [[NSData alloc]initWithBase64EncodedString:photo1Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    [profileImage setImage:[UIImage imageWithData:data]];
    
    //================================================================================
    
    
    [profileName setText:[NSString stringWithFormat:@"%@ %@. %@",firstNameValue, middleNameValue, lastNameValue]];
    [profilePhone setText:mobileNumberValue];

    [wallet setText:walletValue];
    [balance setText:[NSString stringWithFormat:@"%@", balanceValue]];
    [address setText:addressValue];
    [email setText:emailValue];
    
    
    
}

-(void)createInfo
{
    
    UIView *profileImageView = [[UIView alloc] initWithFrame:CGRectMake(167, 44, 150, 150)];
    [profileImageView setBackgroundColor:[UIColor redColor]];
    
    profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 146, 146)];
    
    
    profileName = [[UILabel alloc] initWithFrame:CGRectMake(327, 90, 400, 30)];
    [profileName setFont:[UIFont fontWithName:nil size:22.0f]];
    
    profilePhone = [[UILabel alloc] initWithFrame:CGRectMake(327, 115, 400, 25)];
    [profilePhone setFont:[UIFont fontWithName:nil size:19.0f]];
    
    
    UILabel *walletLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 265, 150, 30)];
    [walletLabel setFont:[UIFont fontWithName:nil size:19.0f]];
    [walletLabel setTextColor:[UIColor grayColor]];
    [walletLabel setText:@"KP Wallet No:"];
    
    UILabel *balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 295, 150, 30)];
    [balanceLabel setFont:[UIFont fontWithName:nil size:19.0f]];
    [balanceLabel setTextColor:[UIColor grayColor]];
    [balanceLabel setText:@"Balance:"];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 325, 150, 30)];
    [addressLabel setFont:[UIFont fontWithName:nil size:19.0f]];
    [addressLabel setTextColor:[UIColor grayColor]];
    [addressLabel setText:@"Address:"];
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(167, 355, 150, 30)];
    [emailLabel setFont:[UIFont fontWithName:nil size:19.0f]];
    [emailLabel setTextColor:[UIColor grayColor]];
    [emailLabel setText:@"Email:"];
    
    
    
    
    
    wallet = [[UILabel alloc] initWithFrame:CGRectMake(317, 265, 300, 30)];
    [wallet setFont:[UIFont fontWithName:nil size:19.0f]];
    
    UILabel *pesoSign = [[UILabel alloc] initWithFrame:CGRectMake(317, 295, 300, 30)];
    [pesoSign setFont:[UIFont fontWithName:nil size:22.0f]];
    [pesoSign setTextColor:[UIColor redColor]];
    [pesoSign setText:@"₱ "];
    
    balance = [[UILabel alloc] initWithFrame:CGRectMake(337, 295, 300, 30)];
    [balance setFont:[UIFont fontWithName:nil size:19.0f]];
    
    address = [[UILabel alloc] initWithFrame:CGRectMake(317, 325, 300, 30)];
    [address setFont:[UIFont fontWithName:nil size:19.0f]];
    
    email = [[UILabel alloc] initWithFrame:CGRectMake(317, 355, 300, 30)];
    [email setFont:[UIFont fontWithName:nil size:19.0f]];
    
    UILabel *accountInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 205, 300, 40)];
    [accountInfoLabel setFont:[UIFont fontWithName:nil size:30.0f]];
    [accountInfoLabel setTextColor:[UIColor redColor]];
    [accountInfoLabel setText:@"Account Information"];
    
    
    [profileImageView addSubview:profileImage];
    
    [self.view addSubview:walletLabel];
    [self.view addSubview:balanceLabel];
    [self.view addSubview:addressLabel];
    [self.view addSubview:emailLabel];
    
    [self.view addSubview:wallet];
    [self.view addSubview:pesoSign];
    [self.view addSubview:balance];
    [self.view addSubview:address];
    [self.view addSubview:email];
    
    [self.view addSubview:profileImageView];
    [self.view addSubview:accountInfoLabel];
    
    [self.view addSubview:profileName];
    [self.view addSubview:profilePhone];

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
