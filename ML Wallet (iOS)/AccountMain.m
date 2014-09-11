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
#import "EditInformation.h"

@interface AccountMain ()

@end

@implementation AccountMain

@synthesize nameLabel;
@synthesize bdayLabel;
@synthesize countryLabel;

@synthesize profileImageView;


NSString *firstName ,*middleName, *lastName , *country, *province, *address, *zipcode, *gender, *bdate, *age, *mobileno, *emailadd, *nationality, *work, *answer1, *answer2, *answer3, *question1, *question2, *question3,
*walletNo, *respMessage, *resCode, *photo1, *photo2, *photo3, *photo4;


//USER BDAY USE IN GETTING AGE
NSDate *date;


UIImage *userImage;
UIView *imageFrameView;

UIButton *accountButton, *profileButton;

NSData *data;

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
    
    //IMAGE
    imageFrameView = [[UIView alloc] initWithFrame:CGRectMake(95, 60, 130, 130)];
    [imageFrameView setBackgroundColor:[UIColor redColor]];

    
    accountButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 325, 100, 30)];
    [accountButton setBackgroundImage:[UIImage imageNamed:@"headerbackground.png"]
                             forState:UIControlStateNormal];

    [accountButton setTitle:@"Account" forState:UIControlStateNormal];
    [accountButton addTarget:self action:NSSelectorFromString(@"accountButtonClicked:") forControlEvents:UIControlEventTouchUpInside];
    
    
    profileButton = [[UIButton alloc] initWithFrame:CGRectMake(170, 325, 100, 30)];
    [profileButton setBackgroundImage:[UIImage imageNamed:@"headerbackground.png"]
                             forState:UIControlStateNormal];
    
    [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
   [profileButton addTarget:self action:NSSelectorFromString(@"profileButtonClicked:") forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:accountButton];
    [self.view addSubview:profileButton];
    [self.view addSubview:imageFrameView];
    
    
    [self createUI];
    [self addNavigationBarButton];
    
    
  
    
    
    self.navigationController.navigationBarHidden = NO;
   
    
   }

-(void)viewWillAppear:(BOOL)animated
{
    
    [self loadFromPlaylist];
    [self setInfo];
}

-(void) viewWillDisappear:(BOOL)animated
{

}
-(void)createUI{
    
    
    profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(97, 62, 126, 126)];
    
   
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 205, 300, 40)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    
    
    bdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 225, 300, 40)];
    bdayLabel.textAlignment = NSTextAlignmentCenter;
    
    countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 245, 300, 40)];
    countryLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:nameLabel];
    [self.view addSubview:bdayLabel];
    [self.view addSubview:countryLabel];
    [self.view addSubview:profileImageView];
    
    

    
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



- (BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)profileButtonClicked:(id)sender{
    ProfileInformation *profileInfo = [[ProfileInformation alloc] initWithNibName:@"ProfileInformation" bundle:nil];
    [self.navigationController pushViewController:profileInfo animated:YES];



}

-(void)accountButtonClicked:(id)sender{
    
    
    AccountInformation *accountInfo = [[AccountInformation alloc] initWithNibName:@"AccountInformation" bundle:nil];
    
    [self.navigationController pushViewController:accountInfo animated:YES];
}

-(void)addNavigationBarButton{
    
    
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


-(void) loadFromPlaylist{
    
    NSDictionary *loadData = [NSDictionary initRead_LoadWallet_Data];
    
    photo1 = [loadData objectForKey:@"photo1"];
    firstName = [loadData objectForKey:@"fname"];
    middleName = [loadData objectForKey:@"mname"];
    lastName = [loadData objectForKey:@"lname"];
    bdate = [loadData objectForKey:@"bdate"];
    country = [loadData objectForKey:@"country"];
    
}


@end
