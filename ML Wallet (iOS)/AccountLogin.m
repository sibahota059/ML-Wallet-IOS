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
@property (nonatomic, strong) NSMutableData *responseData;
@end


@implementation AccountLogin{
 MBProgressHUD *HUD;
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
/*
    UIView *submitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [submitButton setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(nextPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [submitView addSubview:submitButton];
    
    UIBarButtonItem *submit = [[UIBarButtonItem alloc] initWithCustomView:submitView];
    [self.navigationItem setRightBarButtonItem:submit];
*/
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
        [self createAccount];
    }
    else{
        NSLog(@"Success");
       // [self insertMobileAcc];
        //[self createAccount];
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
    
    //    [UIView animateWithDuration:0.5
    //                          delay:0.0
    //                        options:UIViewAnimationOptionCurveEaseIn
    //                     animations:^{self.view.frame = CGRectMake(0, 20, 320, 1000); }
    //                     completion:^(BOOL finished){}];
    [userNameTF resignFirstResponder];
    [passwordTF resignFirstResponder];
    [retypePasswordTF resignFirstResponder];
    
    return NO;
}
-(void)insertMobileAcc{
    self.responseData = [NSMutableData data];
    ServiceConnection *str = [ServiceConnection new];
    //#define URLCustomerIDService @"SearchCustId/?custid={%@}&mobileno={%@}"
    double walletVersion = 1.2;
    NSString *customerID = [NSString stringWithFormat:@"%@%@%@",act_log_custIDfirstNumber,act_log_custIDsecondNumber,act_log_custIDthirdNumber];
 //   NSString *body =  [NSString stringWithFormat:@"custid=%@&username=%@&password=%@&mobileno=%@&emailadd=%@&fname=%@&mname=%@&lname=%@&gender=%@&bdate=%@&nationality=%@&natureOfWork=%@&provinceCity=%@&permanentAdd=%@&country=%@&zipcode=%@&secquestion1=%@&secanswer1=%@&secquestion2=%@&secanswer2=%@&secquestion3=%@&secanswer3=%@&photo1=%@&photo2=%@&photo3=%@&photo4=%@&version=%f",customerID,userNameTF.text,passwordTF.text,act_log_number,act_log_email,act_log_firstName,act_log_middleName,act_log_lastName,act_log_gender,act_log_birthdate,act_log_nationality,act_log_work,act_log_province,act_log_address,act_log_country,act_log_zipcode,act_log_str_secquestion1,act_log_str_secanswer1,act_log_str_secquestion2,act_log_str_secanswer2,act_log_str_secquestion3,act_log_str_secanswer3,act_log_str_photo1,act_log_str_photo2,act_log_str_photo3,act_log_str_photo4,walletVersion];
 NSString *body =  [NSString stringWithFormat:@"custid=%@&username=%@&password=%@&mobileno=%@&emailadd=%@&fname=%@&mname=%@&lname=%@&gender=%@&bdate=%@&nationality=%@&natureOfWork=%@&provinceCity=%@&permanentAdd=%@&country=%@&zipcode=%@&secquestion1=%@&secanswer1=%@&secquestion2=%@&secanswer2=%@&secquestion3=%@&secanswer3=%@&photo1=%@&photo2=%@&photo3=%@&photo4=%@&version=%f",customerID,userNameTF.text,passwordTF.text,act_log_number,act_log_email,act_log_firstName,act_log_middleName,act_log_lastName,act_log_gender,act_log_birthdate,act_log_nationality,act_log_work,act_log_province,act_log_address,act_log_country,act_log_zipcode,act_log_str_secquestion1,act_log_str_secanswer1,act_log_str_secquestion2,act_log_str_secanswer2,act_log_str_secquestion3,act_log_str_secanswer3,act_log_str_photo1,act_log_str_photo2,act_log_str_photo3,act_log_str_photo4,walletVersion];
    NSString *url = [NSString stringWithFormat:@"%@", [str NSCreateAccountService]];
    
    NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSLog(@"URL - %@", encodedUrl);              // Checking the url
    
    NSMutableURLRequest *theRequest= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl]
                                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:10.0];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
    [theConnection start];
}
-(void)createAccount{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    //Get Branch Coordinate
    self.responseData = [NSMutableData data];
    ServiceConnection *str = [ServiceConnection new];
    double walletVersion = 1.2;
//    NSString *customerID = [NSString stringWithFormat:@"%@%@%@",act_log_custIDfirstNumber,act_log_custIDsecondNumber,act_log_custIDthirdNumber];
    NSString *url = [NSString stringWithFormat:@"%@", [str NSCreateAccountService]];
    NSString *body =  [NSString stringWithFormat:@"custid=%@&username=%@&password=%@&mobileno=%@&emailadd=%@&fname=%@&mname=%@&lname=%@&gender=%@&bdate=%@&nationality=%@&natureOfWork=%@&provinceCity=%@&permanentAdd=%@&country=%@&zipcode=%@&secquestion1=%@&secanswer1=%@&secquestion2=%@&secanswer2=%@&secquestion3=%@&secanswer3=%@&photo1=%@&photo2=%@&photo3=%@&photo4=%@&version=%f",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",@"haha",walletVersion];
    
//    NSDictionary *value1 = @{@"custid" : @"customerID",
//                             @"username"  : @"haha",
//                             @"password"  : @"male",
//                             @"mobileno"  : @"male",
//                             @"emailadd"  : @"male",
//                             @"fname"  : @"male",
//                             @"mname"  : @"male",
//                             @"lname"  : @"male",
//                             @"gender"  : @"male",
//                             @"bdate"  : @"male",
//                             @"nationality"  : @"male",
//                             @"natureOfWork"  : @"male",
//                             @"provinceCity"  : @"male",
//                             @"permanentAdd"  : @"male",
//                             @"country"  : @"male",
//                             @"zipcode"  : @"male",
//                             @"secquestion1"  : @"male",
//                             @"secanswer1"  : @"male",
//                             @"secquestion2"  : @"male",
//                             @"secanswer2"  : @"male",
//                             @"secquestion3"  : @"male",
//                             @"secanswer3"  : @"male",
//                             @"photo1"  : @"male",
//                             @"photo2"  : @"male",
//                             @"photo3"  : @"male",
//                             @"photo4"  : @"male",
//                             @"version"  : @"1.2"};
    
    
//    NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
//                         @"custid",@"customerID",
//                         @"username",@"haha",
//                         @"password",@"male",
//                         @"mobileno",@"male",
//                         @"emailadd",@"male",
//                         @"fname",@"male",
//                         @"mname",@"male",
//                         @"lname",@"male",
//                         @"gender"  , @"male",
//                         @"bdate"  , @"male",
//                         @"nationality"  , @"male",
//                         @"natureOfWork" , @"male",
//                         @"provinceCity"  , @"male",
//                         @"permanentAdd"   @"male",
//                         @"country"  , @"male",
//                         @"zipcode"  , @"male",
//                         @"secquestion1"  , @"male",
//                         @"secanswer1"  , @"male",
//                         @"secquestion2"  , @"male",
//                         @"secanswer2"  , @"male",
//                         @"secquestion3"  , @"male",
//                         @"secanswer3"  , @"male",
//                         @"photo1"  , @"male",
//                         @"photo2"  , @"male",
//                         @"photo3"  , @"male",
//                         @"photo4"  , @"male",
//                         @"version"  , @"1.2",
//                         nil];
    NSError *jsonError;
//    NSData *bodyz = [NSJSONSerialization dataWithJSONObject:value1 options:0 error:&jsonError];

    
    
    NSData *postData = [body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
 //   NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSLog(@"URL - %@", url);              // Checking the url
    NSLog(@"Aaawaa ni!!!-%@",body);

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
cachePolicy:NSURLRequestUseProtocolCachePolicy
   timeoutInterval:10.0];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [urlRequest setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    


    
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl]
//                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                          timeoutInterval:10.0];
    //sets the receiver’s timeout interval, in seconds
    
    
   // [urlRequest setHTTPMethod:@"POST"];
   // [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];

   // [urlRequest setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
    //sets the request body of the receiver to the specified data.
    //[urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
//    [urlRequest setHTTPBody:bodyz];
    
    NSURLResponse *response;
    NSData *POSTReply = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:nil];
    NSString *theReply = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSASCIIStringEncoding];
    NSLog(@"Reply: %@", theReply);
    
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //Loads the data for a URL request and executes a handler block on an
    //operation queue when the request completes or fails.
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
             //process the JSON response
             //use the main queue so that we can interact with the screen
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self parseResponse:data];
             });
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];


}

