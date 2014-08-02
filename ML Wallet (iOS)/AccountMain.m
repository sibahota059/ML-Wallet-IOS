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


@interface AccountMain ()

@end

@implementation AccountMain

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
    
   
    
    //IMAGE
    UIImageView *imageFrameView = [[UIImageView alloc] initWithFrame:CGRectMake(95, 60, 130, 130)];
    [imageFrameView setImage:[UIImage imageNamed:@"profile_frame.jpg"]];
    
    UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 75, 100, 100)];
    [profileImageView setImage:[UIImage imageNamed:@"rene.jpg"]];
    
    
    
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 205, 300, 40)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [nameLabel setText:@"Harry Lingad"];
    
    UILabel *bdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 225, 300, 40)];
    bdayLabel.textAlignment = NSTextAlignmentCenter;
    [bdayLabel setText:@"November 1, 1985"];
    
    UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 245, 300, 40)];
    countryLabel.textAlignment = NSTextAlignmentCenter;    [countryLabel setText:@"Phillipines"];
    
    
    
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
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationItem setLeftBarButtonItem:buttonHome];

    
}

-(void)backPressed:(id)sender{
    
    self.navigationController.navigationBarHidden = YES;
    MenuViewController *menuPage = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [self.navigationController pushViewController:menuPage animated:YES];
    
}






@end
