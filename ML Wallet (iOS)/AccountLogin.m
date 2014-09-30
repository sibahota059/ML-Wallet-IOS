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
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
#import "UIAlertView+alertMe.h"
#import "ServiceConnection.h"
#define ACCEPTABLE_CHARECTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"
#import "LoginViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "SaveWalletData.h"
#import "MenuViewController.h"
#import "DeviceID.h"
@interface AccountLogin ()

@end


@implementation AccountLogin{
    MBProgressHUD *HUD;
    NSMutableData *contentData;
    NSMutableData *pinData;
    NSURLConnection *conn;
    NSURLConnection *pinconn;
    ServiceConnection *con;
    CLLocationManager *locationManager;
    
    NSString *user;
    NSString *pass;
    
    NSString *walletno;
    NSString *fname;
    NSString *lname;
    NSString *photo;
    NSString *balance;
    NSString *mname;
    NSMutableData *responseData;
    UIAlertView *accountCreationSuccessAV;
    UIAlertView *accountCreationErrorAV;
    UIAlertView *pinResendSuccessAV;
    UIAlertView *pinResendErrorAV;
    UIAlertView *message;
    
}

@synthesize act_log_custIDfirstNumber;
@synthesize act_log_custIDsecondNumber;
@synthesize act_log_custIDthirdNumber;
@synthesize act_log_custIDphoneNumber;

@synthesize act_log_firstName;
@synthesize act_log_middleName;
@synthesize act_log_lastName;
@synthesize act_log_country;
@synthesize act_log_province;
@synthesize act_log_address;
@synthesize act_log_zipcode;
@synthesize act_log_gender;
@synthesize act_log_birthdate;
@synthesize act_log_number;
@synthesize act_log_email;
@synthesize act_log_work;
@synthesize act_log_nationality;

@synthesize act_log_str_photo1;
@synthesize act_log_str_photo2;
@synthesize act_log_str_photo3;
@synthesize act_log_str_photo4;
@synthesize act_log_str_balance;
@synthesize act_log_str_secanswer1;
@synthesize act_log_str_secanswer2;
@synthesize act_log_str_secanswer3;
@synthesize act_log_str_secquestion1;
@synthesize act_log_str_secquestion2;
@synthesize act_log_str_secquestion3;
@synthesize act_log_str_walletno;

@synthesize responseData;
@synthesize idd;
@synthesize accountCreationtextFieldStatus;
@synthesize alertViewMessage;
@synthesize accountLoginWalletNumber;

ProfileTextField *userNameTF, *passwordTF, *retypePasswordTF;
CGRect screenRect;
CGFloat screenWidth;
CGFloat screenHeight;
UIScrollView *scrollView;
MBProgressHUD *HUD;
NSURL *resendPin_url;
NSURLRequest *resendPin_request;
NSURLConnection *resendPin_connection;
NSString *wallNum;



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
    NSLog(@"Account Login %f------%f",screenWidth,screenHeight);
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(screenWidth, screenHeight)];
    [self addNavigationBar];
    [self createLoginAccount];
    [self.view addSubview:scrollView];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    //Set UP Location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    [self dismiss:pinResendErrorAV];
    [self dismiss:accountCreationErrorAV];
    [self dismiss:pinResendSuccessAV];
    [self dismiss:accountCreationSuccessAV];
    [self dismiss:message];
    NSLog(@"View did disappear");
    
}

-(void)dismiss:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}


