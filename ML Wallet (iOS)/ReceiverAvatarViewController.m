//
//  ReceiverAvatarViewController.m
//  ML Wallet
//
//  Created by ml on 2/25/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "ReceiverAvatarViewController.h"
#import "UIAlertView+alertMe.h"
#import "ServiceConnection.h"
#import "ReceiverMenuListViewController.h"
#import "CreateNewReceiverViewController.h"
#import "NSDictionary+LoadWalletData.h"

@interface ReceiverAvatarViewController ()

@end


@implementation ReceiverAvatarViewController
{
    NSNumber *receiverno;
    NSString *walletno;
}

@synthesize nameLabel;
@synthesize addressLabel;
@synthesize relationLabel;
@synthesize imageView;
@synthesize receiver;
@synthesize responseData;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Get Walletno
    NSDictionary *dic = [NSDictionary initRead_LoadWallet_Data];
    walletno = [dic objectForKey:@"walletno"];
    
    //SetUP Loader
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
    [self navigator];
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

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setAddressLabel:nil];
    [super viewDidUnload];
}
-(void)viewWillAppear:(BOOL)animated
{
    nameLabel.text = receiver.ReceiverName;
    addressLabel.text = receiver.Address;
    relationLabel.text = receiver.Relation;
    imageView.image = receiver.ReceiverImage;
    receiverno = receiver.receiverNo;
}

#pragma Start #Navigator
- (void)navigator
{
    self.title = @"My Receiver";
    UIBarButtonItem *buttonEdit = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit_image.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(EditReceiver)];
    
    UIBarButtonItem *buttonDelete = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(DeleteReceiver)];
    
    NSArray *buttonArray = [[NSArray alloc] initWithObjects:buttonDelete, buttonEdit, nil];
    
    self.navigationItem.rightBarButtonItems = buttonArray;
}


#pragma Start - Selector Delete
- (void)DeleteReceiver
{
    [UIAlertView myCostumeAlert:@"Delete" alertMessage:@"Are you sure?" delegate:self cancelButton:@"Cancel" otherButtons:@"YES"];
    //toDO
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *titleView     = [alertView title];
    NSString *titleButton   = [alertView buttonTitleAtIndex:buttonIndex];
    
    //Delete BUtton
    if ([titleView isEqualToString:@"Delete"] || [titleView isEqualToString:@"Delete receiver"])
    {
        if ([titleButton isEqualToString:@"YES"]) {
            [self deleteReceiver];
            return;
        }
    
        if ([titleButton isEqualToString:@"Ok"]) {
        
            ReceiverMenuListViewController *bckList = [[ReceiverMenuListViewController alloc] initWithNibName:@"ReceiverMenuListViewController" bundle:nil];
            [self.navigationController pushViewController:bckList animated:YES];
            return;
        }
    }
    
    //EDIT button
    if ([titleView isEqualToString:@"Edit Receiver"]) {
        //TODO,.
        if ([titleButton isEqualToString:@"YES"]) {
            CreateNewReceiverViewController *gotoCreate = [[CreateNewReceiverViewController alloc]
                                                           initWithNibName:@"CreateNewReceiverViewController"
                                                           bundle:nil];
            gotoCreate.isEdit   = YES;
            gotoCreate.fname    = receiver.fname;
            gotoCreate.lname    = receiver.lname;
            gotoCreate.mname    = receiver.mname;
            gotoCreate.addrs    = receiver.Address;
            gotoCreate.rlate    = receiver.Relation;
            gotoCreate.recNo    = receiver.receiverNo;
            [self.navigationController pushViewController:gotoCreate animated:YES];
        }
    }
}



#pragma mark - Delete Service
- (void)deleteReceiver {
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    
    
    //Rest Service
    self.responseData = [NSMutableData data];
    NSString *srvcURL1 = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"deleteReceiver/?"];
    NSString *srvcURL = [NSString stringWithFormat: @"%@walletno=%@&receiverno=%@", srvcURL1, walletno, receiverno];
    
    self.responseData = [NSMutableData data];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    [request setHTTPMethod:@"DELETE"];
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
        
        NSArray *result = [res valueForKey:@"deleteReceiverResult"];
        
        NSNumber *respCode = [result valueForKey:@"respcode"];
        NSString *respMesg = [result valueForKey:@"respmessage"];
    
        
        //hide  loAder..
        [HUD hide:YES];
        [HUD show:NO];
        
        
        if ([respCode isEqualToNumber:[NSNumber numberWithInt:1]]) {
            [UIAlertView myCostumeAlert:@"Delete receiver" alertMessage:respMesg delegate:self cancelButton:@"Ok" otherButtons:nil];
            return;
        } else {
            [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:respMesg delegate:nil cancelButton:@"Ok" otherButtons:nil];
            return;
        }
    }
    
}


#pragma Start - Selector Edit
- (void)EditReceiver
{
    [UIAlertView myCostumeAlert:@"Edit Receiver" alertMessage:@"Do you want to continue?" delegate:self cancelButton:@"Cancel" otherButtons:@"YES"];
    //toDO
}

@end
