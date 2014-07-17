//
//  AccountLogin.m
//  Registration
//
//  Created by mm20-18 on 3/12/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "AccountLogin.h"
#import "ProfileHeader.h"
#import "ProfileOutline.h"
#import "ProfileLabel.h"
#import "ProfileTextField.h"
#import "StartViewController.h"

@interface AccountLogin ()

@end

@implementation AccountLogin

ProfileTextField *userNameTF, *passwordTF, *retypePasswordTF;

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
    [self addNavigationBar];
    [self createLoginAccount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) createLoginAccount{
    
    
    ProfileHeader *loginHeader = [[ProfileHeader alloc] initWithValue:@" Create Login Account" x:5 y:-10 width:180];
    
    ProfileOutline *loginOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
    
    
    userNameTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(10, 30, 280, 30) word:@"Username/Login ID"];
    passwordTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(10, 80, 280, 30) word:@"Password"];
    retypePasswordTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(10, 130, 280, 30) word:@"Retype Password"];
    
    
    

    
    
    
    
    
    
    
    
    [loginOutline addSubview:loginHeader];
    
    
    [loginOutline addSubview:userNameTF];
    [loginOutline addSubview:passwordTF];
    [loginOutline addSubview:retypePasswordTF];
    
    
    
    
    
    [self.view addSubview:loginOutline];
    
    
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //    [UIView animateWithDuration:0.5
    //                          delay:0.0
    //                        options:UIViewAnimationOptionCurveEaseIn
    //                     animations:^{self.view.frame = CGRectMake(0, 20, 320, 1000); }
    //                     completion:^(BOOL finished){}];
    
    
    
    [userNameTF resignFirstResponder];
    [passwordTF resignFirstResponder];
    [retypePasswordTF resignFirstResponder];
    
    
    return YES;
}


-(void) addNavigationBar{
    
    UIView *submitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [submitButton setImage:[UIImage imageNamed:@"submit_profile.png"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(nextPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [submitView addSubview:submitButton];
    
    UIBarButtonItem *submit = [[UIBarButtonItem alloc] initWithCustomView:submitView];
    [self.navigationItem setRightBarButtonItem:submit];
}


-(void) nextPressed{
    
  //toDo
    
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end
