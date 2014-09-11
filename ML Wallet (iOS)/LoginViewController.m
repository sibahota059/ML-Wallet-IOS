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
#import "UIView+MenuAnimationUIVIew.h"
#import "EditPassword.h"
#import "EditPasswordPad.h"

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
    
    NSNumber *isnewuser;
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    [self.loginView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_img.png"]]];
    
    
    
    [self.scrollView setScrollEnabled:YES];
    self.scrollView.pagingEnabled = YES;
    //Set Background
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        
        if ([UIScreen mainScreen].bounds.size.height != 568) //4 inch
        {
            [self.scrollView setContentSize:CGSizeMake(320, 600)];
        }
    }
    
    
    //Set UP Location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    //Handle TxtField
    self.txtUser.delegate = self;
    self.txtPass.delegate = self;
    self.NewPIN.delegate  = self;
    self.OldPIN.delegate  = self;
    self.ReNewPIN.delegate= self;
    
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
    //Login textfield
    if (textField == self.txtUser) {
        [self.txtPass becomeFirstResponder];
        [self.txtUser resignFirstResponder];
    } else {
        [self.txtPass resignFirstResponder];
    }
    
    //Reset PIN new User
    
    if ([isnewuser isEqualToNumber:[NSNumber numberWithInt:1]]) {
    if (textField == self.OldPIN) {
        [self.NewPIN becomeFirstResponder];
        [self.OldPIN resignFirstResponder];
    } else if (textField == self.NewPIN) {
        [self.ReNewPIN becomeFirstResponder];
        [self.NewPIN resignFirstResponder];
    } else {
        [self.ReNewPIN resignFirstResponder];
    }
    }
    return NO;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL isTrueOrNot = YES;
    if (textField == self.OldPIN ||  textField == self.ReNewPIN ||  textField == self.NewPIN) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        isTrueOrNot = (newLength > 4) ? NO : YES;
    }
    return isTrueOrNot;
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
     3 == Resend Email
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
        case 3:
            [self resendEmaildidFinish];
            break;
        case 4:
            [self checkPindidfinish];
            break;
        case 5:
            [self updatePINdidfinish];
            break;
        default:
            break;
    }
}
#pragma mark --END Delegate

