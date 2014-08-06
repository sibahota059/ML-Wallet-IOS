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
#import "UITextfieldAnimate.h"
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
#import "UITextfieldAnimate.h"
@interface EnterCustomerID ()

@end

@implementation EnterCustomerID

@synthesize customer;
CGRect screenRect;
CGFloat screenWidth;
CGFloat screenHeight;
ProfileTextField *firstNumberTF, *secondNumberTF, *thirdNumberTF, *phoneNumberTF;
UIScrollView *scrollView;
UITextfieldAnimate *textAnimate;
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
    
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(screenWidth, screenHeight)];
    
    RegistrationInformation *registraionInformation = [[RegistrationInformation alloc] initWithNibName:@"RegistrationInformation" bundle:nil];
    
    [self setNextViewController:registraionInformation myImage:[UIImage imageNamed:@"next.png"]];
    
    [self addNavigationBar];
    [self createCustomerID];
    
    [self.view addSubview:scrollView];
    
    textAnimate = [UITextfieldAnimate new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) createCustomerID{

    
//  RegistrationInformation *registrationInfo = [[RegistrationInformation alloc] initWithNibName:@"RegistrationInformation" bundle:nil];
//    
//  [self setNextViewController:registrationInfo myImage:[UIImage imageNamed:@"profile.png"]];
//    
    ProfileHeader *personalHeader = [[ProfileHeader alloc] initWithValue:@" Enter all fields" x:5 y:-10 width:120];
    
//  ProfileOutline *personalOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
    UIView* simpleView = [[UIView alloc] initWithFrame:CGRectMake(10,screenHeight*.15,screenWidth,screenHeight)];

    ProfileLabel *customerID = [[ProfileLabel alloc] initWithStatus:@"Enter your CustomerID" x:10 y:20 myColor:[UIColor grayColor] width:140];

    if ( IDIOM == IPAD ) {
        NSLog(@"IPAD NI");
        float personalHeader_Co = ((screenWidth - 170)/2)-170;
        [personalHeader setFrame:CGRectMake(personalHeader_Co, -10, 170, 30)];
        float customerID_Co = ((screenWidth - 170)/2)-150;
        [customerID setFrame:CGRectMake(customerID_Co, 20, 170, 30)];
        firstNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(204, 50, 120, 30) word:@""];
        firstNumberTF.layer.cornerRadius=8.0f;
        firstNumberTF.layer.masksToBounds=YES;
        firstNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        firstNumberTF.layer.borderWidth= 1.0f;
        float firstNumberTF_Co = ((screenWidth - 120)/2)-140;
        [firstNumberTF setFrame:CGRectMake(firstNumberTF_Co, 50, 120, 30)];
        
        secondNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(204, 50, 120, 30) word:@""];
        secondNumberTF.layer.cornerRadius=8.0f;
        secondNumberTF.layer.masksToBounds=YES;
        secondNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        secondNumberTF.layer.borderWidth= 1.0f;
        float secondNumberTF_Co = (screenWidth - 120)/2;
        [secondNumberTF setFrame:CGRectMake(secondNumberTF_Co, 50, 120, 30)];
        
        thirdNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(204, 50, 120, 30) word:@""];
        
        thirdNumberTF.layer.cornerRadius=8.0f;
        thirdNumberTF.layer.masksToBounds=YES;
        thirdNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        thirdNumberTF.layer.borderWidth= 1.0f;
        float thirdNumberTF_Co = ((screenWidth - 120)/2)+140;
        [thirdNumberTF setFrame:CGRectMake(thirdNumberTF_Co, 50, 120, 30)];
        NSLog(@"%f",thirdNumberTF_Co);
        
        ProfileLabel *phoneNumber = [[ProfileLabel alloc] initWithStatus:@"Enter your Phone Number" x:10 y:100 myColor:[UIColor grayColor] width:170];
        float phoneNumber_Co = ((screenWidth - 170)/2)-150;
        [phoneNumber setFrame:CGRectMake(phoneNumber_Co, 100, 170, 30)];
        phoneNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(12, 130, 400, 30) word:self.customer.firstName];
        phoneNumberTF.layer.cornerRadius=8.0f;
        phoneNumberTF.layer.masksToBounds=YES;
        phoneNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        phoneNumberTF.layer.borderWidth= 1.0f;
        float phoneNumberTF_Co = (screenWidth - 400)/2;
        [phoneNumberTF setFrame:CGRectMake(phoneNumberTF_Co, 130, 400, 30)];
        
        firstNumberTF.delegate = self;
        secondNumberTF.delegate = self;
        thirdNumberTF.delegate = self;
        phoneNumberTF.delegate = self;
        
        
        
        
        [simpleView addSubview:personalHeader];
        [simpleView addSubview:customerID];
        [simpleView addSubview:firstNumberTF];
        [simpleView addSubview:secondNumberTF];
        [simpleView addSubview:thirdNumberTF];
        [simpleView addSubview:phoneNumber];
        [simpleView addSubview:phoneNumberTF];
        [scrollView addSubview:simpleView];
    }
    else {
        NSLog(@"IPHONE NI");
        firstNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(12, 50, 84, 30) word:@""];
        firstNumberTF.layer.cornerRadius=8.0f;
        firstNumberTF.layer.masksToBounds=YES;
        firstNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        firstNumberTF.layer.borderWidth= 1.0f;
        
        secondNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(108, 50, 84, 30) word:@""];
        
        secondNumberTF.layer.cornerRadius=8.0f;
        secondNumberTF.layer.masksToBounds=YES;
        secondNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        secondNumberTF.layer.borderWidth= 1.0f;
        
        thirdNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(204, 50, 84, 30) word:@""];
        
        thirdNumberTF.layer.cornerRadius=8.0f;
        thirdNumberTF.layer.masksToBounds=YES;
        thirdNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        thirdNumberTF.layer.borderWidth= 1.0f;
        
        
        
        ProfileLabel *phoneNumber = [[ProfileLabel alloc] initWithStatus:@"Enter your Phone Number" x:10 y:100 myColor:[UIColor grayColor] width:170];
        
        phoneNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(12, 130, 275, 30) word:self.customer.firstName];
        phoneNumberTF.layer.cornerRadius=8.0f;
        phoneNumberTF.layer.masksToBounds=YES;
        phoneNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        phoneNumberTF.layer.borderWidth= 1.0f;
        
        
        firstNumberTF.delegate = self;
        secondNumberTF.delegate = self;
        thirdNumberTF.delegate = self;
        phoneNumberTF.delegate = self;
        
        
        
        
        [simpleView addSubview:personalHeader];
        [simpleView addSubview:customerID];
        [simpleView addSubview:firstNumberTF];
        [simpleView addSubview:secondNumberTF];
        [simpleView addSubview:thirdNumberTF];
        [simpleView addSubview:phoneNumber];
        [simpleView addSubview:phoneNumberTF];
        [scrollView addSubview:simpleView];
    }
    
    
    
    


}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textAnimate animateTextField:textField up:YES SelfView:self.view];
    //CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y);
    //[scrollView setContentOffset:scrollPoint animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
   // [scrollView setContentOffset:CGPointZero animated:YES];
    [textAnimate animateTextField:textField up:NO SelfView:self.view];
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [firstNumberTF resignFirstResponder];
    [secondNumberTF resignFirstResponder];
    [thirdNumberTF resignFirstResponder];
    [phoneNumberTF resignFirstResponder];

    return NO;
}


-(void) addNavigationBar{
self.title = @"Customer ID";
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [self.navigationItem setLeftBarButtonItem:back];
}


-(void) backPressed{
    
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end