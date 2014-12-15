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
#import "NSMutableArray+PayoutMobile.h"

#import "CryptLib.h"
#import "NSData+Base64.h"

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
    
    
    //Set Background
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        
        if ([UIScreen mainScreen].bounds.size.height != 568) //4 inch
        {            
            [self.scrollView setScrollEnabled:YES];
            self.scrollView.pagingEnabled = YES;
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
    self.txtInsuffi_kptn.delegate = self;
    
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
    
    //Insufficient balance
    if (textField == self.txtInsuffi_kptn) {
        [textField resignFirstResponder];
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
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetLocationService] stringByAppendingString:getReq];
    
    self.responseData = [NSMutableData data];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:srvcURL]];
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
     6 == Payout search
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
        case 6:
            //Payout search
            [self checkKPTNdidfinish];
            break;
        default:
            break;
    }
}
#pragma mark --END Delegate


#pragma mark - SearchKPTNdidFinish
- (void) checkKPTNdidfinish
{
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    //Hide Loader
    [HUD hide:YES];
    [HUD show:NO];
    
    if (myError == nil){
        NSString* _key = [[ServiceConnection alloc] NSGetKey];
        NSData *result  = [NSData dataWithBase64EncodedString:[res valueForKey:@"Encrypted"]];
        NSString *_iv  = [res valueForKey:@"Iv"];
        
        //dec
        NSData* encryptedData = [[StringEncryption alloc] decrypt:result  key:_key iv:_iv];
        result = [NSJSONSerialization JSONObjectWithData:encryptedData options:NSJSONReadingMutableLeaves error:&myError];
        
        NSNumber *respCode = [result valueForKey:@"respcode"];
        NSString *respMesg = [result valueForKey:@"respmessage"];
        
        if ([respCode isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            if ([respMesg isEqualToString:@"Payout Successfully. Thank you."]) {
                [UIAlertView myCostumeAlert:@"Payout Success" alertMessage:respMesg delegate:nil cancelButton:@"Ok" otherButtons:nil];
            } else {
                //Check and searchKPTN
                [self checkReceiver_Result:result];
            }
        }
        else
        {
            [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:respMesg delegate:nil cancelButton:@"Ok" otherButtons:nil];
            [self.txtInsuffi_kptn resignFirstResponder];
            self.txtInsuffi_kptn.text = @"";
        }
    }
}
- (void) checkReceiver_Result:(NSData *)data
{
    //Check if Receiver is Correct.
    NSString *rfname = [data valueForKey:@"rcvrfname"];
    NSString *rlname = [data valueForKey:@"rcvrlname"];
    NSString *prncipal = [data valueForKeyPath:@"principal"];
    NSString *custID = [data valueForKeyPath:@"custId"];
    rfname = [rfname uppercaseString];
    rlname = [rlname uppercaseString];
    if ([[fname uppercaseString] isEqualToString:rfname]
        || [[lname uppercaseString] isEqualToString:rlname]) {
        NSLog(@"TRUE");
        [self payoutMobile_principal:prncipal CustID:custID];
    }
    else
    {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Invalid Receiver. It must be your account name." delegate:nil cancelButton:@"Ok" otherButtons:nil];
        [self.txtInsuffi_kptn resignFirstResponder];
        self.txtInsuffi_kptn.text = @"";
    }
}
- (void) payoutMobile_principal:(NSString*)principal CustID:(NSString*)custid
{
    NSString* kptnNo = self.txtInsuffi_kptn.text;
    NSString* wallet = walletno;
    NSString* princpal = principal;
    NSString* cusID = custid;
    double lng = [self Longtitude];
    double lat = [self Latitude];
    NSString *deviceID = [[DeviceID alloc] NSGetDeviceID];
    NSString* location = [self location];
    
    responseData = [NSMutableData new];
    [[NSMutableData alloc] mobilePayout_kptn:kptnNo WalletNo:wallet Principal:princpal CustID:cusID lng:lng lat:lat DeviceID:deviceID Location:location Delegate:self];
    self.idd = 6;
}


#pragma mark - CheckPINdidfinish
- (void) checkPindidfinish
{
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    if (myError == nil){
        NSString* _key = [[ServiceConnection alloc] NSGetKey];
        NSData *result  = [NSData dataWithBase64EncodedString:[res valueForKey:@"Encrypted"]];
        NSString *_iv  = [res valueForKey:@"Iv"];
        
        //dec
        NSData* encryptedData = [[StringEncryption alloc] decrypt:result  key:_key iv:_iv];
        result = [NSJSONSerialization JSONObjectWithData:encryptedData options:NSJSONReadingMutableLeaves error:&myError];
        
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
        NSString* _key = [[ServiceConnection alloc] NSGetKey];
        NSData *result  = [NSData dataWithBase64EncodedString:[res valueForKey:@"Encrypted"]];
        NSString *_iv  = [res valueForKey:@"Iv"];
        
        //dec
        NSData* encryptedData = [[StringEncryption alloc] decrypt:result  key:_key iv:_iv];
        result = [NSJSONSerialization JSONObjectWithData:encryptedData options:NSJSONReadingMutableLeaves error:&myError];
        
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
    NSString *title = alertView.title;
    
    if ([title isEqualToString:@"Password Reset"]) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            EditPassword *editpassPage = [[EditPassword alloc] initWithNibName:@"EditPassword" bundle:nil];
            self.navigationController.navigationBarHidden = NO;
            [self.navigationController pushViewController:editpassPage animated:YES];
            return;
        }
        else
        {
            EditPasswordPad *editpassPage = [[EditPasswordPad alloc] initWithNibName:@"EditPasswordPad" bundle:nil];
            self.navigationController.navigationBarHidden = NO;
            [self.navigationController pushViewController:editpassPage animated:YES];
            return;
            
        }
    }
    
    
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
        NSString* _key = [[ServiceConnection alloc] NSGetKey];
        NSData *result  = [NSData dataWithBase64EncodedString:[res valueForKey:@"Encrypted"]];
        NSString *_iv  = [res valueForKey:@"Iv"];
        
        //dec
        NSData* encryptedData = [[StringEncryption alloc] decrypt:result  key:_key iv:_iv];
        result = [NSJSONSerialization JSONObjectWithData:encryptedData options:NSJSONReadingMutableLeaves error:&myError];
        
        
        NSNumber *respCode = [result valueForKeyPath:@"respcode"];
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
        NSString* _key = [[ServiceConnection alloc] NSGetKey];
        NSData *result  = [NSData dataWithBase64EncodedString:[res valueForKey:@"Encrypted"]];
        NSString *_iv  = [res valueForKey:@"Iv"];
        
        //dec
        NSData* encryptedData = [[StringEncryption alloc] decrypt:result  key:_key iv:_iv];
        result = [NSJSONSerialization JSONObjectWithData:encryptedData options:NSJSONReadingMutableLeaves error:&myError];
        
        
        NSNumber *respCode = [result valueForKeyPath:@"respcode"];
        NSString *respMesg = [result valueForKeyPath:@"respmessage"];
        
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
            
            //Check if Insufficient balance
            if ([isnewuser isEqualToNumber:[NSNumber numberWithInt:1]]){
                if ([bal isEqualToString:@"0"])
                {
                    [self ifInsufficientBalance];
                    return;
                }
            }
            
            //Check for new USER
            if ([isnewuser isEqualToNumber:[NSNumber numberWithInt:1]]) {
                [self ifUserisNew];return;
            }
            
            //Check if USER Reset password
            if ([isResetpassword isEqualToNumber:[NSNumber numberWithInt:1]]) {
                
                [saveData initSaveData:@"1" forKey:@"isPassReset"];
                [UIAlertView myCostumeAlert:@"Password Reset" alertMessage:@"Your password was autogenerated. \nYou are recommended to change your password." delegate:self cancelButton:nil otherButtons:@"Ok"];
                return;
                
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

- (void) ifInsufficientBalance
{
    self.btnInfo.enabled = NO;
    self.btnLocation.enabled = NO;
    self.btnRate.enabled = NO;
    [UIView popView:self.InsufficientView];
    self.InsufficientView.hidden = NO;
    
    self.InsufficientView.layer.masksToBounds    = NO;
    self.InsufficientView.layer.cornerRadius     = 8;
    self.InsufficientView.layer.shadowOffset     = CGSizeMake(-15, 20);
    self.InsufficientView.layer.shadowRadius     = 5;
    self.InsufficientView.layer.shadowOpacity    = 0.5;
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
    
    double lat = [self Latitude];
    double lng = [self Longtitude];
    NSString *location = [self location];
    
    if ([location isEqualToString:@""] || [location isEqualToString:@"nil"]) {
        location = @"";
    }
    
    NSString *encrptedString = [NSString stringWithFormat:@"{\"username\" : \"%@\",\"password\" : \"%@\",\"version\" : \"%@\",\"latitude\" : \"%f\",\"longitude\" : \"%f\",\"deviceid\" : \"%@\",\"location\" : \"%@\"}",
                              user,
                              pass,
                              version,
                              lat,
                              lng,
                              deviceID,
                              location];
    
   
    
    //enc
    NSString* _key = [[ServiceConnection alloc] NSGetKey];
    NSString* _iv = [[StringEncryption alloc] generateIV];
    NSData* encryptedData = [[StringEncryption alloc] encrypt:[encrptedString dataUsingEncoding:NSUTF8StringEncoding]
                                                          key:_key
                                                           iv:_iv];
    NSLog(@"Encrypted Data : %@", [encryptedData base64EncodingWithLineLength:0]);
    
    //Data to POST
    NSString *post = [NSString stringWithFormat:@"{\"encrypted\" : \"%@\", \"iv\" : \"%@\"}",
                      [encryptedData base64EncodingWithLineLength:0],
                      _iv];
    
    
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
    NSString* _key = [[ServiceConnection alloc] NSGetKey];
    NSString* _iv = [[StringEncryption alloc] generateIV];
    NSString *encrptedString = [NSString stringWithFormat:@"{\"walletno\" : \"%@\",\"newPIN\" : \"%@\"}",
                      walletno,
                      self.ReNewPIN.text];
    
    NSData* encryptedData = [[StringEncryption alloc] encrypt:[encrptedString dataUsingEncoding:NSUTF8StringEncoding]
                                                          key:_key
                                                           iv:_iv];
    NSLog(@"Encrypted Data : %@", [encryptedData base64EncodingWithLineLength:0]);
    
    encrptedString = [NSString stringWithFormat:@"{\"encrypted\" : \"%@\",\"iv\" : \"%@\"}",
            [encryptedData base64EncodingWithLineLength:0],
            _iv];
    
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"UpdatePIN"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    NSData *requestData = [NSData dataWithBytes:[encrptedString UTF8String] length:[encrptedString length]];
    
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
    self.InsufficientView.hidden = YES;
}

- (IBAction)btnNotNow:(id)sender {
    [self onTouch];
}

- (IBAction)btnRePIN:(id)sender {
    //ResendPIN/?walletno={walletno}"
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    
    responseData = [[NSMutableData alloc] init];
    
    
    NSString *postStr = [NSString stringWithFormat:@"{\"walletno\" : \"%@\"}", walletno];
    
    //AES encryption
    NSString* _key = [[ServiceConnection alloc] NSGetKey];
    NSString* _iv = [[StringEncryption alloc] generateIV];
    NSData* encryptedData = [[StringEncryption alloc] encrypt:[postStr dataUsingEncoding:NSUTF8StringEncoding]
                                                          key:_key
                                                           iv:_iv];
    NSLog(@"Encrypted Data : %@", [encryptedData base64EncodingWithLineLength:0]);
    postStr = [NSString stringWithFormat:@"{\"encrypted\" : \"%@\",\"iv\" : \"%@\"}",
               [encryptedData base64EncodingWithLineLength:0],
               _iv];
    
    //Update PIN
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"ResendPIN"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    NSData *requestData = [NSData dataWithBytes:[postStr UTF8String] length:[postStr length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
     [request setHTTPBody:requestData];
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
    
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"checkPin"];
    NSString *encrptedString = [NSString stringWithFormat:@"{\"walletno\" : \"%@\",\"pin\" : \"%@\"}",
                          walletno,
                          self.OldPIN.text];
    
    //enc
    NSString* _key = [[ServiceConnection alloc] NSGetKey];
    NSString* _iv = [[StringEncryption alloc] generateIV];
    NSData* encryptedData = [[StringEncryption alloc] encrypt:[encrptedString dataUsingEncoding:NSUTF8StringEncoding]
                                                          key:_key
                                                           iv:_iv];
    NSLog(@"Encrypted Data : %@", [encryptedData base64EncodingWithLineLength:0]);

    encrptedString = [NSString stringWithFormat:@"{\"encrypted\" : \"%@\",\"iv\" : \"%@\"}",
                     [encryptedData base64EncodingWithLineLength:0],
                     _iv];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    NSData *requestData = [NSData dataWithBytes:[encrptedString UTF8String] length:[encrptedString length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:request delegate:self];
    self.idd = 4;
}

- (IBAction)btnSubmit:(id)sender {
    [self checkPIN];
}
- (IBAction)btnInsuffi_submit:(id)sender {
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    
    [self searchKPTN];
}

#pragma mark - Search KPTN
- (void) searchKPTN
{
     responseData = [[NSMutableData alloc] init];
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"searchKPTN"];
    NSString *encrptedString = [NSString stringWithFormat:@"{\"kptn\" : \"%@\",\"walletno\" : \"%@\"}",
                                self.txtInsuffi_kptn.text,
                                walletno];
    
    //enc
    NSString* _key = [[ServiceConnection alloc] NSGetKey];
    NSString* _iv = [[StringEncryption alloc] generateIV];
    NSData* encryptedData = [[StringEncryption alloc] encrypt:[encrptedString dataUsingEncoding:NSUTF8StringEncoding]
                                                          key:_key
                                                           iv:_iv];
    NSLog(@"Encrypted Data : %@", [encryptedData base64EncodingWithLineLength:0]);
    
    encrptedString = [NSString stringWithFormat:@"{\"encrypted\" : \"%@\",\"iv\" : \"%@\"}",
                      [encryptedData base64EncodingWithLineLength:0],
                      _iv];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    NSData *requestData = [NSData dataWithBytes:[encrptedString UTF8String] length:[encrptedString length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:request delegate:self];
    self.idd = 6;

}

- (IBAction)btnInsuffi_notnow:(id)sender {
    [self onTouch];
    [self.txtInsuffi_kptn resignFirstResponder];
}

@end