//User Interface creation
-(void) createLoginAccount{
    if ( IDIOM == IPAD ) {
        NSLog(@"IPAD NI");
        
        ProfileHeader *loginHeader = [[ProfileHeader alloc] initWithValue:@"Create Login Account" x:40 y:-35 width:300];
        [loginHeader setFrame:CGRectMake(40, -35, 300, 40)];
        loginHeader.font = [UIFont systemFontOfSize:24.0f];
        UIView* loginOutline = [[UIView alloc] initWithFrame:CGRectMake(10,screenHeight*.05,screenWidth,screenHeight)];
        
        userNameTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(10, 30, 400, 40) word:@"Username/Login ID"];
        userNameTF.layer.cornerRadius=8.0f;
        userNameTF.layer.masksToBounds=YES;
        userNameTF.layer.borderColor=[[UIColor redColor]CGColor];
        userNameTF.layer.borderWidth= 1.0f;
        userNameTF.font = [UIFont systemFontOfSize:24.0f];
        float userNameTF_Co = (screenWidth - (screenWidth/1.5))-((screenWidth/1.5)/4);
        [userNameTF setFrame:CGRectMake(userNameTF_Co, 30, screenWidth/1.5, 40)];
        
        passwordTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(10, 100, 400, 40) word:@"Password"];
        passwordTF.layer.cornerRadius=8.0f;
        passwordTF.layer.masksToBounds=YES;
        passwordTF.layer.borderColor=[[UIColor redColor]CGColor];
        passwordTF.layer.borderWidth= 1.0f;
        passwordTF.font = [UIFont systemFontOfSize:24.0f];
        float passwordTF_Co = (screenWidth - (screenWidth/1.5))-((screenWidth/1.5)/4);
        [passwordTF setFrame:CGRectMake(passwordTF_Co, 100, screenWidth/1.5, 40)];
        
        retypePasswordTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(10, 170, 400, 40) word:@"Retype Password"];
        retypePasswordTF.layer.cornerRadius=8.0f;
        retypePasswordTF.layer.masksToBounds=YES;
        retypePasswordTF.layer.borderColor=[[UIColor redColor]CGColor];
        retypePasswordTF.layer.borderWidth= 1.0f;
        retypePasswordTF.font = [UIFont systemFontOfSize:24.0f];
        float retypePasswordTF_Co = (screenWidth - (screenWidth/1.5))-((screenWidth/1.5)/4);
        [retypePasswordTF setFrame:CGRectMake(retypePasswordTF_Co, 170, screenWidth/1.5, 40)];
        
        userNameTF.delegate = self;
        passwordTF.delegate = self;
        retypePasswordTF.delegate = self;
        
        [loginOutline addSubview:loginHeader];
        
        
        [loginOutline addSubview:userNameTF];
        [loginOutline addSubview:passwordTF];
        [loginOutline addSubview:retypePasswordTF];
        [scrollView addSubview:loginOutline];
        
        
    }
    else {
        NSLog(@"IPHONE NI");
        ProfileHeader *loginHeader = [[ProfileHeader alloc] initWithValue:@" Create Login Account" x:5 y:5 width:180];
        UIView* loginOutline = [[UIView alloc] initWithFrame:CGRectMake(10,10,screenWidth,screenHeight)];
        userNameTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(10, 30, 280, 30) word:@"Username/Login ID"];
        userNameTF.layer.cornerRadius=8.0f;
        userNameTF.layer.masksToBounds=YES;
        userNameTF.layer.borderColor=[[UIColor redColor]CGColor];
        userNameTF.layer.borderWidth= 1.0f;
        
        passwordTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(10, 80, 280, 30) word:@"Password"];
        passwordTF.layer.cornerRadius=8.0f;
        passwordTF.layer.masksToBounds=YES;
        passwordTF.layer.borderColor=[[UIColor redColor]CGColor];
        passwordTF.layer.borderWidth= 1.0f;
        
        retypePasswordTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(10, 130, 280, 30) word:@"Retype Password"];
        retypePasswordTF.layer.cornerRadius=8.0f;
        retypePasswordTF.layer.masksToBounds=YES;
        retypePasswordTF.layer.borderColor=[[UIColor redColor]CGColor];
        retypePasswordTF.layer.borderWidth= 1.0f;
        
        
        userNameTF.delegate = self;
        passwordTF.delegate = self;
        retypePasswordTF.delegate = self;
        
        [loginOutline addSubview:loginHeader];
        
        
        [loginOutline addSubview:userNameTF];
        [loginOutline addSubview:passwordTF];
        [loginOutline addSubview:retypePasswordTF];
        [scrollView addSubview:loginOutline];
        
        
    }
    
    
    
}


