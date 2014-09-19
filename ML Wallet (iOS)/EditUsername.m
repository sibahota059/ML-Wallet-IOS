//
//  EditUsername.m
//  ML Wallet
//
//  Created by mm20-18 on 8/1/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditUsername.h"
#import "NSDictionary+LoadWalletData.h"
#import "SaveWalletData.h"

@interface EditUsername ()

@end

@implementation EditUsername

EditUserNameWebService *editUsernameWS;

MBProgressHUD *HUD;

NSString *USERNAME_VAL_ERROR = @"Validation Error";

NSString *userName, *wallet;

UIScrollView *profileScroll;

NSDictionary *loadData;

UITextField *oldUsername, *newUsername, *confirmUsername;

NSString *finalOldUserName, *finalNewUserName, *finalConfirmUserName;


- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 400)];
    
    editUsernameWS = [EditUserNameWebService new];
    
    loadData = [NSDictionary initRead_LoadWallet_Data];
    userName = [loadData objectForKey:@"username"];
     wallet = [loadData objectForKey:@"walletno"];
    
    //create object of MBProgressHUD class, set delegate, and add loader view
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
    
    editUsernameWS.delegate = self;
    
    [self.view addSubview:profileScroll];
    
    [self createUsernameLabel];
    
    [self createUsernameValue];
    
    [self addNavigationBarButton];
}

-(void) createUsernameLabel{
    
    
    //Old Username
    UILabel *oldUsernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 25)];
    [oldUsernameLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [oldUsernameLabel setText:@"Type your old username"];
    
    
    //New Username
    UILabel *newUsernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 25)];
    [newUsernameLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [newUsernameLabel setText:@"Type your new username"];
    
    
    //Confirm Username
    UILabel *confirmUsernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 280, 25)];
    [confirmUsernameLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [confirmUsernameLabel setText:@"Confirm your new username"];
    
    
    [profileScroll addSubview:oldUsernameLabel];
    [profileScroll addSubview:newUsernameLabel];
    [profileScroll addSubview:confirmUsernameLabel];
    
}

