//
//  AccountInformation.m
//  Account
//
//  Created by mm20-18 on 2/20/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "AccountInformation.h"
#import "NSDictionary+LoadWalletData.h"

@interface AccountInformation ()

@end

@implementation AccountInformation

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

-(void) createInfo{
   
    
    
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
    
    
    
    
    
    profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    
    
    
    profileName = [[UILabel alloc] initWithFrame:CGRectMake(130, 40, 300, 30)];
    [profileName setFont:[UIFont fontWithName:nil size:15.0f]];
    [profileName setText:@"Harry Cobrado Lingad"];
    
    profilePhone = [[UILabel alloc] initWithFrame:CGRectMake(130, 60, 300, 30)];
    [profilePhone setFont:[UIFont fontWithName:nil size:13.0f]];
    [profilePhone setText:@"09273444456"];

    wallet = [[UILabel alloc] initWithFrame:CGRectMake(100, 160, 300, 25)];
    [wallet setFont:[UIFont fontWithName:nil size:13.0f]];
    
    UILabel *pesoSign = [[UILabel alloc] initWithFrame:CGRectMake(100, 180, 20, 25)];
    [pesoSign setFont:[UIFont fontWithName:nil size:20.0f]];
    [pesoSign setTextColor:[UIColor redColor]];
    [pesoSign setText:@"₱ "];
    
    balance = [[UILabel alloc] initWithFrame:CGRectMake(115, 180, 100, 25)];
    [balance setFont:[UIFont fontWithName:nil size:13.0f]];
    
    address = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 300, 25)];
    [address setFont:[UIFont fontWithName:nil size:13.0f]];
    
    email = [[UILabel alloc] initWithFrame:CGRectMake(100, 220, 300, 25)];
    [email setFont:[UIFont fontWithName:nil size:13.0f]];
    
    UILabel *accountInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 190, 30)];
    [accountInfoLabel setFont:[UIFont fontWithName:nil size:20.0f]];
    [accountInfoLabel setTextColor:[UIColor redColor]];
    [accountInfoLabel setText:@"Account Information:"];
    
    [self.view addSubview:walletLabel];
    [self.view addSubview:balanceLabel];
    [self.view addSubview:addressLabel];
    [self.view addSubview:emailLabel];
    
    [self.view addSubview:wallet];
    [self.view addSubview:pesoSign];
    [self.view addSubview:balance];
    [self.view addSubview:address];
    [self.view addSubview:email];
    
    [self.view addSubview:profileImage];
    [self.view addSubview:accountInfoLabel];
    
    [self.view addSubview:profileName];
    [self.view addSubview:profilePhone];

}

-(void) loadFromPlaylist{
 
    photo1Value =[loadData objectForKey:@"photo1"];
    firstNameValue = [loadData objectForKey:@"fname"];
    middleNameValue = [loadData objectForKey:@"mname"];
    lastNameValue = [loadData objectForKey:@"lname"];
    mobileNumberValue =[loadData objectForKey:@"mobileno"];
    walletValue = [loadData objectForKey:@"walletno"];
    balanceValue = [loadData objectForKey:@"balance"];
    addressValue =[loadData objectForKey:@"permanentAdd"];
    emailValue =[loadData objectForKey:@"emailadd"];
    
    
    
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
