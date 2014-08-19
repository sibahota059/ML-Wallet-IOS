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
#define ACCEPTABLE_CHARECTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#import "LoginViewController.h"
@interface AccountLogin ()

@end


@implementation AccountLogin{
    MBProgressHUD *HUD;
    NSMutableData *contentData;
    NSMutableData *pinData;
    NSURLConnection *conn;
    NSURLConnection *pinconn;
    ServiceConnection *con;
    
    
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

ProfileTextField *userNameTF, *passwordTF, *retypePasswordTF;
CGRect screenRect;
CGFloat screenWidth;
CGFloat screenHeight;
UIScrollView *scrollView;
MBProgressHUD *HUD;
NSURL *resendPin_url;
NSURLRequest *resendPin_request;
NSURLConnection *resendPin_connection;



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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) createLoginAccount{
    if ( IDIOM == IPAD ) {
        NSLog(@"IPAD NI");
        
        ProfileHeader *loginHeader = [[ProfileHeader alloc] initWithValue:@"Create Login Account" x:40 y:-35 width:300];
        [loginHeader setFrame:CGRectMake(40, -35, 300, 40)];
        loginHeader.font = [UIFont systemFontOfSize:24.0f];
        // ProfileOutline *loginOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
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
        // ProfileOutline *loginOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
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
        //        passwordTF.secureTextEntry = YES;
        
        retypePasswordTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(10, 130, 280, 30) word:@"Retype Password"];
        retypePasswordTF.layer.cornerRadius=8.0f;
        retypePasswordTF.layer.masksToBounds=YES;
        retypePasswordTF.layer.borderColor=[[UIColor redColor]CGColor];
        retypePasswordTF.layer.borderWidth= 1.0f;
        //        retypePasswordTF.secureTextEntry = YES;
        
        
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
    
    //Set Background
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        
        if ([UIScreen mainScreen].bounds.size.height == 568) //4 inch
        {
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground1.png"]]];
        }
        else //4 inc below
        {
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground2.png"]]];
        }
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground5.png"]]];
    }
    
}


-(void) nextPressed{
    NSLog(@"Para Register Ni!");
    NSLog(@"Question ug answer ni %@ %@",act_log_str_secquestion1,act_log_str_secanswer1);
    NSLog(@"Phone ni %@",act_log_custIDphoneNumber);
    if(userNameTF.text.length==0||passwordTF.text.length==0||retypePasswordTF==0){
        NSLog(@"Failed'");
        [UIAlertView myCostumeAlert:@"Error!" alertMessage:@"Fill All Fields." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    else{
        NSLog(@"Success");
        //[self createAccount];
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Terms and Conditions."
                                                          message:@"1. Sender must comply with the Know Your Customer (KYC) form, present valid identification, and must subscribe to the AMLC rules and regulations and other applicable laws in making the transaction.\n\n2. The Sender must register the fullname of the receiver inclucing full middle name. Should the Sender fail to give the full middle name of the receiver, it shall be considered a waiver on this part to include his information in verifying the transaction, MLI shall not be held liable for any paid transactions to a receiver whose full middle name information was waived by the Sender. Incorrect spelling of the receiver's name(s) may cause delay in paying out the transaction.\n\n3. The Sender hereby agrees that the transaction shall be released to the claimant receiver if the latter can present the correct Kwarta Padala Transaction Number (KPTN) and comply with the valid ID, KYC and all other requirements as may be required by law.\n\n4. The sender must relay to the receiver the complete and correct KPTN and must advise the receiver to bring a valid ID for additional verification purposes.\n\n5. The Sender may waive the age requirement of the receiver. However, a minor receiver can only claim the money provided said minor is a relative of the sender to the 4th civil degree or godchild/ward/beneficiary of the sender or whose relationship with the sender is such that it does not violate the Child Trafficking Law. The said minor receiver must comply with the identification requirements mentioned herein. Minors below 12 years old must be accompanied by his/her guardian. Tha said guardian must comply with the requirements in Item No. 3 herein.\n\n6. The money is available for pickup in any MLFSI subject to hours of operation of the selected payout branch including closures without prior notice, its communications facility, its connectivity to the ML Wallet and MLKP Systems, and other conditions, including but not limited to power and telecommunications failure, computer or gadget failure, inclement weather and the like.\n\n7. Should the sender decides to cancel sendout, he/she must submit a written request to MLFSI for the cancellation of the said transaction. MLFSI will refund the principal amount of the money transfer only. MLFSI will refund the charges upon written request of the sender, only if the money transfer is not available at the recipient within seven (7) days from the time it was sent. To the extent allowed by law, MLFSI may deduct a service fee of FIVE HUNDRED PESOS (Php500) per month from money transfer that are not picked up after one month from the time it was sent.\n\n8. Changes to the original entries of the sendout will be made only at any MLFSI branches.\n\n9. In case of delay, non-payment or underpayment of this money transfer whether by fault or negligence of the company or its employees, neither shall be liable for damages beyond the sum of FIVE THOUSAND PESOS (P5,000), in addition to the refund of the principal amount of the money transfer and the service fee. In no event will the company or it's employees be liable for any indirect, special, incidental or consequential damages.\n\n10. MLFSI reserves the right to deactivate customer account in cases of three times login failure, however, the customer may request activation by calling our Customer Care.\n\n11. MLFSI may not accept, process or pay any money transfer that any of them determines, in their sole discretion, to be in violation of any MLFSI policy or applicable law.\n\n12. All claims or suits regarding this transaction shall be filed in the courts of Cebu City only.\n"
                                                         delegate:self
                                                cancelButtonTitle:@"Decline"
                                                otherButtonTitles:@"Accept", nil];
        
        [message show];
    }
    
}
-(void)userPin{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Pin."
                                                      message:@""
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"Resend Pin",@"Login", nil];
    
    [message show];
    
}

