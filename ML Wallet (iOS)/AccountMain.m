//
//  AccountMain.m
//  Account
//
//  Created by mm20-18 on 2/20/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "AccountMain.h"
#import "ProfileInformation.h"
#import "AccountInformation.h"
#import "MenuViewController.h"
#import "NSDictionary+LoadWalletData.h"

@interface AccountMain ()

@end

@implementation AccountMain


NSString *firstName ,*middleName, *lastName , *country, *province, *address, *zipcode, *gender, *bdate, *age, *mobileno, *emailadd, *nationality, *work, *answer1, *answer2, *answer3, *question1, *question2, *question3,
*walletNo, *respMessage, *resCode, *photo1, *photo2, *photo3, *photo4;


NSDictionary *loadData;

//USER BDAY USE IN GETTING AGE
NSDate *date;

UIImageView *profileImageView;

UIView *imageFrameView;

UILabel *nameLabel, *bdayLabel, *countryLabel;

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
    
    photo1 = [loadData objectForKey:@"photo1"];
    firstName = [loadData objectForKey:@"fname"];
    middleName = [loadData objectForKey:@"mname"];
    lastName = [loadData objectForKey:@"lname"];
    bdate = [loadData objectForKey:@"bdate"];
    country = [loadData objectForKey:@"country"];
    
    [self createUI];
   
    
   }


-(void)createUI{
    
    //IMAGE
    imageFrameView = [[UIView alloc] initWithFrame:CGRectMake(95, 60, 130, 130)];
    [imageFrameView setBackgroundColor:[UIColor redColor]];
    
    profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(97, 62, 126, 126)];
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:photo1 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *userImage = [UIImage imageWithData:data];
    if (userImage == nil)
    {
        [profileImageView setImage:[UIImage imageNamed:@"noImage.png"]];
    }
    else
    {
        [profileImageView setImage:userImage];
    }
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 205, 300, 40)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = [NSString stringWithFormat:@"%@ %@, %@", firstName, middleName, lastName];
    
    
    bdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 225, 300, 40)];
    bdayLabel.textAlignment = NSTextAlignmentCenter;
    bdayLabel.text = bdate;
    
    
    countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 245, 300, 40)];
    countryLabel.textAlignment = NSTextAlignmentCenter;
    countryLabel.text = country;
    
    UIButton *accountButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 325, 100, 30)];
    [accountButton setBackgroundColor:[UIColor redColor]];
    [accountButton setTitle:@"Account" forState:UIControlStateNormal];
    [accountButton addTarget:self action:@selector(accountButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *profileButton = [[UIButton alloc] initWithFrame:CGRectMake(170, 325, 100, 30)];
    [profileButton setBackgroundColor:[UIColor redColor]];
    [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
    [profileButton addTarget:self action:@selector(profileButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:nameLabel];
    [self.view addSubview:bdayLabel];
    [self.view addSubview:countryLabel];
    
    [self.view addSubview:accountButton];
    [self.view addSubview:profileButton];
    
    [self.view addSubview:imageFrameView];
    [self.view addSubview:profileImageView];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self addNavigationBarButton];
    
}





- (BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)profileButtonClicked:(id) sender{
    ProfileInformation *profileInfo = [[ProfileInformation alloc] initWithNibName:@"ProfileInformation" bundle:nil];
   
    [self.navigationController pushViewController:profileInfo animated:YES];
}

-(void)accountButtonClicked:(id) sender{
    
    
    AccountInformation *accountInfo = [[AccountInformation alloc] initWithNibName:@"AccountInformation" bundle:nil];
    
    [self.navigationController pushViewController:accountInfo animated:YES];
}



-(void)addNavigationBarButton{
    
    
//    UIBarButtonItem *profile = [[UIBarButtonItem alloc] initWithTitle:@"Profile" style:UIBarButtonItemStyleBordered target:self action:@selector(profileButtonClicked:)];
//    
//    UIBarButtonItem *account = [[UIBarButtonItem alloc] initWithTitle:@"Account" style:UIBarButtonItemStyleBordered target:self action:@selector(accountButtonClicked:)];
//
//    
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
//    [self.navigationItem setLeftBarButtonItem:account];
//    [self.navigationItem setRightBarButtonItem:profile];
    
    // LEFT NAVIGATION BUTTON
    
    
//    UIView *profileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
//    
//    UIButton *profileButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
//    [profileButton setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
//    [profileButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [profileView addSubview:profileButton];
//    
//    UIBarButtonItem *profileNavButton = [[UIBarButtonItem alloc] initWithCustomView:profileView];
//    [profileNavButton setStyle:UIBarButtonItemStyleBordered];
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"My Information";
    UIBarButtonItem *buttonHome = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backPressed:)];
  
    
    
    
    
    
    
    //ADDING THE LEFT AND RIGHT BUTTON
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationItem setLeftBarButtonItem:buttonHome];

    
}

-(void)backPressed:(id)sender{
    
    self.navigationController.navigationBarHidden = YES;
    MenuViewController *menuPage = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [self.navigationController pushViewController:menuPage animated:YES];
    
}


@end
