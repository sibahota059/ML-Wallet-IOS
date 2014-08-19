//
//  EditUsername.m
//  ML Wallet
//
//  Created by mm20-18 on 8/1/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditUsername.h"
#import "NSDictionary+LoadWalletData.h"

@interface EditUsername ()

@end

@implementation EditUsername

NSString *USERNAME_VAL_ERROR = @"Validation Error";

NSString *userName;

UIScrollView *profileScroll;

NSDictionary *loadData;

UITextField *oldUsername, *newUsername, *confirmUsername;

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
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 400)];
    
    loadData = [NSDictionary initRead_LoadWallet_Data];
    userName = [loadData objectForKey:@"username"];
    
    
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
    UIView *oldUsernameOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 45, 280, 30)];
    [oldUsernameOutline setBackgroundColor:[UIColor redColor]];
    oldUsername = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [oldUsername setBackgroundColor:[UIColor whiteColor]];
    [oldUsername setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [oldUsername setPlaceholder:@" Old username"];
    [oldUsernameOutline addSubview:oldUsername];
    
    
    
    //New Username
    UIView *newUsernameOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 105, 280, 30)];
    [newUsernameOutline setBackgroundColor:[UIColor redColor]];
    newUsername = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [newUsername setBackgroundColor:[UIColor whiteColor]];
    [newUsername setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [newUsername setPlaceholder:@" New username"];
    [newUsernameOutline addSubview:newUsername];
    
    
    //Username
    UIView *confirmUsernameOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 165, 280, 30)];
    [confirmUsernameOutline setBackgroundColor:[UIColor redColor]];
    confirmUsername = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [confirmUsername setBackgroundColor:[UIColor whiteColor]];
    [confirmUsername setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [confirmUsername setPlaceholder:@" Confirm username"];
    [confirmUsernameOutline addSubview:confirmUsername];
    
    
    [profileScroll addSubview:oldUsernameOutline];
    [profileScroll addSubview:newUsernameOutline];
    [profileScroll addSubview:confirmUsernameOutline];
    
    
}



- (void)didReceiveMemoryWarning
{
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
    
    
    NSString *userInputOldUserName = oldUsername.text;
    NSString *userInputNewUserName = newUsername.text;
    NSString *userInputConfirmUserName = confirmUsername.text;
    
    
    
    if([userInputOldUserName isEqualToString:@""] || [userInputNewUserName isEqualToString:@""] |[userInputConfirmUserName isEqualToString:@""])
    {
        [saveAlert setMessage:@"Input all fields."];
    }
    else if(![userInputOldUserName isEqualToString:userName])
    {
        [saveAlert setMessage:@"Your old Username is incorrect."];
    }
    else if([self validateStringContainsAlphabetsOnly:userInputNewUserName])
    {
        [saveAlert setMessage:@"Username must be a combination of letters and numbers."];
    }
    else if([self validateStringContainsNumbersOnly:userInputNewUserName])
    {
        [saveAlert setMessage:@"Username must be a combination of letters and numbers."];
    }
    else if (userInputNewUserName.length < 6)
    {
        [saveAlert setMessage:@"Username must have a 6 or more characters."];
    }
    else if (![userInputNewUserName isEqualToString:userInputConfirmUserName])
    {
        [saveAlert setMessage:@"Username does not match."];
        newUsername.text = @"";
        confirmUsername.text = @"";
    }
    else if([userInputNewUserName isEqualToString:userInputOldUserName])
    {
        [saveAlert setMessage:@"Username must not the same from Old Username."];
        newUsername.text = @"";
        confirmUsername.text = @"";
        
    }
    else
        
    {
        //TO DO
        [saveAlert setMessage:@"Success."];
        
    }
    
    
    [saveAlert show];
    
}



- (BOOL)prefersStatusBarHidden{
    return YES;
}


-(BOOL) validateStringContainsAlphabetsOnly:(NSString*)strng
{
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


-(BOOL) validateStringContainsNumbersOnly:(NSString*)strng
{
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




@end
