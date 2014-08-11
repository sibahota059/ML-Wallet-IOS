//
//  LoginViewController.m
//  ML Wallet (iOS)
//
//  Created by ml on 2/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "LoginViewController.h"
#import "MenuViewController.h"
#import "InfoViewController.h"
#import "EnterCustomerID.h"
#import "UIAlertView+alertMe.h"
#import "ServiceConnection.h"
#import "DeviceID.h"
#import "UIAlertView+WaitAlertView.h"
#import "MBProgressHUD.h"
#import "UITextfieldAnimate.h"
#import "MLUI.h"
#import "MapViewController.h"
#import "MLRatesTableViewController.h"
#import "ResetPassViewController.h"

#import "SaveWalletData.h"

#import <CoreLocation/CoreLocation.h>

@interface LoginViewController ()


@end

@implementation LoginViewController
{
    
    //Location
    CLLocationManager *locationManager;
    NSString *user;
    NSString *pass;
    
    NSString *walletno;
    NSString *fname;
    NSString *lname;
    NSString *photo;
    NSString *balance;
    NSString *mname;
    
    UITextfieldAnimate *textAnimate;
}

@synthesize responseData;
@synthesize idd;
@synthesize navigationBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//Harry added
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil navigationHidden:(BOOL) navigationHidden
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        navigationBar = navigationHidden;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MLUI *navigationUI = [MLUI new];
    [navigationUI navigationAppearance];
    
    self.navigationController.navigationBarHidden = navigationBar;
    
    //WaitScreen
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
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
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground4.png"]]];
    }
    
    [self.loginView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_img.png"]]];
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320, 600)];
    
    
    //Set UP Location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    //Handle TxtField
    self.txtUser.delegate = self;
    self.txtPass.delegate = self;
    textAnimate = [UITextfieldAnimate new];

}
#pragma mark - UITextField Delegate
- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    [textAnimate animateTextField:textField up:YES SelfView:self.view];
}
- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [textAnimate animateTextField:textField up:NO SelfView:self.view];
    [self.view endEditing:YES];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtUser) {
        [self.txtPass becomeFirstResponder];
        [self.txtUser resignFirstResponder];
    } else {
        [self.txtPass resignFirstResponder];
    }
    return NO;
}

#pragma mark - Shake Animation
-(void)shakeView {
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.1];
    [shake setRepeatCount:2];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:CGPointMake(self.loginView.center.x - 5,self.loginView.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:CGPointMake(self.loginView.center.x + 5, self.loginView.center.y)]];
    [self.loginView.layer addAnimation:shake forKey:@"position"];
}

#pragma mark - Button INFO -action
- (IBAction)btnInfo:(id)sender {
    
    InfoViewController *gotoInfo = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    [self.navigationController pushViewController:gotoInfo animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnRegister:(id)sender {
    
    
    EnterCustomerID *enterCustomer = [[EnterCustomerID alloc] initWithNibName:@"EnterCustomerID" bundle:nil];
    
    
    [self.navigationController pushViewController:enterCustomer animated:YES];
    self.navigationController.navigationBarHidden = NO;


}

#pragma mark **Button Logint
- (IBAction)btnLogin:(id)sender
{
    //Check first if User and Pass NULL
    user = self.txtUser.text;
    pass = self.txtPass.text;
    
    if ( [user isEqualToString:@""] )
    {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Type your UserID" delegate:nil cancelButton:@"Ok" otherButtons:nil];
        [self shakeView];
        return;
    }
    else if ( [pass isEqualToString:@""] )
    {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Type your Password" delegate:nil cancelButton:@"Ok" otherButtons:nil];
        [self shakeView];
        return;
    }
    
    
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    
    double latitude = [self Latitude];
    double longtitude = [self Longtitude];
    NSLog(@"Lat : %f and Lng : %f", [self Latitude], [self Longtitude]);
    
    //Get Location JSON
    NSURLConnection *con;
    NSString *getReq = [NSString stringWithFormat:@"latlng=%f,%f&sensor=true", latitude, longtitude];
    
    
    NSLog(@"viewdidload");
    self.responseData = [NSMutableData data];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[[[ServiceConnection alloc] NSgetLocationService] stringByAppendingString:getReq]]];
    [request setHTTPMethod:@"GET"];
    con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.idd = 1;

}

