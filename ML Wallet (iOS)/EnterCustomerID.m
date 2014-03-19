//
//  EnterCustomerID.m
//  Registration
//
//  Created by mm20-18 on 3/11/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "EnterCustomerID.h"
//#import "RegistrationInformation.h"
//#import "QuestionsActivity.h"

#import "ProfileOutline.h"
#import "ProfileHeader.h"
#import "ProfileLabel.h"
#import "ProfileTextField.h"
#import "RegistrationInformation.h"
#import "LoginViewController.h"

@interface EnterCustomerID ()

@end

@implementation EnterCustomerID

@synthesize customer;

ProfileTextField *firstNumberTF, *secondNumberTF, *thirdNumberTF, *phoneNumberTF;

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
    
    
    self.navigationController.navigationBarHidden = NO;
    
    RegistrationInformation *registraionInformation = [[RegistrationInformation alloc] initWithNibName:@"RegistrationInformation" bundle:nil];
    
    [self setNextViewController:registraionInformation myImage:[UIImage imageNamed:@"profile_profile.png"]];
    
    [self addNavigationBar];
    [self createCustomerID];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) createCustomerID{

    
//    RegistrationInformation *registrationInfo = [[RegistrationInformation alloc] initWithNibName:@"RegistrationInformation" bundle:nil];
//    
//    [self setNextViewController:registrationInfo myImage:[UIImage imageNamed:@"profile.png"]];
//    
    ProfileHeader *personalHeader = [[ProfileHeader alloc] initWithValue:@" Enter all fields" x:5 y:-10 width:120];
    
    ProfileOutline *personalOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
    
    
    
    ProfileLabel *customerID = [[ProfileLabel alloc] initWithStatus:@"Enter your CustomerID" x:10 y:20 myColor:[UIColor grayColor] width:140];
    
    firstNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(12, 50, 84, 30) word:@""];
    secondNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(108, 50, 84, 30) word:@""];
    thirdNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(204, 50, 84, 30) word:@""];
    
    
    
    ProfileLabel *phoneNumber = [[ProfileLabel alloc] initWithStatus:@"Enter your Phone Number" x:10 y:100 myColor:[UIColor grayColor] width:170];
    
    phoneNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(12, 130, 275, 30) word:self.customer.firstName];
   
    
    
    firstNumberTF.delegate = self;
    secondNumberTF.delegate = self;
    thirdNumberTF.delegate = self;
    phoneNumberTF.delegate = self;
    
    
    
    
    
    [personalOutline addSubview:personalHeader];
    
    
    [personalOutline addSubview:customerID];
    [personalOutline addSubview:firstNumberTF];
    [personalOutline addSubview:secondNumberTF];
    [personalOutline addSubview:thirdNumberTF];
    
    [personalOutline addSubview:phoneNumber];
    [personalOutline addSubview:phoneNumberTF];
    
    
    
    
    [self.view addSubview:personalOutline];


}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    

    
    
    [firstNumberTF resignFirstResponder];
    [secondNumberTF resignFirstResponder];
    [thirdNumberTF resignFirstResponder];
    [phoneNumberTF resignFirstResponder];
    
    return YES;
}


-(void) addNavigationBar{

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [backButton setImage:[UIImage imageNamed:@"back_profile.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [self.navigationItem setLeftBarButtonItem:back];
}


-(void) backPressed{
    
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil navigationHidden:YES ];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController]pushViewController:loginViewController animated:NO];
    
}




@end