-(void) createUsernameValue{
    
    
    //Old Username
    UIView *leftMarginOldUsername = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    oldUsername = [[UITextField alloc] initWithFrame:CGRectMake(22, 47, 276, 26)];
    oldUsername.layer.cornerRadius = 8.0f;
    oldUsername.layer.masksToBounds = YES;
    oldUsername.layer.borderColor=[[UIColor redColor]CGColor];
    oldUsername.layer.borderWidth = 1.0f;
    oldUsername.leftView = leftMarginOldUsername;
    oldUsername.leftViewMode = UITextFieldViewModeAlways;
    [oldUsername setBackgroundColor:[UIColor whiteColor]];
    [oldUsername setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [oldUsername setPlaceholder:@" Old username"];
    [oldUsername setReturnKeyType:UIReturnKeyDone];
    oldUsername.delegate = self;
    [oldUsername setReturnKeyType:UIReturnKeyNext];
    
    
    
    //New Username
    UIView *leftMarginNewUsername = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    newUsername = [[UITextField alloc] initWithFrame:CGRectMake(22, 107, 276, 26)];
    newUsername.layer.cornerRadius = 8.0f;
    newUsername.layer.masksToBounds = YES;
    newUsername.layer.borderColor=[[UIColor redColor]CGColor];
    newUsername.layer.borderWidth = 1.0f;
    newUsername.leftView = leftMarginNewUsername;
    newUsername.leftViewMode = UITextFieldViewModeAlways;
    [newUsername setBackgroundColor:[UIColor whiteColor]];
    [newUsername setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [newUsername setPlaceholder:@" New username"];
    [newUsername setReturnKeyType:UIReturnKeyDone];
    newUsername.delegate = self;
    [newUsername setReturnKeyType:UIReturnKeyNext];
    
    
    
    //Username
    UIView *leftMarginConfirmUsername= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    confirmUsername = [[UITextField alloc] initWithFrame:CGRectMake(22, 167, 276, 26)];
    confirmUsername.layer.cornerRadius = 8.0f;
    confirmUsername.layer.masksToBounds = YES;
    confirmUsername.layer.borderColor=[[UIColor redColor]CGColor];
    confirmUsername.layer.borderWidth = 1.0f;
    confirmUsername.leftView = leftMarginConfirmUsername;
    confirmUsername.leftViewMode = UITextFieldViewModeAlways;
    [confirmUsername setBackgroundColor:[UIColor whiteColor]];
    [confirmUsername setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [confirmUsername setPlaceholder:@" Confirm username"];
    [confirmUsername setReturnKeyType:UIReturnKeyDone];
    confirmUsername.delegate = self;
    [confirmUsername setReturnKeyType:UIReturnKeyDone];
    
    
    [profileScroll addSubview:oldUsername];
    [profileScroll addSubview:newUsername];
    [profileScroll addSubview:confirmUsername];
    
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addNavigationBarButton {
    
    
    self.title =@"Username";
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
    
    UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:USERNAME_VAL_ERROR message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    
    finalOldUserName = oldUsername.text;
    finalNewUserName = newUsername.text;
    finalConfirmUserName = confirmUsername.text;
    
    
    
    if([finalOldUserName isEqualToString:@""] || [finalNewUserName isEqualToString:@""] |[finalConfirmUserName isEqualToString:@""])
    {
        [saveAlert setMessage:@"Input all fields."];
        [saveAlert show];
    }
    else if(![finalOldUserName isEqualToString:userName])
    {
        [saveAlert setMessage:@"Your old Username is incorrect."];
        [saveAlert show];
    }
    else if([self validateStringContainsAlphabetsOnly:finalNewUserName])
    {
        [saveAlert setMessage:@"Username must be a combination of letters and numbers."];
        [saveAlert show];
    }
    else if([self validateStringContainsNumbersOnly:finalNewUserName])
    {
        [saveAlert setMessage:@"Username must be a combination of letters and numbers."];
        [saveAlert show];
    }
    else if (finalNewUserName.length < 6)
    {
        [saveAlert setMessage:@"Username must have a 6 or more characters."];
        [saveAlert show];
    }
    else if (![finalNewUserName isEqualToString:finalConfirmUserName])
    {
        [saveAlert setMessage:@"Username does not match."];
        newUsername.text = @"";
        confirmUsername.text = @"";
        [saveAlert show];
    }
    else if([finalNewUserName isEqualToString:finalOldUserName])
    {
        [saveAlert setMessage:@"Username must not the same from Old Username."];
        newUsername.text = @"";
        confirmUsername.text = @"";
        [saveAlert show];
        
    }
    else
        
    {
        [editUsernameWS wallet:wallet username:finalNewUserName];
        [self displayProgressBar];
    }
    
    
    
    
}

-(void) saveToPaylist{
    
    SaveWalletData *saveData = [SaveWalletData new];
    
    [saveData initSaveData:finalNewUserName forKey:@"username"];
    
    
}



- (void) didFinishEditingUserName:(NSString *)indicator andError:(NSString *)getError{
    
    UIAlertView *resultAlertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", editUsernameWS.respcode]isEqualToString:@"1"]){
        
        [resultAlertView setMessage:editUsernameWS.respmessage];
        [self dismissProgressBar];
        [self saveToPaylist];
        oldUsername.text = @"";
        newUsername.text = @"";
        confirmUsername.text = @"";
        
    }
    else if ([[NSString stringWithFormat:@"%@", editUsernameWS.respcode] isEqualToString:@"0"])
        
    {
        [resultAlertView setMessage:editUsernameWS.respmessage];
        
    }
    else if ([indicator isEqualToString:@"error"])
    {
        [resultAlertView setMessage:@"Error in editing your password."];
    }else{
        
        [resultAlertView setMessage:editUsernameWS.respmessage];
    }
    
    [resultAlertView show];
    
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(BOOL) validateStringContainsAlphabetsOnly:(NSString*)strng{
    NSCharacterSet *strCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];//1234567890_"];
    
    strCharSet = [strCharSet invertedSet];
    //And you can then use a string method to find if your string contains anything in the inverted set:
    
    NSRange r = [strng rangeOfCharacterFromSet:strCharSet];
    if (r.location != NSNotFound) {
        return NO;
    }
    else
        return YES;
}

-(BOOL) validateStringContainsNumbersOnly:(NSString*)strng{
    NSCharacterSet *strCharSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890_"];
    
    strCharSet = [strCharSet invertedSet];
    //And you can then use a string method to find if your string contains anything in the inverted set:
    
    NSRange r = [strng rangeOfCharacterFromSet:strCharSet];
    if (r.location != NSNotFound) {
        return NO;
    }
    else
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    Boolean isLatest = [ [ UIScreen mainScreen ] bounds ].size.height == 568;
    
    if (!isLatest)
    {
        if(textField == confirmUsername)
        {
            
            [UIView animateWithDuration:0.5
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{self.view.frame = CGRectMake(0, 50, 320,     568); }
                             completion:^(BOOL finished){}];
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == oldUsername)
    {
        [newUsername becomeFirstResponder];
    }
    else if(textField == newUsername)
    {
        [confirmUsername becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{self.view.frame = CGRectMake(0, 100, 320, 700); }
                         completion:^(BOOL finished){}];
        
        [textField resignFirstResponder];

    }
    
    
    return YES;
    
}



@end
