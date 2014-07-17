//
//  CreateNewReceiverViewController.m
//  ML Wallet
//
//  Created by ml on 2/21/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "CreateNewReceiverViewController.h"
#import "UIAlertView+alertMe.h"
#import "MBProgressHUD.h"
#import "ServiceConnection.h"
#import "ReceiverMenuListViewController.h"

@interface CreateNewReceiverViewController ()

@end

@implementation CreateNewReceiverViewController

@synthesize responseData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    //relationView
    self.relationView.hidden = YES;
    
    //SetUP Loader
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
    
    //Set Navigator
    [self navigator];
    [self.MyScrollview setScrollEnabled:YES];
    [self.MyScrollview setContentSize:CGSizeMake(320, 600)];
    
    //Set Background
    if ([UIScreen mainScreen].bounds.size.height >= 568) //4 inch
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground1.png"]]];
    }
    else //4 inc below
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground3.png"]]];
    }
}


#pragma Start #Navigator
- (void)navigator
{
    self.title = @"NEW RECEIVER";
    UIBarButtonItem *buttonAddReceiver = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"save.png"] style:UIBarButtonItemStyleDone  target:self action:@selector(saveReceiver)];
    self.navigationItem.rightBarButtonItem = buttonAddReceiver;
}

#pragma Start #Save New Receiver
- (void)saveReceiver
{
    NSString *lname     = self.txtLastName.text;
    NSString *mname     = self.txtMiddleName.text;
    NSString *fname     = self.txtFirstName.text;
    NSString *address   = self.txtAddress.text;
    NSString *relation  = self.txtRelation.titleLabel.text;
    
    //Validation NuLL Value
    if ([lname isEqualToString:@""]) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Lastname must have value" delegate:nil cancelButton:nil otherButtons:@"Ok"];
        return;
    } else if ([mname isEqualToString:@""]) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Middlename must have value" delegate:nil cancelButton:nil otherButtons:@"Ok"];
        return;
    } else if ([fname isEqualToString:@""]) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Firstname must have value" delegate:nil cancelButton:nil otherButtons:@"Ok"];
        return;
    } else if ([address isEqualToString:@""]) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Address must have value" delegate:nil cancelButton:nil otherButtons:@"Ok"];
        return;
    } else if ([relation isEqualToString:@""]) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Relation must have value" delegate:nil cancelButton:nil otherButtons:@"Ok"];
        return;
    }
   
    
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    
    
    //Rest Service
    self.responseData = [NSMutableData data];
    NSString *post = [NSString stringWithFormat:@"{\"walletno\" : \"%@\",\"fname\" : \"%@\",\"mname\" : \"%@\",\"lname\" : \"%@\",\"relation\" : \"%@\",\"photo\" : \"%@\",\"address\" : \"%@\"}",
                      @"14030000000123",
                      fname,
                      mname,
                      lname,
                      relation,
                      @"",
                      address];
    
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"addReceiverList"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    NSData *requestData = [NSData dataWithBytes:[post UTF8String] length:[post length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:request delegate:self];
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
        NSNumber *respCode = [res valueForKey:@"respcode"];
        NSString *respMesg = [res valueForKey:@"respmessage"];
    
        if ([respCode isEqualToNumber:[NSNumber numberWithInt:1]]) {
            [UIAlertView myCostumeAlert:@"Create Receiver" alertMessage:@"New receiver successfuly added" delegate:self cancelButton:@"Ok" otherButtons:nil];
        } else {
             [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:respMesg delegate:nil cancelButton:@"Ok" otherButtons:nil];
        }
        
    } else {
        [UIAlertView myCostumeAlert:@"Exception Error" alertMessage:[myError localizedDescription] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
    //Hide Loader
    [HUD hide:YES];
    [HUD show:NO];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"Ok"]) {
        ReceiverMenuListViewController *bckList = [[ReceiverMenuListViewController alloc] initWithNibName:@"ReceiverMenuListViewController" bundle:nil];
        [self.navigationController pushViewController:bckList animated:YES];
        return;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideRelationView {
    [self.view endEditing:YES];
    
    if (self.relationView.hidden) {
            self.relationView.hidden = NO;
    } else {
            self.relationView.hidden = YES;
    }
}

- (IBAction)btnRelation:(id)sender {
    [self hideRelationView];
}

- (IBAction)btnFamily:(id)sender {
    [self.txtRelation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.txtRelation.titleLabel.text = @"Family";
    [self hideRelationView];
}

- (IBAction)btnFriend:(id)sender {
    [self.txtRelation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.txtRelation.titleLabel.text = @"Friend";    
    [self hideRelationView];
}
@end
