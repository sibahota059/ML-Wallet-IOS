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

#import <CoreLocation/CoreLocation.h>

@interface TopupViewController ()

@end

@implementation TopupViewController
{    
    CLLocationManager *locationManager;
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
    
    [self navigationView];
    
    
    //WaitScreen
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
    //Set UP Location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
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
    self.title = @"MY RECEIVER";
    
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
    
    strKPTN = self.txtKPTN.text;
    
    if ([strKPTN isEqualToString:@""] && strKPTN == nil) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Type your KPTN" delegate:nil cancelButton:@"Ok" otherButtons:nil];
        return;
    }
    
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    
    //TODO : NO Wallet
    NSString *srvcURL1 = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"searchKPTN/?"];
    NSString *srvcURL = [NSString stringWithFormat: @"%@kptn=%@&walletno=%@", srvcURL1, strKPTN, @"14030000000123"];
    
    self.responseData = [NSMutableData data];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [con start];
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
    
    if (myError == nil) {
        NSArray *result;
        if (self.idd == 1)
        {
            result = [res valueForKey:@"searchKPTNResult"];
        }else{
            result = [res valueForKey:@"payoutMobileResult"];
        }
        
        NSNumber *respCode = [result valueForKey:@"respcode"];
        NSString *respMesg = [result valueForKey:@"respmessage"];
        
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
                    //TODO
                    self.idd = 1;
                    break;
                default:
                    break;
            }
        } else {
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


- (void) searchResponse_NSArray :(NSArray *) res {
    NSString *rec_FName = [res valueForKeyPath:@"rcvrfname"];
    NSString *rec_LName = [res valueForKeyPath:@"rcvrlname"];
    NSString *principal = [res valueForKeyPath:@"principal"];
    NSString *rec_CustID = [res valueForKeyPath:@"custId"];
    double lng = [self Longtitude];
    double lat = [self Latitude];
    NSString *deviceID = [[DeviceID alloc] NSGetDeviceID];
    NSString *location = @"IOS_CANT_LOCATE";
    
    //TODO : NO Wallet
    //Check for Valid Receiver..
    if ([self checkIfUserAndReceiver_isTheSame:rec_FName ReceiverLname:rec_LName])
    {
        //Rest Service PAYOUT Mobile
        NSString *post = [NSString stringWithFormat:@"{\"kptn\" : \"%@\",\"walletno\" : \"%@\",\"principal\" : \"%@\",\"custid\" : \"%@\",\"latitude\" : \"%f\",\"longtitude\" : \"%f\",\"deviceid\" : \"%@\", \"location\" : \"%@\"}",
                          strKPTN,
                          @"14030000000123",
                          principal,
                          rec_CustID,
                          lat,
                          lng,
                          deviceID,
                          location];
        
        NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"payoutMobile"];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
        NSData *requestData = [NSData dataWithBytes:[post UTF8String] length:[post length]];
        
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
    if ([[receiverFname uppercaseString] isEqualToString:@"JERRY"] && [[receiverLname uppercaseString] isEqualToString:@"LOPEZ"])
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView title];
    if ([title isEqualToString:@"Account blocked"])
    {
        LoginViewController *loginPage = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil navigationHidden:YES ];
        
        [self.navigationController pushViewController:loginPage animated:YES];
    }
}

/*
 Printing description of result:
 {
 cancdate = "<null>";
 controlno = "MS1-3-169-0514-000001";
 custId = 14020003419114;
 kptn = MLW051169178420205;
 principal = 350;
 rcvrfname = RONAMAE;
 rcvrlname = TORION;
 rcvrmname = C;
 rcvrname = "TORION, RONAMAE C";
 respcode = 1;
 respmessage = "Transaction Found.";
 sndrfname = JERRY;
 sndrlname = LOPEZ;
 sndrmname = N;
 sndrname = "LOPEZ, JERRY N";
 }
*/
@end