-(void) addNavigationBar{
    self.title = @"User Account";
    
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                                         initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    //next navigation button
    UIBarButtonItem *btnNext = [[UIBarButtonItem alloc] initWithTitle:
                                @"Next"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(nextPressed)];
    self.navigationItem.rightBarButtonItem = btnNext;
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

//Create Account method
-(void) nextPressed{
    NSString *str_username = userNameTF.text;
    NSString *str_password = passwordTF.text;
    NSString *str_reTypePassword = retypePasswordTF.text;
    
   
    
    if ([[str_username stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString:str_username]
        &&![[str_username stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]] isEqualToString:str_username]) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Username must be a combination of letters and numbers." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    else if(userNameTF.text.length==0||passwordTF.text.length==0||retypePasswordTF.text.length==0){
        NSLog(@"Failed'");
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Please fill all fields." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    else if(userNameTF.text.length<=5&&userNameTF.text.length>=1){
        NSLog(@"Failed'");
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Username Length must be greater than 6." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    else if(str_password.length<=5&&str_password.length>=1){
        NSLog(@"Failed'");
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Password Length must be greater than 6." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    else if(![str_password isEqualToString:str_reTypePassword]){
        NSLog(@"Failed'");
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Password did not match." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    else if(userNameTF.text.length>=6&&passwordTF.text.length>=6&&retypePasswordTF.text.length>=6){
        if([str_password isEqualToString:str_reTypePassword]){
            
            NSLog(@"Success");
            //[self createAccount];
            if ( IDIOM == IPAD ) {
                NSLog(@"Success Ipad");
                message = [[UIAlertView alloc] initWithTitle:@"Terms and Conditions."
                                                     message:@"1. Sender must comply with the Know Your Customer (KYC) form, present valid identification, and must subscribe to the AMLC rules and regulations and other applicable laws in making the transaction.\n\n2. The Sender must register the fullname of the receiver inclucing full middle name. Should the Sender fail to give the full middle name of the receiver, it shall be considered a waiver on this part to include his information in verifying the transaction, MLI shall not be held liable for any paid transactions to a receiver whose full middle name information was waived by the Sender. Incorrect spelling of the receiver's name(s) may cause delay in paying out the transaction.\n\n3. The Sender hereby agrees that the transaction shall be released to the claimant receiver if the latter can present the correct Kwarta Padala Transaction Number (KPTN) and comply with the valid ID, KYC and all other requirements as may be required by law.\n\n4. The sender must relay to the receiver the complete and correct KPTN and must advise the receiver to bring a valid ID for additional verification purposes.\n\n5. The Sender may waive the age requirement of the receiver. However, a minor receiver can only claim the money provided said minor is a relative of the sender to the 4th civil degree or godchild/ward/beneficiary of the sender or whose relationship with the sender is such that it does not violate the Child Trafficking Law. The said minor receiver must comply with the identification requirements mentioned herein. Minors below 12 years old must be accompanied by his/her guardian. Tha said guardian must comply with the requirements in Item No. 3 herein.\n\n6. The money is available for pickup in any MLFSI subject to hours of operation of the selected payout branch including closures without prior notice, its communications facility, its connectivity to the ML Wallet and MLKP Systems, and other conditions, including but not limited to power and telecommunications failure, computer or gadget failure, inclement weather and the like.\n\n7. Should the sender decides to cancel sendout, he/she must submit a written request to MLFSI for the cancellation of the said transaction. MLFSI will refund the principal amount of the money transfer only. MLFSI will refund the charges upon written request of the sender, only if the money transfer is not available at the recipient within seven (7) days from the time it was sent. To the extent allowed by law, MLFSI may deduct a service fee of FIVE HUNDRED PESOS (Php500) per month from money transfer that are not picked up after one month from the time it was sent.\n\n8. Changes to the original entries of the sendout will be made only at any MLFSI branches.\n\n9. In case of delay, non-payment or underpayment of this money transfer whether by fault or negligence of the company or its employees, neither shall be liable for damages beyond the sum of FIVE THOUSAND PESOS (P5,000), in addition to the refund of the principal amount of the money transfer and the service fee. In no event will the company or it's employees be liable for any indirect, special, incidental or consequential damages.\n\n10. MLFSI reserves the right to deactivate customer account in cases of three times login failure, however, the customer may request activation by calling our Customer Care.\n\n11. MLFSI may not accept, process or pay any money transfer that any of them determines, in their sole discretion, to be in violation of any MLFSI policy or applicable law.\n\n12. All claims or suits regarding this transaction shall be filed in the courts of Cebu City only.\n"
                                                    delegate:self
                                           cancelButtonTitle:@"Decline"
                                           otherButtonTitles:@"Accept", nil];
                
                [message show];
            }
            else{
                NSLog(@"Success Iphone");
                message = [[UIAlertView alloc] initWithTitle:@"Terms and Conditions."
                                                     message:@"1. Sender must comply with the Know Your Customer (KYC) form, present valid identification, and must subscribe to the AMLC rules and regulations and other applicable laws in making the transaction.\n\n2. The Sender must register the fullname of the receiver inclucing full middle name. Should the Sender fail to give the full middle name of the receiver, it shall be considered a waiver on this part to include his information in verifying the transaction, MLI shall not be held liable for any paid transactions to a receiver whose full middle name information was waived by the Sender. Incorrect spelling of the receiver's name(s) may cause delay in paying out the transaction.\n\n3. The Sender hereby agrees that the transaction shall be released to the claimant receiver if the latter can present the correct Kwarta Padala Transaction Number (KPTN) and comply with the valid ID, KYC and all other requirements as may be required by law.\n\n4. The sender must relay to the receiver the complete and correct KPTN and must advise the receiver to bring a valid ID for additional verification purposes.\n\n5. The Sender may waive the age requirement of the receiver. However, a minor receiver can only claim the money provided said minor is a relative of the sender to the 4th civil degree or godchild/ward/beneficiary of the sender or whose relationship with the sender is such that it does not violate the Child Trafficking Law. The said minor receiver must comply with the identification requirements mentioned herein. Minors below 12 years old must be accompanied by his/her guardian. Tha said guardian must comply with the requirements in Item No. 3 herein.\n\n6. The money is available for pickup in any MLFSI subject to hours of operation of the selected payout branch including closures without prior notice, its communications facility, its connectivity to the ML Wallet and MLKP Systems, and other conditions, including but not limited to power and telecommunications failure, computer or gadget failure, inclement weather and the like.\n\n7. Should the sender decides to cancel sendout, he/she must submit a written request to MLFSI for the cancellation of the said transaction. MLFSI will refund the principal amount of the money transfer only. MLFSI will refund the charges upon written request of the sender, only if the money transfer is not available at the recipient within seven (7) days from the time it was sent. To the extent allowed by law, MLFSI may deduct a service fee of FIVE HUNDRED PESOS (Php500) per month from money transfer that are not picked up after one month from the time it was sent.\n\n8. Changes to the original entries of the sendout will be made only at any MLFSI branches.\n\n9. In case of delay, non-payment or underpayment of this money transfer whether by fault or negligence of the company or its employees, neither shall be liable for damages beyond the sum of FIVE THOUSAND PESOS (P5,000), in addition to the refund of the principal amount of the money transfer and the service fee. In no event will the company or it's employees be liable for any indirect, special, incidental or consequential damages.\n\n10. MLFSI reserves the right to deactivate customer account in cases of three times login failure, however, the customer may request activation by calling our Customer Care.\n\n11. MLFSI may not accept, process or pay any money transfer that any of them determines, in their sole discretion, to be in violation of any MLFSI policy or applicable law.\n\n12. All claims or suits regarding this transaction shall be filed in the courts of Cebu City only.\n"
                                                    delegate:self
                                           cancelButtonTitle:@"Decline"
                                           otherButtonTitles:@"Accept", nil];
                
                [message show];
            }
           
            
            
        }
        else{
            
            [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Password did not match." delegate:nil cancelButton:@"Ok" otherButtons:nil];
            
        }
        
        
        
    }
    
}//end of create Account method

//resendPin Method
-(void)resendPin{
    
    NSLog(@"Resend Pin");
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    NSString *custID = [NSString stringWithFormat:@"ResendPIN/?walletno=%@",self.accountLoginWalletNumber];
    NSString *url = [NSString stringWithFormat:@"%@%@", [con NSGetCustomerIDService],custID];
    
    NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSLog(@"URL - %@", url);              // Checking the url
    
    NSMutableURLRequest *theRequest= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl]
                                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:10.0];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
    [theConnection start];
    
    self.idd = 4;
}

