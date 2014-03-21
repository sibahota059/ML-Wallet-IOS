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
    
    
    
    UIImageView *designTopLeft = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    [designTopLeft setImage:[UIImage imageNamed:@"design_top_left.png"]];
    
    UIImageView *designTopRight = [[UIImageView alloc] initWithFrame:CGRectMake(265, 5, 50, 50)];
    [designTopRight setImage:[UIImage imageNamed:@"design_top_right.png"]];
    
    UIImageView *designBottomLeft = [[UIImageView alloc] initWithFrame:CGRectMake(5, 360, 50, 50)];
    [designBottomLeft setImage:[UIImage imageNamed:@"design_buttom_left.png"]];
    
    UIImageView *designButtomRight = [[UIImageView alloc] initWithFrame:CGRectMake(265, 360, 50, 50)];
    [designButtomRight setImage:[UIImage imageNamed:@"design_buttom_right.png"]];

   
    
    //IMAGE
    UIImageView *imageFrameView = [[UIImageView alloc] initWithFrame:CGRectMake(95, 60, 130, 130)];
    [imageFrameView setImage:[UIImage imageNamed:@"profile_frame.jpg"]];
    
    UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 75, 100, 100)];
    [profileImageView setImage:[UIImage imageNamed:@"rene.jpg"]];
    
    
    
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 225, 300, 40)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [nameLabel setText:@"Harry Lingad"];
    
    UILabel *bdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 245, 300, 40)];
    bdayLabel.textAlignment = NSTextAlignmentCenter;
    [bdayLabel setText:@"November 1, 1985"];
    
    UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 265, 300, 40)];
    countryLabel.textAlignment = NSTextAlignmentCenter;    [countryLabel setText:@"Phillipines"];
    
    
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 325, 100, 30)];
    [backButton setBackgroundColor:[UIColor redColor]];
    [backButton setTitle:@"Home" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:designTopLeft];
    [self.view addSubview:designTopRight];
    [self.view addSubview:designBottomLeft];
    [self.view addSubview:designButtomRight];
    
    [self.view addSubview:nameLabel];
    [self.view addSubview:bdayLabel];
    [self.view addSubview:countryLabel];
    
    [self.view addSubview:backButton];
    
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
    
    UIView *profileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    
    UIButton *profileButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [profileButton setImage:[UIImage imageNamed:@"account_profile.png"] forState:UIControlStateNormal];
    [profileButton addTarget:self action:@selector(accountButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [profileView addSubview:profileButton];
    
    UIBarButtonItem *profileNavButton = [[UIBarButtonItem alloc] initWithCustomView:profileView];
    [profileNavButton setStyle:UIBarButtonItemStyleBordered];
    
    
    
    
    
    
    
    
    
    //RIGHT NAVIGATION BUTTON
    
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    
    UIButton *accountButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [accountButton setImage:[UIImage imageNamed:@"profile_profile.png"] forState:UIControlStateNormal];
    [accountButton addTarget:self action:@selector(profileButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

   
    [accountView addSubview:accountButton];
    
    UIBarButtonItem *accountNavButton = [[UIBarButtonItem alloc] initWithCustomView:accountView];
    [accountNavButton setStyle:UIBarButtonItemStyleBordered];
    
    
    
    
    
    
    //ADDING THE LEFT AND RIGHT BUTTON
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationItem setRightBarButtonItem:accountNavButton];
    [self.navigationItem setLeftBarButtonItem:profileNavButton];

    
}

-(void)backPressed:(id)sender{
    
    [self.navigationController  popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
    
}






@end
