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
    NSArray *receiverImage, *receiverFname, *receiverMname, *receiverLname, *receiverAddress, *receiverRelation;
    int counter;
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
    
    MLUI *getUI = [MLUI new];
    self.navigationItem.titleView = [getUI navTitle:@"Choose Receiver"];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    receiverImage = [NSArray arrayWithObjects:@"bradpit.jpg", @"profile.jpg", @"bradpit.jpg", @"profile.jpg", nil];
    receiverFname = [NSArray arrayWithObjects:@"Harry", @"Jae Marv", @"Christopher", @"Ronald Mark", nil];
    receiverMname = [NSArray arrayWithObjects:@"Lingad", @"Parba asdfasdf", @"Mejares asdfsdf", @"Pardo", nil];
    receiverLname = [NSArray arrayWithObjects:@"Lingad", @"Parba", @"Pardo", @"Mejares", nil];
    receiverAddress = [NSArray arrayWithObjects:@"Tejero, Cebu City", @"1097 MJ Cuenco Ave. Brgy. Barili, Cebu City", @"1097 MJ Cuenco Ave. Brgy. Tejero, Danao City", @"1097 MJ Cuenco Ave. Brgy. Talamban, Cebu City", nil];
    receiverRelation = [NSArray arrayWithObjects:@"Friends", @"Friends", @"Friends", @"Friends", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    NSString *receiverName = [NSString stringWithFormat:@"%@, %@ %@", [receiverFname objectAtIndex:indexPath.row], [receiverLname objectAtIndex:indexPath.row], [receiverMname objectAtIndex:indexPath.row]];
    cell.receiverImage.image = [UIImage imageNamed:[receiverImage objectAtIndex:indexPath.row]];
    cell.receiverName.text= receiverName;
    cell.receiverAddress.text = [receiverAddress objectAtIndex:indexPath.row];
    cell.receiverRelation.text = [receiverRelation objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    counter = (int)[receiverFname count];
    [self.delegate didSelectReceiver:self receiverFname:[receiverFname objectAtIndex:indexPath.row] receiverMname:[receiverMname objectAtIndex:indexPath.row] receiverLname:[receiverLname objectAtIndex:indexPath.row] receiverImage:[UIImage imageNamed:[receiverImage objectAtIndex:indexPath.row]] receiverAddress:[receiverAddress objectAtIndex:indexPath.row] receiverRelation:[receiverRelation objectAtIndex:indexPath.row] rcount:counter];
}


@end