#pragma mark - Custom alert
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Accept"])
    {
        NSLog(@"Register");
        [self createAccount];
    }
    else if([title isEqualToString:@"Resend Pin"])
    {
        [self resendPin];
    }
    else if([title isEqualToString:@"Retry"])
    {
        NSLog(@"Retry");
        [self createAccount];
    }
    else if([title isEqualToString:@"Retry "])
    {
        NSLog(@"Retry_");
        [self resendPin];
    }
    else if([title isEqualToString:@"OK"]){
        NSLog(@"OK------");
        accountCreationSuccessAV = [[UIAlertView alloc] initWithTitle:@"Transaction Successfully Saved"
                                                              message:self.alertViewMessage
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                                    otherButtonTitles:@"Resend Pin",@"Login", nil];
        [accountCreationSuccessAV show];
    }
    else if([title isEqualToString:@"Login"])
    {
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}

//textField Listeners
- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y);
//    [scrollView setContentOffset:scrollPoint animated:YES];
    passwordTF.autocorrectionType = FALSE;
    retypePasswordTF.autocorrectionType = FALSE;
    userNameTF.autocorrectionType = FALSE;
    userNameTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    retypePasswordTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    if ( IDIOM != IPAD ) {
        
        if([passwordTF isFirstResponder]){
            [self animateTextField:textField up:YES num:-50];
            self.accountCreationtextFieldStatus = 1;
        }
        else if([retypePasswordTF isFirstResponder]){
            [self animateTextField:textField up:YES num:-60];
            self.accountCreationtextFieldStatus = 2;
        }
        
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if(self.accountCreationtextFieldStatus==1){
        [self animateTextField:textField up:NO num:-50];
        self.accountCreationtextFieldStatus=0;
    }
    else if(self.accountCreationtextFieldStatus==2){
        [self animateTextField:textField up:NO num:-60];
        self.accountCreationtextFieldStatus=0;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [userNameTF resignFirstResponder];
    [passwordTF resignFirstResponder];
    [retypePasswordTF resignFirstResponder];
    
    return NO;
}
//end of textField Listeners

-(void)animateTextField:(UITextField*)textField up:(BOOL)up num:(int)num
{
    const float movementDuration = 0.3f;
    
    int movement = (up ? num : -num);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

//account Creation method
-(void)createAccount{
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    
    contentData = [NSMutableData data];
    con         = [ServiceConnection new];
    
    NSString *strCustID = [NSString stringWithFormat:@"%@%@%@", act_log_custIDfirstNumber, act_log_custIDsecondNumber,act_log_custIDthirdNumber];
    NSString *strUsername = userNameTF.text;
    NSString *strPassword = passwordTF.text;
    //NSString *deviceID = [[DeviceID alloc] NSGetDeviceID];
    NSString *version =[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSLog(@"Ang account %@ %@",strUsername,strPassword);
    if([act_log_birthdate isEqualToString:@""]){
        act_log_birthdate = @"1985-11-23";
    }
    NSLog(@"Email ni --- %@",act_log_email);
    
    NSString *body =  [NSString stringWithFormat:@"{\"custid\":\"%@\",\"username\":\"%@\",\"password\":\"%@\",\"mobileno\":\"%@\",\"emailadd\":\"%@\",\"fname\":\"%@\",\"mname\":\"%@\",\"lname\":\"%@\",\"gender\":\"%@\",\"bdate\":\"%@\",\"nationality\":\"%@\",\"natureOfWork\":\"%@\",\"provinceCity\":\"%@\",\"permanentAdd\":\"%@\",\"country\":\"%@\",\"zipcode\":\"%@\",\"secquestion1\":\"%@\",\"secanswer1\":\"%@\",\"secquestion2\":\"%@\",\"secanswer2\":\"%@\",\"secquestion3\":\"%@\",\"secanswer3\":\"%@\",\"photo1\":\"%@\",\"photo2\":\"%@\",\"photo3\":\"%@\",\"photo4\":\"%@\",\"version\":\"%@\"}",strCustID,strUsername,strPassword,act_log_custIDphoneNumber,act_log_email,act_log_firstName,act_log_middleName,act_log_lastName,act_log_gender,act_log_birthdate,act_log_nationality,act_log_work,act_log_province,act_log_address,act_log_country,act_log_zipcode,act_log_str_secquestion1,act_log_str_secanswer1,act_log_str_secquestion2,act_log_str_secanswer2,act_log_str_secquestion3,act_log_str_secanswer3,act_log_str_photo1,act_log_str_photo2,act_log_str_photo3,act_log_str_photo4,version];
    
    
    NSString *serviceMethods = @"insertMobileAccounts";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", con.NSgetURLService, serviceMethods]];
    NSLog(@"Account Login Web Service URL ----a %@%@",url,body);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[body UTF8String] length:[body length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    self.idd = 3;
}




-(void)connection: (NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Did Receive Response");
    responseData = [[NSMutableData alloc]init];
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [responseData appendData:data];
    
    NSLog(@"didReceiveData");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [HUD hide:YES];
    [HUD show:NO];
    NSLog(@"Bad: %@", [error description]);
    if(self.idd==3){
        accountCreationErrorAV = [[UIAlertView alloc] initWithTitle:@"Exception Error"
                                                            message:[error localizedDescription]
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Retry", nil];
        
        [accountCreationErrorAV show];
    }
    else if(self.idd==4){
        pinResendErrorAV = [[UIAlertView alloc] initWithTitle:@"Exception Error"
                                                      message:[error localizedDescription]
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Retry ", nil];
        
        [pinResendErrorAV show];
    }
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    passwordTF.secureTextEntry = YES;
    retypePasswordTF.secureTextEntry = YES;
    return [string isEqualToString:filtered];
}//remove special Characters

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    NSLog(@"connectionDidFinishLoading");
    NSError *myError = nil;
    NSDictionary *res;
    res = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    if (myError == nil) {
        
        
        if(self.idd==3){
            NSDictionary *jsonResult = [res objectForKey:@"insertMobileAccountsResult"];
            NSString *strResponseCode = [jsonResult objectForKey:@"respcode"];
            NSString *strResponseMessage = [jsonResult objectForKey:@"respmessage"];
            NSString *strWalletNo = [jsonResult objectForKey:@"walletno"];
            self.accountLoginWalletNumber = strWalletNo;
            wallNum = strWalletNo;
            NSLog(@"Response %@ || Response Message %@",strResponseCode,strResponseMessage);
            NSLog(@"%@",self.accountLoginWalletNumber);
            int value = [strResponseCode intValue];
            self.alertViewMessage = [NSString stringWithFormat:@"You have successfully created ML Wallet account with Wallet ID no. %@. \n Pls. check your email for PIN verification.",self.accountLoginWalletNumber];
            if(value==1){
                accountCreationSuccessAV = [[UIAlertView alloc] initWithTitle:@"Congratulations!"
                                                                      message:self.alertViewMessage
                                                                     delegate:self
                                                            cancelButtonTitle:nil
                                                            otherButtonTitles:@"Resend Pin",@"Login", nil];
                
                [accountCreationSuccessAV show];
            }
            
            else if(value==2){
                
                accountCreationErrorAV = [[UIAlertView alloc] initWithTitle:@"Exception Error"
                                                                    message:strResponseMessage
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:@"Retry", nil];
                
                [accountCreationErrorAV show];
                
                
            }//end if lse if(value==2)
            
            else if (value==0){
                accountCreationErrorAV = [[UIAlertView alloc] initWithTitle:@"Exception Error"
                                                                    message:strResponseMessage
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:@"Retry", nil];
                
                [accountCreationErrorAV show];
            }//end else if (value==0)
        }//end self idd3
        else if(self.idd==4){
            NSLog(@"Response sa PIN = %@",res);
            
            NSDictionary *jsonResult = [res objectForKey:@"ResendPINResult"];
            NSString *strResponseCode = [jsonResult objectForKey:@"respcode"];
            NSString *strResponseMessage = [jsonResult objectForKey:@"respmessage"];
            //            NSString *strNoofAttempt = [jsonResult objectForKey:@"noofattempt"];
            //            NSString *strWalletNo = [jsonResult objectForKey:@"walletno"];
            NSLog(@"Response %@ || Response Message %@",strResponseCode,strResponseMessage);
            int value = [strResponseCode intValue];
            NSString *resendPinResponse = [NSString stringWithFormat:@"%@",strResponseMessage];
            if(value==1){
                pinResendSuccessAV = [[UIAlertView alloc] initWithTitle:@"Resend Pin"
                                                                message:resendPinResponse
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK",nil];
                
                [pinResendSuccessAV show];
                
            }
            else if(value==2){
                
                pinResendErrorAV = [[UIAlertView alloc] initWithTitle:@"Exception Error"
                                                              message:strResponseMessage
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                                    otherButtonTitles:@"Retry ", nil];
                
                [pinResendErrorAV show];
                
                
            }//end if lse if(value==2)
            else if (value==0){
                pinResendErrorAV = [[UIAlertView alloc] initWithTitle:@"Exception Error"
                                                              message:strResponseMessage
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                                    otherButtonTitles:@"Retry ", nil];
                
                [pinResendErrorAV show];
            }//end else if (value==0)
            
        }//self idd 4
        
        
    }//end if(myError == nil)
    else{
        if(self.idd==3){
            accountCreationErrorAV = [[UIAlertView alloc] initWithTitle:@"Exception Error"
                                                                message:[myError localizedDescription]
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Retry", nil];
            
            [accountCreationErrorAV show];
            NSLog(@"Error Account");
        }
        else if(self.idd==4){
            pinResendErrorAV = [[UIAlertView alloc] initWithTitle:@"Exception Error"
                                                          message:[myError localizedDescription]
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Retry ", nil];
            
            [pinResendErrorAV show];
            NSLog(@"Error Pin");
        }
        
    }//end else
    
    
    [HUD hide:YES];
    [HUD show:NO];
    
    
}
// ------------ ByPass ssl starts ----------

-(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:
(NSURLProtectionSpace *)protectionSpace {
    return YES;
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:
(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}

// -------------------ByPass ssl ends






- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