- (IBAction)btnLocator:(id)sender {
    MapViewController *detailViewController = [[MapViewController alloc]
                                               initWithNibName:@"MapViewController"
                                               bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


#pragma mark - Button Rates
- (IBAction)btnRates:(id)sender {
    
    MLRatesTableViewController *rates = [[MLRatesTableViewController alloc] initWithNibName:@"MLRatesTableViewController" bundle:nil];
    
    rates.indicator = @"login";
    
    [self.navigationController pushViewController:rates animated:YES];
    self.navigationController.navigationBarHidden = NO;

}

#pragma mark - ResetPIN and ForgotPass
- (IBAction)btnResetPIN:(id)sender {
    [UIAlertView myCostumeAlert:@"Contact MLhuillier Support" alertMessage:@"To reset your PIN, you must call our 24/7 Mlhuillier Support. \n\nCall:(032)232-1036 or 09479991948. \nSMS:09479991948 or 09059990533\n\nEmail: mis.helpdesk@mlhuillier1.com or Visit to your nearest branch" delegate:nil cancelButton:@"Ok" otherButtons:nil];
}

- (IBAction)btnForgotPassword:(id)sender {
    ResetPassViewController *resetPage = [[ResetPassViewController alloc]
                                          initWithNibName:@"ResetPassViewController"
                                          bundle:nil];
    [self.navigationController pushViewController:resetPage animated:YES];
}

#pragma mark --Location
//get Longtitude
- (double) Longtitude
{
    return locationManager.location.coordinate.longitude;
}
- (double) Latitude
{
    return locationManager.location.coordinate.latitude;
}
#pragma mark --END Location


#pragma mark --NSURLConnection Delegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIAlertView myCostumeAlert:@"Connection Error" alertMessage:[error localizedDescription] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    
    self.txtUser.text = @"";
    self.txtPass.text = @"";
    [HUD hide:YES];
    [HUD show:NO];
}
#pragma -ByPass Certificate
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.txtUser.text = @"";
    self.txtPass.text = @"";
    /*
     1 == get Location
     2 == get Login Post Method
     */
    switch (self.idd) {
        case 1:
            NSLog(@"getting location");
            [self IDDLocation];
            [self Req_Login];
            break;
        case 2:
            [self login];
            break;
            
        default:
            break;
    }
}
#pragma mark --END Delegate

#pragma mark POST Login
- (void) login
{
    // convert to JSON
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    if (myError == nil){
        NSArray *result = [res valueForKey:@"logInResult"];
        
        NSNumber *respCode = [result valueForKey:@"respcode"];
        NSString *respMesg = [result valueForKey:@"respmessage"];
        
        //Hide Loader
        [HUD hide:YES];
        [HUD show:NO];
        
        if ([respCode isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            
            walletno    = [result valueForKeyPath:@"walletno"];
            fname       = [result valueForKeyPath:@"fname"];
            lname       = [result valueForKeyPath:@"lname"];
            photo       = [result valueForKeyPath:@"photo"];
            balance     = [result valueForKeyPath:@"balance"];
            mname       = [result valueForKeyPath:@"mname"];
            
            
            NSString *bal = [NSString stringWithFormat:@"%@", balance];
            
            //Saving Data Plist
            SaveWalletData *saveData = [SaveWalletData new];
            [saveData initSaveData:walletno forKey:@"walletno"];
            [saveData initSaveData:lname forKey:@"lname"];
            [saveData initSaveData:fname forKey:@"fname"];
            [saveData initSaveData:photo forKey:@"photo"];
            [saveData initSaveData:bal forKey:@"balance"];
            [saveData initSaveData:mname forKey:@"mname"];
            [saveData initSaveData:pass forKey:@"password"];
            if ([self.location isEqualToString:@""] || self.location.length == 0 || self.location == nil) {
                self.location = @"";
            }
            [saveData initSaveData:self.location forKey:@"address"];
            
            //GOTO Menu
            MenuViewController *menuPage = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
            [self.navigationController pushViewController:menuPage animated:YES];
            return;
        }
        else
        {
            NSRange strRange = [respMesg
                                rangeOfString:@"MySql.Data.MySqlClient.MySqlException"
                                options:NSCaseInsensitiveSearch];
            
            if (strRange.length > 1)
            {
                respMesg = @"Service is temporary unavailable";
            }
            
            //Show Error
            [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:respMesg delegate:nil cancelButton:@"Ok" otherButtons:nil];
            self.txtPass.text = @"";
            self.txtUser.text = @"";
            
            [self shakeView];
            return;
        }
        
        
    } else {
        //Show if Error
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:[myError localizedDescription] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark GetLocation Address
- (void) IDDLocation
{
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    for(id key in res) {
        
        id value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
    }
    
    // extract specific value...
    NSArray *results = [res objectForKey:@"results"];
    
    int i = 0;
    for (NSDictionary *result in results) {
        if (i==0)
        {
            self.location =[result objectForKey:@"formatted_address"];
            self.location = [result objectForKey:@"formatted_address"];
            NSLog(@"formatted_address: %@", self.location);
            return;
        }
        i++;
    }
  
}

- (void) Req_Login
{
    
    
    //if all OK... then procced
    NSString *deviceID = [[DeviceID alloc] NSGetDeviceID];
    NSString *version =[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    
    NSString *post = [NSString stringWithFormat:@"{\"username\" : \"%@\",\"password\" : \"%@\",\"version\" : \"%@\",\"latitude\" : \"%f\",\"longitude\" : \"%f\",\"deviceid\" : \"%@\",\"location\" : \"%@\"}",
                      user,
                      pass,
                      version,
                      [self Latitude],
                      [self Longtitude],
                      deviceID,
                      self.location];

    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"login"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    NSData *requestData = [NSData dataWithBytes:[post UTF8String] length:[post length]];
    
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    self.idd = 2;

}


@end
