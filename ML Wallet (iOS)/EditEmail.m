//
//  EditEmail.m
//  ML Wallet
//
//  Created by mm20-18 on 8/1/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditEmail.h"
#import "NSDictionary+LoadWalletData.h"
#import "SaveWalletData.h"

@interface EditEmail ()

@end

@implementation EditEmail

EditEmailWebService *editEmailWS;

MBProgressHUD *HUD;

UIScrollView *profileScroll;


UITextField *oldEmail, *newEmail, *confirmEmail;

NSString *EMAIL_VAL_ERROR = @"Validation Error";

NSDictionary *loadData;

NSString *email, *wallet;

NSString *finalOldEmail, *finalNewEmail, *finalConfirmEmail;



- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 400)];
    
    editEmailWS = [EditEmailWebService new];
    
    //create object of MBProgressHUD class, set delegate, and add loader view
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    

    
    loadData = [NSDictionary initRead_LoadWallet_Data];
    email = [loadData objectForKey:@"emailadd"];
    wallet = [loadData objectForKey:@"walletno"];
    
    editEmailWS.delegate = self;
    [self.view addSubview:profileScroll];
    
    [self createEmailLabel];
    
    [self createEmailValue];
    
    [self addNavigationBarButton];
}

-(void) createEmailLabel{
    
    
    //Old Username
    UILabel *oldEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 25)];
    [oldEmailLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [oldEmailLabel setText:@"Type your old e-mail"];
    
    
    //New Username
    UILabel *newEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 25)];
    [newEmailLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [newEmailLabel setText:@"Type your new e-mail"];
    
    
    //Confirm Username
    UILabel *confirmEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 280, 25)];
    [confirmEmailLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [confirmEmailLabel setText:@"Confirm your new e-mail"];
    
    
    [profileScroll addSubview:oldEmailLabel];
    [profileScroll addSubview:newEmailLabel];
    [profileScroll addSubview:confirmEmailLabel];
    
}

-(void) createEmailValue{
    
    
    //Old Username
    UIView *oldEmailOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 45, 280, 30)];
    [oldEmailOutline setBackgroundColor:[UIColor redColor]];
    oldEmail = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [oldEmail setBackgroundColor:[UIColor whiteColor]];
    [oldEmail setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [oldEmail setPlaceholder:@" Old e-mail"];
    [oldEmailOutline addSubview:oldEmail];
    
    
    
    //New Username
    UIView *newEmailOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 105, 280, 30)];
    [newEmailOutline setBackgroundColor:[UIColor redColor]];
    newEmail = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [newEmail setBackgroundColor:[UIColor whiteColor]];
    [newEmail setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [newEmail setPlaceholder:@" New e-mail"];
    [newEmailOutline addSubview:newEmail];
    
    
    //Username
    UIView *confirmEmailOutline = [[UIView alloc] initWithFrame:CGRectMake(20, 165, 280, 30)];
    [confirmEmailOutline setBackgroundColor:[UIColor redColor]];
    confirmEmail = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 276, 26)];
    [confirmEmail setBackgroundColor:[UIColor whiteColor]];
    [confirmEmail setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [confirmEmail setPlaceholder:@" Confirm e-mail"];
    [confirmEmailOutline addSubview:confirmEmail];
    
    
    [profileScroll addSubview:oldEmailOutline];
    [profileScroll addSubview:newEmailOutline];
    [profileScroll addSubview:confirmEmailOutline];
    
    
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
    
    
    self.title =@"Email";
    //LEFT NAVIGATION BUTTON
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
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
    
    UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:EMAIL_VAL_ERROR message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    
    finalOldEmail = oldEmail.text;
    finalNewEmail = newEmail.text;
    finalConfirmEmail = confirmEmail.text;
    
    
    if([finalOldEmail isEqualToString:@""] || [finalNewEmail isEqualToString:@""] |[finalConfirmEmail isEqualToString:@""])
    {
        [saveAlert setMessage:@"Input all fields."];
        [saveAlert show];
    }
    
    else if(![finalOldEmail isEqualToString:email])
    {
        [saveAlert setMessage:@"Your old Email is incorrect."];
        [saveAlert show];
    }
    else  if(![self NSStringIsValidEmail:finalNewEmail])
    {
        [saveAlert setMessage:@"Email Address is in Invalid Format."];
        [saveAlert show];
    }
    else if (![finalNewEmail isEqualToString:finalConfirmEmail])
    {
        [saveAlert setMessage:@"Email does not match."];
        newEmail.text = @"";
        confirmEmail.text = @"";
        [saveAlert show];
    }
    else if([finalNewEmail isEqualToString:finalOldEmail])
    {
        [saveAlert setMessage:@"Email must not the same from Old Username."];
        newEmail.text = @"";
        confirmEmail.text = @"";
        [saveAlert show];
        
    }
    else
        
    {
         [editEmailWS wallet:wallet theEmail:finalNewEmail];
        [self displayProgressBar];
    }
    
}


-(void) saveToPaylist{
    
    SaveWalletData *saveData = [SaveWalletData new];
    
       [saveData initSaveData:finalNewEmail forKey:@"emailadd"];

    
}


- (void) didFinishEditingEmail:(NSString *)indicator andError:(NSString *)getError{
    
    UIAlertView *resultAlertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", editEmailWS.respcode]isEqualToString:@"1"]){
        
        [resultAlertView setMessage:@"Successfully saved."];
        [self saveToPaylist];
        [self dismissProgressBar];
        oldEmail.text = @"";
        newEmail.text = @"";
        confirmEmail.text = @"";
        

    }
    else if ([[NSString stringWithFormat:@"%@", editEmailWS.respcode] isEqualToString:@"0"])
    
    {
        [resultAlertView setMessage:editEmailWS.respmessage];

    }
    else if ([indicator isEqualToString:@"error"])
    {
        [resultAlertView setMessage:@"Error in editing your email."];
    }else{
        
        [resultAlertView setMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" ];
    }
    
    [resultAlertView show];
    
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString{
    BOOL stricterFilter = YES;
    
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
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