- (void) parseResponse:(NSData *) data {
    
    NSString *myData = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    
    NSLog(@"JSON data = %@", myData);
    [HUD hide:YES];
    [HUD show:NO];
    NSError *error = nil;
    //parsing the JSON response
    id jsonObject = [NSJSONSerialization
                     JSONObjectWithData:data
                     options:NSJSONReadingAllowFragments
                     error:&error];
    if (jsonObject != nil && error == nil){
        NSLog(@"Successfully deserialized...");
        
        //check if the country code was valid
        NSNumber *success = [jsonObject objectForKey:@"success"];
        if([success boolValue] == YES){
            NSLog(@"Success");
        }
        else {
            NSLog(@"Failed");
        }
        
    }
    
}




//#pragma mark - NSURLConnection Delegate
//- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
//    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
//}
//- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
//    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
//}
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    NSLog(@"didReceiveResponse");
//    [self.responseData setLength:0];
//}
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [self.responseData appendData:data];
//}
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    NSLog(@"didFailWithError : %@",error);
//    
//    
//}
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSLog(@"connectionDidFinishLoading");
//    // convert to JSON
//    NSError *myError = nil;
//    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
//    NSLog(@"Service Response %@",res);
//    if (myError == nil) {
//        NSLog(@"Account Service No error");
//    }
//    else{
//        NSLog(@"Account Service Error == %@",myError.localizedDescription);
//    }
//    
//    
//    
//    
//    
//}//end connectionDidFinishLoading
//
//
//

- (void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
             forAuthenticationChallenge:challenge];
    }
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void) connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    if([[protectionSpace authenticationMethod] isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
    
    }
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end