#pragma mark - CheckPINdidfinish
- (void) checkPindidfinish
{
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    if (myError == nil){
        NSArray *result = [res valueForKey:@"checkPinResult"];
        
        NSNumber *respCode = [result valueForKey:@"respcode"];
        NSString *respMesg = [result valueForKey:@"respmessage"];
        
        if ([respCode isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            [self updatePIN];
        }
        else
        {
            NSRange rangeValue = [respMesg rangeOfString:@"attempt" options:NSCaseInsensitiveSearch];
            
            if (rangeValue.length <= 0) //false
            {
                [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:respMesg delegate:nil cancelButton:@"Ok" otherButtons:nil];
            }
            else //True
            {
                respMesg = [NSString stringWithFormat:@"%@ \n %@", @"Incorrect PIN" , respMesg];
                NSLog(@"Message %@", respMesg);
                [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:respMesg delegate:nil cancelButton:@"Ok" otherButtons:nil];
            }
            
            
            //Hide Loader
            [HUD hide:YES];
            [HUD show:NO];
        }
    }
    
}

#pragma mark -Update PIN Didfinish
- (void) updatePINdidfinish
{
    //TODo
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    if (myError == nil){
        NSArray *result = [res valueForKey:@"UpdatePINResult"];
        
        NSNumber *respCode = [result valueForKey:@"respcode"];
        NSString *respMesg = [result valueForKey:@"respmessage"];
        
        //Hide Loader
        [HUD hide:YES];
        [HUD show:NO];
        
        
        if ([respCode isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            [UIAlertView myCostumeAlert:@"Update PIN" alertMessage:respMesg delegate:self cancelButton:@"Ok" otherButtons:nil];
        }
        else
        {
            [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:respMesg delegate:nil cancelButton:@"Ok" otherButtons:nil];
        }

    }
}

#pragma mark -UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self btnNotNow:self];
    
    
    //GOTO Menu
        MenuViewController *menuPage = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        [self.navigationController pushViewController:menuPage animated:YES];
        return;
}

#pragma mark -Resend Email didfinish
- (void) resendEmaildidFinish
{
    // convert to JSON
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    if (myError == nil){
        NSArray *result = [res valueForKey:@"ResendPINResult"];
        
        NSNumber *respCode = [result valueForKey:@"respcode"];
        NSString *respMesg = [result valueForKey:@"respmessage"];
        
        //Hide Loader
        [HUD hide:YES];
        [HUD show:NO];
        
        
        if ([respCode isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            [UIAlertView myCostumeAlert:@"Resend Email" alertMessage:respMesg delegate:nil cancelButton:@"Ok" otherButtons:nil];
        }
        else
        {
            [UIAlertView myCostumeAlert:@"Resend Email" alertMessage:respMesg delegate:nil cancelButton:@"Ok" otherButtons:nil];
        }
    }
    
}


#pragma mark -POST Login
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
            isnewuser   = [result valueForKeyPath:@"isnewuser"];
            
            NSString *bal = [NSString stringWithFormat:@"%@", balance];
            NSNumber *isResetpassword = [result valueForKey:@"isresetpass"];
            
            //Saving Data Plist
            SaveWalletData *saveData = [SaveWalletData new];
            [saveData initSaveData:walletno forKey:@"walletno"];
            [saveData initSaveData:lname forKey:@"lname"];
            [saveData initSaveData:fname forKey:@"fname"];
            [saveData initSaveData:photo forKey:@"photo"];
            [saveData initSaveData:bal forKey:@"balance"];
            [saveData initSaveData:mname forKey:@"mname"];
            [saveData initSaveData:pass forKey:@"password"];
            [saveData initSaveData:user forKey:@"username"];
            if ([self.location isEqualToString:@""] || self.location.length == 0 || self.location == nil) {
                self.location = @"";
            }
            [saveData initSaveData:self.location forKey:@"address"];
            
            //Check for new USER
            if ([isnewuser isEqualToNumber:[NSNumber numberWithInt:1]]) {
                [self ifUserisNew];return;
            }
            
            //Check if USER Reset password
            if ([isResetpassword isEqualToNumber:[NSNumber numberWithInt:1]]) {
                //TODO
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                {
                    EditPassword *editpassPage = [[EditPassword alloc] initWithNibName:@"EditPassword" bundle:nil];
                    [saveData initSaveData:@"1" forKey:@"isPassReset"];
                    self.navigationController.navigationBarHidden = NO;
                    [self.navigationController pushViewController:editpassPage animated:YES];
                    return;
                }
                else
                {
                    EditPasswordPad *editpassPage = [[EditPasswordPad alloc] initWithNibName:@"EditPasswordPad" bundle:nil];
                    [saveData initSaveData:@"1" forKey:@"isPassReset"];
                    self.navigationController.navigationBarHidden = NO;
                    [self.navigationController pushViewController:editpassPage animated:YES];
                    return;
   
                }
                
            }
            
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

- (void) ifUserisNew
{
    self.btnInfo.enabled = NO;
    self.btnLocation.enabled = NO;
    self.btnRate.enabled = NO;
    [UIView popView:self.NewPINView];
    self.NewPINView.hidden = NO;
    
    self.NewPINView.layer.masksToBounds    = NO;
    self.NewPINView.layer.cornerRadius     = 8;
    self.NewPINView.layer.shadowOffset     = CGSizeMake(-15, 20);
    self.NewPINView.layer.shadowRadius     = 5;
    self.NewPINView.layer.shadowOpacity    = 0.5;
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

#pragma mark -PUT Update PIn
- (void) updatePIN
{
    NSString *post = [NSString stringWithFormat:@"{\"walletno\" : \"%@\",\"newPIN\" : \"%@\"}",
                      walletno,
                      self.ReNewPIN.text];
    
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"/UpdatePIN"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    NSData *requestData = [NSData dataWithBytes:[post UTF8String] length:[post length]];
    
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:request delegate:self];
  
    self.idd = 5;
}

- (void)onTouch
{
    self.btnRate.enabled = YES;
    self.btnLocation.enabled =YES;
    self.btnInfo.enabled =YES;
    
    self.NewPINView.hidden =YES;
}

- (IBAction)btnNotNow:(id)sender {
    [self onTouch];
}

//TODO
- (IBAction)btnRePIN:(id)sender {
    //ResendPIN/?walletno={walletno}"
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    
    responseData = [[NSMutableData alloc] init];
    
    
    //Update PIN
    NSString *srvcURL1 = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"ResendPIN/?walletno="];
    NSString *srvcURL = [NSString stringWithFormat:@"%@%@", srvcURL1, walletno];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [NSURLConnection connectionWithRequest:request delegate:self];
    self.idd = 3;
}

- (void) checkPIN
{
    
    if ([self.OldPIN.text isEqualToString:@""])
    {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Type Activition PIN" delegate:nil cancelButton:@"Ok" otherButtons:nil];
        return;
    }
    else if ([self.NewPIN.text isEqualToString:@""]) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Type your new PIN" delegate:nil cancelButton:@"Ok" otherButtons:nil];
        return;
    }
    else
        if (![self.ReNewPIN.text isEqualToString:self.NewPIN.text]) {
            [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"PIN not match" delegate:nil cancelButton:@"Ok" otherButtons:nil];
            
            self.ReNewPIN.text  = @"";
            self.NewPIN.text    = @"";
            return;
        }

    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    responseData = [[NSMutableData alloc] init];
    
    NSString *srvcURL1 = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"checkPin/?"];
    NSString *srvcURL = [NSString stringWithFormat:@"%@walletno=%@&pin=%@", srvcURL1, walletno, self.OldPIN.text];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [NSURLConnection connectionWithRequest:request delegate:self];
    self.idd = 4;
}

- (IBAction)btnSubmit:(id)sender {
    [self checkPIN];
}
@end
