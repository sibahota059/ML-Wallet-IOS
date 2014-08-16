//
//  MLViewController.m
//  SendMoney
//
//  Created by mm20 on 2/19/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import "MLReceiverTableViewController.h"
#import "MLReceiverTableViewCell.h"
#import "MLUI.h"
#import "NSDictionary+LoadWalletData.h"
#import "UIAlertView+alertMe.h"


@interface MLReceiverTableViewController (){
    
    int counter;
    GetReceiver *getReceiver;
    NSMutableArray *receiverImage, *receiverFname, *receiverMname, *receiverLname, *receiverAddress, *receiverRelation, *receiverNo, *getValueReceiver;
    UIImage *recImage;
    MBProgressHUD *HUD;
    MLUI *getUI;
    NSString *confirmInd, *walletno;
    NSDictionary *dic;
}

@end

@implementation MLReceiverTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    getReceiver = [GetReceiver new];
    getReceiver.delegate = self;
    
    getUI = [MLUI new];
    //self.navigationItem.titleView = [getUI navTitle:@"Choose Receiver"];
    self.title = @"CHOOSE RECEIVER";
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    //Create object of MBProgressHUD class and add progress dialog view
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    
    
    //Create object of NSDictionary and load data from Property List
    dic = [NSDictionary initRead_LoadWallet_Data];
    
    //Get the value of walletno in Property List
    walletno = [dic objectForKey:@"walletno"];
    
    NSArray *receiver = [_ds objectForKey:@"retrieveReceiversResult"];
    getValueReceiver = [receiver valueForKey:@"<receiverList>k__BackingField"];

    
        receiverImage = [NSMutableArray new];
        receiverFname = [NSMutableArray new];
        receiverMname = [NSMutableArray new];
        receiverLname = [NSMutableArray new];
        receiverAddress = [NSMutableArray new];
        receiverRelation = [NSMutableArray new];
        receiverNo = [NSMutableArray new];
        
        for (NSDictionary *items in getValueReceiver) {
            
            NSString *rImage  = [items valueForKey:@"photo"];
            NSString *fName  = [items valueForKey:@"fname"];
            NSString *mName  = [items valueForKey:@"mname"];
            NSString *lName  = [items valueForKey:@"lname"];
            NSString *address  = [items valueForKey:@"address"];
            NSString *rNumber  = [items valueForKey:@"receiverNo"];
            NSString *relation  = [items valueForKey:@"relation"];
            
            
            [receiverImage addObject:rImage];
            [receiverFname addObject:fName];
            [receiverMname addObject:mName];
            [receiverLname addObject:lName];
            [receiverAddress addObject:address];
            [receiverNo addObject:rNumber];
            [receiverRelation addObject:relation];
            
        }

    // Background Color
    UIColor *bgRefreshColor = [UIColor whiteColor];
    
    // Creating refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresher) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl setBackgroundColor:bgRefreshColor];
    self.refreshControl = self.refreshControl;
    
    // Creating view for extending background color
    CGRect frame = self.tableView.bounds;
    frame.origin.y = -frame.size.height;
    UIView* bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = bgRefreshColor;
    
    // Adding the view below the refresh control
    [self.tableView insertSubview:bgView atIndex:0];
    
    
    [self.tableView reloadData];
    
}

- (void)refresher{
    confirmInd = @"receiver";
    [getReceiver getReceiverWalletNo:walletno];
}

