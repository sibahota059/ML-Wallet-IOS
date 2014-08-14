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
@interface AccountLogin ()
//@property (nonatomic, strong) NSMutableData *responseData;
@end


@implementation AccountLogin{
    MBProgressHUD *HUD;
    NSMutableData *contentData;
    NSURLConnection *conn;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) createLoginAccount{
    if ( IDIOM == IPAD ) {
        NSLog(@"IPAD NI");
        
        ProfileHeader *loginHeader = [[ProfileHeader alloc] initWithValue:@" Create Login Account" x:5 y:-10 width:180];
        
        // ProfileOutline *loginOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
        UIView* loginOutline = [[UIView alloc] initWithFrame:CGRectMake(10,screenHeight*.05,screenWidth,screenHeight)];
        
        userNameTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(10, 30, 400, 40) word:@"Username/Login ID"];
        userNameTF.layer.cornerRadius=8.0f;
        userNameTF.layer.masksToBounds=YES;
        userNameTF.layer.borderColor=[[UIColor redColor]CGColor];
        userNameTF.layer.borderWidth= 1.0f;
        float userNameTF_Co = (screenWidth - 400)/2;
        [userNameTF setFrame:CGRectMake(userNameTF_Co, 30, 400, 40)];
        
        passwordTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(10, 100, 400, 40) word:@"Password"];
        passwordTF.layer.cornerRadius=8.0f;
        passwordTF.layer.masksToBounds=YES;
        passwordTF.layer.borderColor=[[UIColor redColor]CGColor];
        passwordTF.layer.borderWidth= 1.0f;
        float passwordTF_Co = (screenWidth - 400)/2;
        [passwordTF setFrame:CGRectMake(passwordTF_Co, 100, 400, 40)];
        
        retypePasswordTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(10, 170, 400, 40) word:@"Retype Password"];
        retypePasswordTF.layer.cornerRadius=8.0f;
        retypePasswordTF.layer.masksToBounds=YES;
        retypePasswordTF.layer.borderColor=[[UIColor redColor]CGColor];
        retypePasswordTF.layer.borderWidth= 1.0f;
        float retypePasswordTF_Co = (screenWidth - 400)/2;
        [retypePasswordTF setFrame:CGRectMake(retypePasswordTF_Co, 170, 400, 40)];
        
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
        passwordTF.secureTextEntry = YES;
        
        retypePasswordTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(10, 130, 280, 30) word:@"Retype Password"];
        retypePasswordTF.layer.cornerRadius=8.0f;
        retypePasswordTF.layer.masksToBounds=YES;
        retypePasswordTF.layer.borderColor=[[UIColor redColor]CGColor];
        retypePasswordTF.layer.borderWidth= 1.0f;
        retypePasswordTF.secureTextEntry = YES;
        
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
//        [UIAlertView myCostumeAlert:@"Error!" alertMessage:@"Fill All Fields." delegate:nil cancelButton:@"Ok" otherButtons:nil];
[self createAccount];
    }
    else{
        NSLog(@"Success");
        [self createAccount];
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
    contentData = [NSMutableData data];
    con         = [ServiceConnection new];
    
    NSString *body =  [NSString stringWithFormat:@"{\"custid\":\"%@\",\"username\":\"%@\",\"password\":\"%@\",\"mobileno\":\"%@\",\"emailadd\":\"%@\",\"fname\":\"%@\",\"mname\":\"%@\",\"lname\":\"%@\",\"gender\":\"%@\",\"bdate\":\"%@\",\"nationality\":\"%@\",\"natureOfWork\":\"%@\",\"provinceCity\":\"%@\",\"permanentAdd\":\"%@\",\"country\":\"%@\",\"zipcode\":\"%@\",\"secquestion1\":\"%@\",\"secanswer1\":\"%@\",\"secquestion2\":\"%@\",\"secanswer2\":\"%@\",\"secquestion3\":\"%@\",\"secanswer3\":\"%@\",\"photo1\":\"%@\",\"photo2\":\"%@\",\"photo3\":\"%@\",\"photo4\":\"%@\",\"version\":\"%.2f\"}",@"13110003419030",@"uzernem1",@"pasword1",@"09479992265",@"alexhann@hotmail.com",@"ALEX",@"",@"HANNUM",@"MALE",@"1985-11-23",@"",@"",@"",@"",@"",@"",@"What's your childhood nickname?",@"harry",@"What is your favorite TV program?",@"naruto",@"What was your dream job?",@"programmer",@"",@"",@"",@"",1.3];
    
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


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [contentData appendData:data];
    NSLog(@"didReceiveData");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Bad: %@", [error description]);

}

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
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:contentData options:NSJSONReadingMutableLeaves error:&myError];
    if (myError == nil) {
        
        NSDictionary *resultCoordinates = [res objectForKey:@"insertMobileAccountsResult"];
        NSString *strResponseCode = [resultCoordinates objectForKey:@"respcode"];
        NSString *strResponseMessage = [resultCoordinates objectForKey:@"respmessage"];
        NSLog(@"Response %@",strResponseCode);
        int value = [strResponseCode intValue];
        if(value==1){
        [UIAlertView myCostumeAlert:@"Account Creation Error" alertMessage:strResponseMessage delegate:nil cancelButton:@"Ok" otherButtons:nil];
        
        }
        else if(value==2){
        [UIAlertView myCostumeAlert:@"Account Creation Error" alertMessage:strResponseMessage delegate:nil cancelButton:@"Ok" otherButtons:nil];
        }
        else if (value==0){
            [UIAlertView myCostumeAlert:@"Account Creation Error" alertMessage:strResponseMessage delegate:nil cancelButton:@"Ok" otherButtons:nil];
        }
    }
    else{
        NSLog(@"Error");
    }
 
    
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
