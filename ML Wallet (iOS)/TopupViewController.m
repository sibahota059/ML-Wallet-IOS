//
//  TopupViewController.m
//  ML Wallet
//
//  Created by ml on 2/28/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "TopupViewController.h"
#import "UIAlertView+alertMe.h"
#import "MBProgressHUD.h"
#import "ServiceConnection.h"
#import "DeviceID.h"
#import "LoginViewController.h"
#import "UITextfieldAnimate.h"
#import "NSDictionary+LoadWalletData.h"
#import "SaveWalletData.h"
#import "NSData+Base64.h"
#import "CryptLib.h"

#import <CoreLocation/CoreLocation.h>

@interface TopupViewController ()

@end

@implementation TopupViewController
{    
    CLLocationManager *locationManager;
    UITextfieldAnimate *textAnimate;
    NSString *walletno;
    NSString *userFname;
    NSString *userLname;
    NSString *userLocat;
}

@synthesize responseData;
@synthesize idd;
@synthesize strKPTN;

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
    
    //Wallet nO
    NSDictionary *dic = [NSDictionary initRead_LoadWallet_Data];
    walletno    = [dic objectForKey:@"walletno"];
    userFname   = [dic objectForKey:@"fname"];
    userLname   = [dic objectForKey:@"lname"];
    userLocat   = [dic objectForKey:@"address"];
    
    [self navigationView];
    
    //Set Background
    [self.view setBackgroundColor:[UIColor whiteColor]];

    
    //ScrollView
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320, 300)];
    
    //WaitScreen
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
    //Set UP Location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    //Animate when Fucos :D
    self.txtKPTN.delegate = self;
    textAnimate = [UITextfieldAnimate new];
}

#pragma mark - Animate Textfield
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
    [textField resignFirstResponder];
    return NO;
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

- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma Start #Navigation Items
- (void)navigationView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"Topup";
    
    UIBarButtonItem *btnHome = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home.png"]
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(gotoHome)];
    
    self.navigationItem.leftBarButtonItem = btnHome;
    
    //Set Background
    if ([UIScreen mainScreen].bounds.size.height >= 568) //4 inch
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground2.png"]]];
    }
    else //4 inc below
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground3.png"]]];
    }
}


#pragma Start goto Home View
- (void)gotoHome
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnSubmit:(id)sender {
    [self.view endEditing:YES];
    
    strKPTN = self.txtKPTN.text;
    
    if ([strKPTN isEqualToString:@""])
    {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Type your KPTN" delegate:nil cancelButton:@"Ok" otherButtons:nil];
        return;
    }
    NSArray *componentsSeparatedByWhiteSpace = [strKPTN componentsSeparatedByString:@" "];
    if ([componentsSeparatedByWhiteSpace count] > 1) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"KPTN must have no space" delegate:nil cancelButton:@"Ok" otherButtons:nil];
        self.txtKPTN.text = @"";
        return;
    }
    
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES navigatorItem:self.navigationItem];
    
    NSString* _key = [[ServiceConnection alloc] NSGetKey];
    NSString* _iv = [[StringEncryption alloc] generateIV];
    NSString *post = [NSString stringWithFormat:@"{\"kptn\" : \"%@\", \"walletno\" : \"%@\"}", strKPTN, walletno];
    NSData* encryptedData = [[StringEncryption alloc]
                             encrypt:[post dataUsingEncoding:NSUTF8StringEncoding]
                             key:_key
                             iv:_iv];
    NSLog(@"Encrypted Data : %@", [encryptedData base64EncodingWithLineLength:0]);
    
    //Data to POST
    NSString *postData = [NSString stringWithFormat:@"{\"encrypted\" : \"%@\", \"iv\" : \"%@\"}",
                          [encryptedData base64EncodingWithLineLength:0],
                          _iv];
   
    
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"searchKPTN"];
    
    self.responseData = [NSMutableData data];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    NSData *requestData = [NSData dataWithBytes:[postData UTF8String] length:[postData length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:request delegate:self];
    self.idd = 1;
}



#pragma mark - NSURLConnection Delegate
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
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:[error localizedDescription] delegate:self cancelButton:@"Cancel" otherButtons:@"Retry"];
    //Hide Loader
    [HUD hide:YES];
    [HUD show:NO];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    // convert to JSON
    if (self.responseData == nil) {
        [UIAlertView myCostumeAlert:@"Exception Error" alertMessage:@"No Data found" delegate:nil cancelButton:@"Ok" otherButtons:nil];
        
        //Hide Loader
        [HUD hide:YES];
        [HUD show:NO];
        return;
    }
    
    
    
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
        

