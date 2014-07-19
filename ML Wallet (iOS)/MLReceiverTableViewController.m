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


@interface MLReceiverTableViewController (){
    //NSArray *receiverImage, *receiverFname, *receiverMname, *receiverLname, *receiverAddress, *receiverRelation;
    int counter;
    GetReceiver *getReceiver;
    NSMutableArray *receiverImage, *receiverFname, *receiverMname, *receiverLname, *receiverAddress, *receiverRelation, *receiverNo, *getValueReceiver;
    UIImage *recImage;
    MBProgressHUD *HUD;
    MLUI *getUI;
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
    
    //WaitScreen
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    
    getReceiver = [GetReceiver new];
    getReceiver.delegate = self;
    
    getUI = [MLUI new];
    //self.navigationItem.titleView = [getUI navTitle:@"Choose Receiver"];
    self.title = @"Choose Receiver";
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    //    receiverImage = [NSArray arrayWithObjects:@"bradpit.jpg", @"profile.jpg", @"bradpit.jpg", @"profile.jpg", nil];
    //    receiverFname = [NSArray arrayWithObjects:@"Harry", @"Jae Marv", @"Christopher", @"Ronald Mark", nil];
    //    receiverMname = [NSArray arrayWithObjects:@"Lingad", @"Parba asdfasdf", @"Mejares asdfsdf", @"Pardo", nil];
    //    receiverLname = [NSArray arrayWithObjects:@"Lingad", @"Parba", @"Pardo", @"Mejares", nil];
    //    receiverAddress = [NSArray arrayWithObjects:@"Tejero, Cebu City", @"1097 MJ Cuenco Ave. Brgy. Barili, Cebu City", @"1097 MJ Cuenco Ave. Brgy. Tejero, Danao City", @"1097 MJ Cuenco Ave. Brgy. Talamban, Cebu City", nil];
    //    receiverRelation = [NSArray arrayWithObjects:@"Friends", @"Friends", @"Friends", @"Friends", nil];
    
    [getReceiver getReceiverWalletNo:@"14050000000135"];
}

- (void)didFinishLoadingReceiver:(NSString *)indicator{

    [HUD hide:YES];
    [HUD show:NO];
    
//    "<counter>k__BackingField" = 5;
    
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
            
        }
        
    }else if ([[NSString stringWithFormat:@"%@", respcode] isEqualToString:@"0"]){
        [getUI displayAlert:@"Message" message:[NSString stringWithFormat:@"%@", respmessage]];
    }else{
        [getUI displayAlert:@"Message" message:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948"];
    }
    
    
    
    [self.tableView reloadData];
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
    //NSString *rNumber = [receiverNo objectAtIndex:[indexPath row]];
    NSString *rRelation = [receiverRelation objectAtIndex:[indexPath row]];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:rImage options: NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *receiverName = [NSString stringWithFormat:@"%@, %@ %@", rLname, rFname, rMname];
    
    if ([UIImage imageWithData:data] == nil) {
        cell.receiverImage.image = [UIImage imageNamed:@"noImage.png"];
    }else{
        cell.receiverImage.image = [UIImage imageWithData:data];
    }
    
    cell.receiverName.text= receiverName;
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
    [self.delegate didSelectReceiver:self receiverFname:[receiverFname objectAtIndex:indexPath.row] receiverMname:[receiverMname objectAtIndex:indexPath.row] receiverLname:[receiverLname objectAtIndex:indexPath.row] receiverImage:[receiverImage objectAtIndex:indexPath.row] receiverAddress:[receiverAddress objectAtIndex:indexPath.row] receiverRelation:[receiverRelation objectAtIndex:indexPath.row] rcount:counter];
}


@end
