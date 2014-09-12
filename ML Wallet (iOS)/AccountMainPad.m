//
//  AccountMainPad.m
//  ML Wallet
//
//  Created by mm20-18 on 8/4/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "AccountMainPad.h"
#import "ProfileInformation.h"
#import "AccountInformationPad.h"
#import "MenuViewController.h"
#import "ProfileInformationPad.h"
#import "SaveWalletData.h"
#import "NSDictionary+LoadWalletData.h"

@interface AccountMainPad ()



@end

@implementation AccountMainPad

@synthesize nameLabel;
@synthesize bdayLabel;
@synthesize countryLabel;

@synthesize profileImageView;


NSString *firstName ,*middleName, *lastName , *country, *province, *address, *zipcode, *gender, *bdate, *age, *mobileno, *emailadd, *nationality, *work, *answer1, *answer2, *answer3, *question1, *question2, *question3,
    *walletNo, *respMessage, *resCode, *photo1, *photo2, *photo3, *photo4;

UIImage *image1 ;

UIImage *userImage;
UIView *imageFrameView;

//USER BDAY USE IN GETTING AGE
NSDate *date;
NSData *data;

UIButton *accountButton, *profileButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    accountButton = [[UIButton alloc] initWithFrame:CGRectMake(138, 680, 240, 72)];
    [accountButton setBackgroundImage:[UIImage imageNamed:@"headerbackground.png"]
                             forState:UIControlStateNormal];
    accountButton.titleLabel.font = [UIFont systemFontOfSize:31.0f];
    [accountButton setTitle:@"Account" forState:UIControlStateNormal];
    [accountButton addTarget:self action:@selector(accountButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    profileButton = [[UIButton alloc] initWithFrame:CGRectMake(398, 680, 240, 72)];
    [profileButton setBackgroundImage:[UIImage imageNamed:@"headerbackground.png"]
                             forState:UIControlStateNormal];
    profileButton.titleLabel.font = [UIFont systemFontOfSize:31.0f];
    [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
    [profileButton addTarget:self action:@selector(profileButtonClicked:) forControlEvents:UIControlEventTouchUpInside];


    
    [self createUI];
   
    
    [self.view addSubview:accountButton];
    [self.view addSubview:profileButton];
    
    self.navigationController.navigationBarHidden = NO;
    
}







//Finish already===================================
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)profileButtonClicked:(id) sender{
    ProfileInformationPad *profileInfo = [[ProfileInformationPad alloc] initWithNibName:@"ProfileInformationPad" bundle:nil];
    
    [self.navigationController pushViewController:profileInfo animated:YES];
}
-(void)accountButtonClicked:(id) sender{
    
    
    AccountInformationPad *accountInfo = [[AccountInformationPad alloc] initWithNibName:@"AccountInformationPad" bundle:nil];
    
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
//    MenuViewController *menuPage = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
//    [self.navigationController pushViewController:menuPage animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}
//=================================================




-(void)createUI{

    profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(266, 166, 236, 236)];
    
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(84, 424, 600, 40)];
    [nameLabel setFont:[UIFont fontWithName:nil size:31.0f]];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    
    
    bdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(84, 464, 600, 30)];
    [bdayLabel setFont:[UIFont fontWithName:nil size:28.0f]];
    bdayLabel.textAlignment = NSTextAlignmentCenter;
    
    countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(84, 500, 600, 30)];
    [countryLabel setFont:[UIFont fontWithName:nil size:28.0f]];
    countryLabel.textAlignment = NSTextAlignmentCenter;
   
    
    
    
    [self.view addSubview:nameLabel];
    [self.view addSubview:bdayLabel];
    [self.view addSubview:countryLabel];
    
    [self.view addSubview:imageFrameView];
    [self.view addSubview:profileImageView];
    
    
    [self addNavigationBarButton];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self loadFromPlaylist];
    [self setInfo];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(int) userAge:(NSDate *)birthDay{

    NSDate* currentDate = [NSDate date];
    NSTimeInterval secondsBetween = [currentDate timeIntervalSinceDate:birthDay];
    int days = secondsBetween / 86400;
    int  age = days/ 364 ;
    return age;
}

-(void) loadFromPlaylist{
    
    NSDictionary *loadData = [NSDictionary initRead_LoadWallet_Data];
    
    photo1 = [loadData objectForKey:@"photo1"];
    firstName = [loadData objectForKey:@"fname"];
    middleName = [loadData objectForKey:@"mname"];
    lastName = [loadData objectForKey:@"lname"];
    bdate = [loadData objectForKey:@"bdate"];
    country = [loadData objectForKey:@"country"];
    
}

-(void)setInfo{
    
    nameLabel.text = [NSString stringWithFormat:@"%@ %@, %@", firstName, middleName, lastName];
    bdayLabel.text = bdate;
    countryLabel.text = country;
    
    data = [[NSData alloc]initWithBase64EncodedString:photo1 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    userImage = [UIImage imageWithData:data];
    if (userImage == nil)
    {
        [profileImageView setImage:[UIImage imageNamed:@"noImage.png"]];
    }
    else
    {
        [profileImageView setImage:userImage];
    }
    
    
    
    
    
}


@end