-(void)resendPin{

    NSLog(@"Resend Pin");
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    
    con = [ServiceConnection new];
    NSString *url = [NSString stringWithFormat:@"%@", [con NSGetCustomerIDService]];
    NSString *walletNum = [NSString stringWithFormat:@"ResendPIN/?walletno=%@",act_log_str_walletno];
    NSString *resendPinUrl = [NSString stringWithFormat:@"%@%@",url,walletNum];
    pinData = [[NSMutableData alloc]init];
    resendPin_url = [NSURL URLWithString:resendPinUrl];
    resendPin_request = [NSURLRequest requestWithURL:resendPin_url];
    resendPin_connection =[[NSURLConnection alloc]initWithRequest:resendPin_request delegate:self];
    NSLog(@"URL REQUEST PIN --- %@",resendPinUrl);

}
#pragma mark - Custom alert
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Accept"])
    {
        NSLog(@"Register");
        //[self createAccount];
         [self resendPin];
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
    else if([title isEqualToString:@"Login"])
    {
        LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        
         [self.navigationController pushViewController:loginController  animated:YES];
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y);
    [scrollView setContentOffset:scrollPoint animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [scrollView setContentOffset:CGPointZero animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [userNameTF resignFirstResponder];
    [passwordTF resignFirstResponder];
    [retypePasswordTF resignFirstResponder];
    
    return NO;
}

-(void)createAccount{
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    
    contentData = [NSMutableData data];
    con         = [ServiceConnection new];
    
    NSString *strCustID = [NSString stringWithFormat:@"%@%@%@", act_log_custIDfirstNumber, act_log_custIDsecondNumber,act_log_custIDthirdNumber];
    NSString *strUsername = userNameTF.text;
    NSString *strPassword = passwordTF.text;
    NSLog(@"Ang account %@ %@",strUsername,strPassword);
    if([act_log_birthdate isEqualToString:@""]){
        act_log_birthdate = @"1985-11-23";
    }
    
    
    NSString *body =  [NSString stringWithFormat:@"{\"custid\":\"%@\",\"username\":\"%@\",\"password\":\"%@\",\"mobileno\":\"%@\",\"emailadd\":\"%@\",\"fname\":\"%@\",\"mname\":\"%@\",\"lname\":\"%@\",\"gender\":\"%@\",\"bdate\":\"%@\",\"nationality\":\"%@\",\"natureOfWork\":\"%@\",\"provinceCity\":\"%@\",\"permanentAdd\":\"%@\",\"country\":\"%@\",\"zipcode\":\"%@\",\"secquestion1\":\"%@\",\"secanswer1\":\"%@\",\"secquestion2\":\"%@\",\"secanswer2\":\"%@\",\"secquestion3\":\"%@\",\"secanswer3\":\"%@\",\"photo1\":\"%@\",\"photo2\":\"%@\",\"photo3\":\"%@\",\"photo4\":\"%@\",\"version\":\"%.2f\"}",strCustID,strUsername,strPassword,act_log_custIDphoneNumber,act_log_email,act_log_firstName,act_log_middleName,act_log_lastName,act_log_gender,act_log_birthdate,act_log_nationality,act_log_work,act_log_province,act_log_address,act_log_country,act_log_zipcode,act_log_str_secquestion1,act_log_str_secanswer1,act_log_str_secquestion2,act_log_str_secanswer2,act_log_str_secquestion3,act_log_str_secanswer3,act_log_str_photo1,act_log_str_photo2,act_log_str_photo3,act_log_str_photo4,1.3];
    NSLog(@"Hala == %@",body);
    
    NSString *serviceMethods = @"insertMobileAccounts";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", con.NSgetURLService, serviceMethods]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[body UTF8String] length:[body length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}


-(void)connection: (NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Did Receive Response");
    if(connection==resendPin_connection){
        pinData = [[NSMutableData alloc]init];
        NSLog(@"Did Receive Response Pin Data");
    }
    else{
        NSLog(@"Did Receive Response Content Data");
        contentData = [[NSMutableData alloc]init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if(connection==resendPin_connection){
        NSLog(@"Did Receive Data Pin Data");
        [pinData appendData:data];
    }
    else{
        NSLog(@"Did Receive Data Content Data");
        [contentData appendData:data];
    }
    //[contentData appendData:data];
    NSLog(@"didReceiveData");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Bad: %@", [error description]);
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    passwordTF.secureTextEntry = YES;
    retypePasswordTF.secureTextEntry = YES;
    return [string isEqualToString:filtered];
}//remove special Characters

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    //    NSString *loadedContent = [[NSString alloc] initWithData:
    //                               contentData encoding:NSUTF8StringEncoding];
    //
    //    NSData *data = [loadedContent dataUsingEncoding:NSUTF8StringEncoding];
    //    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
    //                                                                 options:kNilOptions
    //                                                                   error:nil];
    //
    //    NSLog(@"%@", jsonResponse);
    
    NSLog(@"connectionDidFinishLoading");
    NSError *myError = nil;
    NSDictionary *res;
    
    
    if (myError == nil) {
        
        
        
        if(connection==resendPin_connection)
        {
            res = [NSJSONSerialization JSONObjectWithData:pinData options:NSJSONReadingMutableLeaves error:&myError];
            NSLog(@"Response sa PIN = %@",res);\
            
            NSDictionary *jsonResult = [res objectForKey:@"ResendPINResult"];
            NSString *strResponseCode = [jsonResult objectForKey:@"respcode"];
            NSString *strResponseMessage = [jsonResult objectForKey:@"respmessage"];
//            NSString *strNoofAttempt = [jsonResult objectForKey:@"noofattempt"];
//            NSString *strWalletNo = [jsonResult objectForKey:@"walletno"];
            NSLog(@"Response %@ || Response Message %@",strResponseCode,strResponseMessage);
            int value = [strResponseCode intValue];
            
            if(value==1){
                UIAlertView *errorMsg = [[UIAlertView alloc] initWithTitle:@"Account Creation Success."
                                                                   message:strResponseMessage
                                                                  delegate:self
                                                         cancelButtonTitle:@"Resend Pin"
                                                         otherButtonTitles:@"Login", nil];
                
                [errorMsg show];
                
            }
            else if(value==2){
                
                UIAlertView *errorMsg = [[UIAlertView alloc] initWithTitle:@"Pin Resend Error."
                                                                   message:strResponseMessage
                                                                  delegate:self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:@"Retry ", nil];
                
                [errorMsg show];
                
                
            }//end if lse if(value==2)
            else if (value==0){
                UIAlertView *errorMsg = [[UIAlertView alloc] initWithTitle:@"Pin Resend Error."
                                                                   message:strResponseMessage
                                                                  delegate:self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:@"Retry ", nil];
                
                [errorMsg show];
            }//end else if (value==0)

        }
        else{
            res = [NSJSONSerialization JSONObjectWithData:contentData options:NSJSONReadingMutableLeaves error:&myError];
            NSDictionary *jsonResult = [res objectForKey:@"insertMobileAccountsResult"];
            NSString *strResponseCode = [jsonResult objectForKey:@"respcode"];
            NSString *strResponseMessage = [jsonResult objectForKey:@"respmessage"];
            NSLog(@"Response %@ || Response Message %@",strResponseCode,strResponseMessage);
            int value = [strResponseCode intValue];
            
            if(value==1){
                [UIAlertView myCostumeAlert:@"Success!" alertMessage:strResponseMessage delegate:nil cancelButton:@"Ok" otherButtons:nil];
                
            }
            else if(value==2){
                
                UIAlertView *errorMsg = [[UIAlertView alloc] initWithTitle:@"Account Creation Error."
                                                                  message:strResponseMessage
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                        otherButtonTitles:@"Retry", nil];
                
                [errorMsg show];

                
            }//end if lse if(value==2)
            else if (value==0){
                UIAlertView *errorMsg = [[UIAlertView alloc] initWithTitle:@"Account Creation Error."
                                                                   message:strResponseMessage
                                                                  delegate:self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:@"Retry", nil];
                
                [errorMsg show];
            }//end else if (value==0)
        }
        
        
        
        
        
        
        
        
    }//end if(myError == nil)
    else{
        [UIAlertView myCostumeAlert:@"Account Creation Error" alertMessage:[myError localizedDescription] delegate:nil cancelButton:@"Ok" otherButtons:nil];
        NSLog(@"Error");
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
