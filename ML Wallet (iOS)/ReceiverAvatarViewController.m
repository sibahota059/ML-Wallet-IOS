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
#import "CryptLib.h"
#import "NSData+Base64.h"

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
    [self.view setBackgroundColor:[UIColor whiteColor]];

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
    if (receiver.ReceiverImage != [UIImage imageNamed:@"noImage.png"]) {
        imageView.image = receiver.ReceiverImage;
    }
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

#pragma mark - UIAlertViewDelegate
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
            gotoCreate.image    = receiver.ReceiverImage;
            [self.navigationController pushViewController:gotoCreate animated:YES];
        }
    }
}



#pragma mark - Delete Service
- (void)deleteReceiver {
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES navigatorItem:self.navigationItem];
    
    
    //Rest Service
    NSString *postStr = [NSString stringWithFormat:@"{\"walletno\" : \"%@\", \"receiverno\" : \"%@\"}",
                         walletno,
                         receiverno];
    
    //AES encryption
    NSString* _key = [[ServiceConnection alloc] NSGetKey];
    NSString* _iv = [[StringEncryption alloc] generateIV];
    NSData* encryptedData = [[StringEncryption alloc] encrypt:[postStr dataUsingEncoding:NSUTF8StringEncoding]
                                                          key:_key
                                                           iv:_iv];
    postStr = [NSString stringWithFormat:@"{\"encrypted\" : \"%@\",\"iv\" : \"%@\"}",
               [encryptedData base64EncodingWithLineLength:0],
               _iv];
    
    self.responseData = [NSMutableData data];
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"deleteReceiver"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    NSData *requestData = [NSData dataWithBytes:[postStr UTF8String] length:[postStr length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:requestData];
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
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:[error localizedDescription] delegate:self cancelButton:@"Ok" otherButtons:nil];
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
