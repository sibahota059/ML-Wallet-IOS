//
//  EditPassword.m
//  ML Wallet
//
//  Created by mm20-18 on 8/1/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditPassword.h"
#import "NSDictionary+LoadWalletData.h"
#import "SaveWalletData.h"

@interface EditPassword ()

@end

@implementation EditPassword

MBProgressHUD *HUD;

EditPasswordWebService *editPasswordWS;
UIScrollView *profileScroll;

NSDictionary *loadData;
NSString *password, *wallet;

NSString *PASSWORD_VAL_ERROR = @"Validation Error";

UITextField *oldPassword, *newPassword, *confirmPassword;

NSString *finalOldPassword, *finalNewPassword, *finalConfirmPassword;

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 400)];
    
    //create object of MBProgressHUD class, set delegate, and add loader view
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
    
    editPasswordWS = [EditPasswordWebService new];
    
    loadData = [NSDictionary initRead_LoadWallet_Data];
    password = [loadData objectForKey:@"password"];
    
    wallet = [loadData objectForKey:@"walletno"];
    
    editPasswordWS.delegate = self;
    
    [self.view addSubview:profileScroll];
    
    [self createPasswordLabel];
    
    [self createPasswordValue];
    
    [self addNavigationBarButton];
}

-(void) createPasswordLabel{
    

    //Old Password
    UILabel *oldPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 25)];
    [oldPasswordLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [oldPasswordLabel setText:@"Type your old password"];
    
    
    //New Password
    UILabel *newPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 25)];
    [newPasswordLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [newPasswordLabel setText:@"Type your new password"];
    
    
    //Confirm Password
    UILabel *confirmPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 280, 25)];
    [confirmPasswordLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [confirmPasswordLabel setText:@"Confirm your new password"];
    
    
    [profileScroll addSubview:oldPasswordLabel];
    [profileScroll addSubview:newPasswordLabel];
    [profileScroll addSubview:confirmPasswordLabel];
    
}

-(void) createPasswordValue{
    
    
    //Old Password
    UIView *oldPasswordOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 45, 280, 30)];
    [oldPasswordOutline setBackgroundColor:[UIColor redColor]];
    oldPassword = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    oldPassword.secureTextEntry = YES;
    [oldPassword setBackgroundColor:[UIColor whiteColor]];
    [oldPassword setPlaceholder:@" Old Password"];
    [oldPasswordOutline addSubview:oldPassword];
    
    
    
    //New Password
    UIView *newPasswordOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 105, 280, 30)];
    [newPasswordOutline setBackgroundColor:[UIColor redColor]];
    newPassword = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    newPassword.secureTextEntry = YES;
    [newPassword setBackgroundColor:[UIColor whiteColor]];
    [newPassword setPlaceholder:@" New Password"];
    [newPasswordOutline addSubview:newPassword];
    
    
    //Address
    UIView *confirmPasswordOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 165, 280, 30)];
    [confirmPasswordOutline setBackgroundColor:[UIColor redColor]];
    confirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    confirmPassword.secureTextEntry = YES;
    [confirmPassword setBackgroundColor:[UIColor whiteColor]];
    [confirmPassword setPlaceholder:@" Confirm Password"];
    [confirmPasswordOutline addSubview:confirmPassword];
    

    [profileScroll addSubview:oldPasswordOutline];
    [profileScroll addSubview:newPasswordOutline];
    [profileScroll addSubview:confirmPasswordOutline];
    
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) didFinishEditingPassword:(NSString *)indicator andError:(NSString *)getError{
    
    UIAlertView *resultAlertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", editPasswordWS.respcode]isEqualToString:@"1"]){
        
        [resultAlertView setMessage:editPasswordWS.respmessage];
        oldPassword.text = @"";
        newPassword.text = @"";
        confirmPassword.text = @"";
        [self dismissProgressBar];
        [self saveToPaylist];
        

        
    }
    else if ([[NSString stringWithFormat:@"%@", editPasswordWS.respcode] isEqualToString:@"0"])
        
    {
        [resultAlertView setMessage:editPasswordWS.respmessage];
        
    }
    else if ([indicator isEqualToString:@"error"])
    {
        [resultAlertView setMessage:@"Error in editing your password."];
    }else{
        
        [resultAlertView setMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" ];
    }
    
    [resultAlertView show];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addNavigationBarButton {
    
    
    self.title =@"Password";
    //LEFT NAVIGATION BUTTON
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
//    [backButton setImage:[UIImage imageNamed:@"back_profile.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    
    UIBarButtonItem *backNavButton = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [backNavButton setStyle:UIBarButtonItemStyleBordered];
    
    
    
    
    //RIGHT NAVIGATION BUTTON
    UIView *saveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [saveButton setImage:[UIImage imageNamed:@"my_save.png"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(savePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [saveView addSubview:saveButton];
    
    
    UIBarButtonItem *saveNavButton = [[UIBarButtonItem alloc] initWithCustomView:saveView];
    [saveNavButton setStyle:UIBarButtonItemStyleBordered];
    
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationItem setLeftBarButtonItem:backNavButton];
    [self.navigationItem setRightBarButtonItem:saveNavButton];


    
    
}


-(void)backPressed:(id)sender{
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}


-(void)savePressed:(id)sender{
    
    UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:PASSWORD_VAL_ERROR message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    finalOldPassword = oldPassword.text;
    finalNewPassword = newPassword.text;
    finalConfirmPassword = confirmPassword.text;
    
    if([finalOldPassword isEqualToString:@""] || [finalNewPassword isEqualToString:@""] || [finalConfirmPassword isEqualToString:@""])
    {
        [saveAlert setMessage:@"Input all fields."];
        [saveAlert show];
    }
    else if (![finalOldPassword isEqualToString:password])
    {
        [saveAlert setMessage:@"Your old Password is incorrect."];
        [saveAlert show];
    }
    else if(finalNewPassword.length < 6)
    {
        [saveAlert setMessage:@"Password must have 6 or more characters."];
        [saveAlert show];
    }
    else if(![finalConfirmPassword isEqualToString:finalNewPassword])
    {
        [saveAlert setMessage:@"Password does not match."];
        newPassword.text = @"";
        confirmPassword.text = @"";
        [saveAlert show];
    }
    else if([finalNewPassword isEqualToString:finalOldPassword])
    {
        [saveAlert setMessage:@"New Password should not be same as old Password."];
        [saveAlert show];
    }
    else
    {
        [editPasswordWS wallet:wallet password:finalNewPassword];
        [self displayProgressBar];
    }
}

-(void) saveToPaylist{
    
    SaveWalletData *saveData = [SaveWalletData new];
    
    [saveData initSaveData:finalNewPassword forKey:@"password"];
    
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)displayProgressBar{
    
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    
}

- (void)dismissProgressBar{
    
    [HUD hide:YES];
    [HUD show:NO];
    
}



@end
