//
//  PartnersTableViewController.m
//  ML Wallet
//
//  Created by ml on 11/28/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "PartnersTableViewController.h"

@interface PartnersTableViewController (){
    NSMutableArray *finalPartners;
    NSString *getDisplayType;
}

@end

@implementation PartnersTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    finalPartners = [NSMutableArray new];
    
    
    
    if ([_displayType isEqualToString:@"partners"]) {
        
        self.title = @"LIST OF PARTNERS";
        
    }else{
        
        self.title = @"LIST OF ACCOUNTS";
        
    }
    
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
    
    NSUInteger x;
    
    if ([_displayType isEqualToString:@"partners"]) {
        
        getDisplayType = @"partners";
        finalPartners = _getPartners;
        x = [finalPartners count];
        return x;
        
    }else{

        getDisplayType = @"account";
        finalPartners = _getAccount;
        x = [finalPartners count];
        return x;
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //cell.textLabel.text = [finalPartners objectAtIndex:indexPath.row];
    
    if ([_displayType isEqualToString:@"partners"]) {
        
        cell.textLabel.text = [[finalPartners objectAtIndex:indexPath.row] objectAtIndex:0];
        
    }else{
        
        cell.textLabel.text = [finalPartners objectAtIndex:indexPath.row];
        
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {

     
     if ([_displayType isEqualToString:@"partners"]) {
         
         [self.delegate didSelectPartners:self andPartnersName:[[finalPartners objectAtIndex:indexPath.row] objectAtIndex:0] andDisplayType:getDisplayType andPosition:indexPath.row];
         
     }else{
         
         [self.delegate didSelectPartners:self andPartnersName:[finalPartners objectAtIndex:indexPath.row] andDisplayType:getDisplayType andPosition:indexPath.row];
         
     }
     
     
 }

@end