- (void)didFinishLoadingReceiver:(NSString *)indicator andError:(NSString *)getError{

    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor darkGrayColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
    
    
    NSArray *receiver = [getReceiver.getReceiver objectForKey:@"retrieveReceiversResult"];
    getValueReceiver = [receiver valueForKey:@"<receiverList>k__BackingField"];
    NSString *respcode    = [receiver valueForKey:@"<respcode>k__BackingField"];
    NSString *respmessage = [receiver valueForKey:@"<respmessage>k__BackingField"];
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", respcode]isEqualToString:@"1"]){
        
        receiverImage = [NSMutableArray new];
        receiverFname = [NSMutableArray new];
        receiverMname = [NSMutableArray new];
        receiverLname = [NSMutableArray new];
        receiverAddress = [NSMutableArray new];
        receiverRelation = [NSMutableArray new];
        receiverNo = [NSMutableArray new];
        
        for (NSDictionary *items in getValueReceiver) {
            
            NSString *rImage  = [items valueForKey:@"photo"];
            NSString *fName  = [items valueForKey:@"fname"];
            NSString *mName  = [items valueForKey:@"mname"];
            NSString *lName  = [items valueForKey:@"lname"];
            NSString *address  = [items valueForKey:@"address"];
            NSString *rNumber  = [items valueForKey:@"receiverNo"];
            NSString *relation  = [items valueForKey:@"relation"];
            
            
            [receiverImage addObject:rImage];
            [receiverFname addObject:fName];
            [receiverMname addObject:mName];
            [receiverLname addObject:lName];
            [receiverAddress addObject:address];
            [receiverNo addObject:rNumber];
            [receiverRelation addObject:relation];
        
            [self.tableView reloadData];

            
        }
        
    }else if ([[NSString stringWithFormat:@"%@", respcode] isEqualToString:@"0"]){
        [UIAlertView myCostumeAlert:@"Message" alertMessage:[NSString stringWithFormat:@"%@", respmessage] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if ([indicator isEqualToString:@"error"]){
        confirmInd = @"receiver";
        [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
    }else{
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [receiverFname count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{static NSString *simpleTableIdentifier = @"receiver";
    
    MLReceiverTableViewCell *cell = (MLReceiverTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MLReceiverTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *rImage = [receiverImage objectAtIndex:[indexPath row]];
    NSString *rFname = [receiverFname objectAtIndex:[indexPath row]];
    NSString *rMname = [receiverMname objectAtIndex:[indexPath row]];
    NSString *rLname = [receiverLname objectAtIndex:[indexPath row]];
    NSString *rAddress = [receiverAddress objectAtIndex:[indexPath row]];
    NSString *rRelation = [receiverRelation objectAtIndex:[indexPath row]];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:rImage options: NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *receiverName = [NSString stringWithFormat:@"%@, %@ %@", rLname, rFname, rMname];
    
    if ([UIImage imageWithData:data] == nil) {
        cell.receiverImage.image = [UIImage imageNamed:@"noImage.png"];
    }else{
        cell.receiverImage.image = [UIImage imageWithData:data];
    }
    
    cell.receiverName.text= [receiverName uppercaseString];
    cell.receiverAddress.text = rAddress;
    cell.receiverRelation.text = rRelation;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    counter = (int)[receiverFname count];
    [self.delegate didSelectReceiver:self receiverFname:[receiverFname objectAtIndex:indexPath.row] receiverMname:[receiverMname objectAtIndex:indexPath.row] receiverLname:[receiverLname objectAtIndex:indexPath.row] receiverImage:[receiverImage objectAtIndex:indexPath.row] receiverAddress:[receiverAddress objectAtIndex:indexPath.row] receiverRelation:[receiverRelation objectAtIndex:indexPath.row] rnumber:[receiverNo objectAtIndex:indexPath.row]];
}


- (void)confirmDialog:(NSString *)title andMessage:(NSString *)message andButtonNameOK:(NSString *)btnOne andButtonNameCancel:(NSString *)btnTwo{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:btnOne otherButtonTitles:btnTwo,nil];
    
    [self performSelector:@selector(dismiss:) withObject:alert afterDelay:60.0];
    
    [alert show];
    
}

- (void)dismiss:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:-1 animated:YES];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        if ([confirmInd isEqualToString:@"receiver"]){
            [self refresher];
        }
    }
    else if (buttonIndex == 1) {
        //do nothing
    }
}
@end
