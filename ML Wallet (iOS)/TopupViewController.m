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

@interface TopupViewController ()

@end

@implementation TopupViewController


@synthesize responseData;
@synthesize idd;

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
    
    NSString *txtKPTN = self.txtKPTN.text;
    
    if ([txtKPTN isEqualToString:@""] && txtKPTN == nil) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Type your KPTN" delegate:nil cancelButton:@"Ok" otherButtons:nil];
        return;
    }
    
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    
    NSString *srvcURL1 = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"searchKPTN/?"];
    NSString *srvcURL = [NSString stringWithFormat: @"%@kptn=%@&walletno=%@", srvcURL1, txtKPTN, @"14030000000123"];
    
    self.responseData = [NSMutableData data];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [con start];
    
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
        NSArray *result = [res valueForKey:@"searchKPTNResult"];
        
        NSNumber *respCode = [result valueForKey:@"respcode"];
        NSString *respMesg = [result valueForKey:@"respmessage"];
        
        if ([respCode isEqualToNumber:[NSNumber numberWithInt:1]]) {
            //Checking..
            //1 = SearchKPTN
            //2 = Payout
            switch (self.idd) {
                case 1:
                    [self searchResponse_NSArray:res];
                    break;
                case 2:
                    break;
                default:
                    break;
            }
        } else {
            [self costumerUIAlertView_Message:respMesg];
            return;
        }
        
    
    }
}


- (void) searchResponse_NSArray :(NSArray *) res {
    
}
             
- (void) costumerUIAlertView_Message :(NSString *)message {
    [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:message delegate:nil cancelButton:@"Ok" otherButtons:nil];
}

@end