//    if (myError == nil) {
//        NSArray *result;
//        if (self.idd == 1)
//        {
//            result = [res valueForKey:@"searchKPTNResult"];
//        }else{
//            result = [res valueForKey:@"payoutMobileResult"];
//        }
//        
//        NSNumber *respCode = [result valueForKey:@"respcode"];
//        NSString *respMesg = [result valueForKey:@"respmessage"];
        
        if ([respCode isEqualToNumber:[NSNumber numberWithInt:1]]) {
            //Checking..
            //1 = SearchKPTN
            //2 = Payout
            switch (self.idd) {
                case 1:
                    [self searchResponse_NSArray:result];
                    self.idd = 2;
                    break;
                case 2:
                    [self saveBalance:[result valueForKey:@"principal"]];
                    self.idd = 1;
                    break;
                default:
                    break;
            }
        } else {
            //Clear KPTN
            self.txtKPTN.text = @"";
            
            NSRange rangeValue = [respMesg rangeOfString:@"attempt" options:NSCaseInsensitiveSearch];

            if (rangeValue.length <= 0) //false
            {
                NSLog(@"Message %@", respMesg);
                [self costumerUIAlertView_Message:respMesg];
            }
            else //True
            {
                respMesg = [NSString stringWithFormat:@"%@ \n %@", @"Invalid KPTN or Invalid receiver" , respMesg];
                NSLog(@"Message %@", respMesg);
                [self costumerUIAlertView_Message:respMesg];
                
                
            }
            
            return;
        }
        
    
    }
}

-(void) saveBalance :(NSString*)bal
{
    SaveWalletData *saveData = [SaveWalletData new];
    [saveData initSaveData:bal forKey:@"balance"];

    
    //close Loader when success
    //Hide Loader
    [HUD hide:YES];
    [HUD show:NO];
    
    //KPTN will nil
    self.txtKPTN.text = @"";
    
    
    [UIAlertView myCostumeAlert:@"Payout" alertMessage:@"Successfully payout. You may check your balance. Thank you." delegate:nil cancelButton:@"Ok" otherButtons:nil];
}

- (void) searchResponse_NSArray :(NSData *) res {
    NSString *rec_FName = [res valueForKeyPath:@"rcvrfname"];
    NSString *rec_LName = [res valueForKeyPath:@"rcvrlname"];
    NSString *principal = [res valueForKeyPath:@"principal"];
    NSString *rec_CustID = [res valueForKeyPath:@"custId"];
    double lng = [self Longtitude];
    double lat = [self Latitude];
    NSString *deviceID = [[DeviceID alloc] NSGetDeviceID];
    NSString *location = userLocat;
    
    
    //Check for Valid Receiver..
    if ([self checkIfUserAndReceiver_isTheSame:rec_FName ReceiverLname:rec_LName])
    {
        //Rest Service PAYOUT Mobile
        NSString *post = [NSString stringWithFormat:@"{\"kptn\" : \"%@\",\"walletno\" : \"%@\",\"principal\" : \"%@\",\"custid\" : \"%@\",\"latitude\" : \"%f\",\"longtitude\" : \"%f\",\"deviceid\" : \"%@\", \"location\" : \"%@\"}",
                          strKPTN,
                          walletno,
                          principal,
                          rec_CustID,
                          lat,
                          lng,
                          deviceID,
                          location];
        
        NSString* _key = [[ServiceConnection alloc] NSGetKey];
        NSString* _iv = [[StringEncryption alloc] generateIV];
        NSData* encryptedData = [[StringEncryption alloc]
                                 encrypt:[post dataUsingEncoding:NSUTF8StringEncoding]
                                 key:_key
                                 iv:_iv];
        NSLog(@"Encrypted Data : %@", [encryptedData base64EncodingWithLineLength:0]);
        
        //Data to POST
        NSString *postData = [NSString stringWithFormat:@"{\"encrypted\" : \"%@\", \"iv\" : \"%@\"}",
                          [encryptedData base64EncodingWithLineLength:0],
                          _iv];
   
        
        NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"payoutMobile"];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
        NSData *requestData = [NSData dataWithBytes:[postData UTF8String] length:[postData length]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        [request setHTTPBody:requestData];
        [NSURLConnection connectionWithRequest:request delegate:self];
    } else {
        
        [self costumerUIAlertView_Message:@"Invalid Receiver\nUser information and KPTN information must the same."];
    }
}


#pragma mark - CheckUserANDReceiver
- (BOOL) checkIfUserAndReceiver_isTheSame : (NSString *)receiverFname ReceiverLname: (NSString *)receiverLname {

    //TODO: This will equal to User Firstname and Lastname
    if ([[receiverFname uppercaseString] isEqualToString:[userFname uppercaseString]] && [[receiverLname uppercaseString] isEqualToString:[userLname uppercaseString]])
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
             
- (void) costumerUIAlertView_Message :(NSString *)message {
    NSRange val = [message rangeOfString:@"blocked" options:NSCaseInsensitiveSearch];
    
    if (val.length <= 0)
    {
        
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:message delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    else
    {
        
        [UIAlertView myCostumeAlert:@"Account blocked" alertMessage:message delegate:self cancelButton:@"Ok" otherButtons:nil];
    }
    
    //Hide Loader
    [HUD hide:YES];
    [HUD show:NO];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView title];
    if ([title isEqualToString:@"Account blocked"])
    {
        LoginViewController *loginPage = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil navigationHidden:YES ];
        
        [self.navigationController pushViewController:loginPage animated:YES];
    } else {
        if (buttonIndex == 1) {
            [self btnSubmit:self];
        } else {
            self.txtKPTN.text = @"";
        }
    }
}
#pragma end
@end
