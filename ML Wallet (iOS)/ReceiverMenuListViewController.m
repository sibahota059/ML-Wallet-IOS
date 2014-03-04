//
//  ReceiverMenuListViewController.m
//  ML Wallet
//
//  Created by ml on 2/20/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "ReceiverMenuListViewController.h"
#import "MenuViewController.h"
#import "CreateNewReceiverViewController.h"
#import "ReceiverCell.h"
#import "UIAlertView+alertMe.h"
#import "ReceiverAvatarViewController.h"
#import "ReceiverObject.h"

@interface ReceiverMenuListViewController ()

@end

@implementation ReceiverMenuListViewController

@synthesize allTableData;
@synthesize filteredTableData;
@synthesize searchBar;
@synthesize isFiltered;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    allTableData = [[NSMutableArray alloc] initWithObjects:
                   [[ReceiverObject alloc] initWithName:@"Steak" Address:@"Address1" Relation:@"relation1" receiverImage:[UIImage imageNamed:@"so.9.png"]],
                    [[ReceiverObject alloc] initWithName:@"Steak" Address:@"Address2" Relation:@"relation2" receiverImage:[UIImage imageNamed:@"no_image.png"]],
                     [[ReceiverObject alloc] initWithName:@"Salad" Address:@"Address3" Relation:@"relation3" receiverImage:[UIImage imageNamed:@"no_image.png"]],
                      [[ReceiverObject alloc] initWithName:@"Salad" Address:@"Address4" Relation:@"relation4" receiverImage:[UIImage imageNamed:@"no_image.png"]],
                       [[ReceiverObject alloc] initWithName:@"Fruit" Address:@"Address5" Relation:@"relation5" receiverImage:[UIImage imageNamed:@"no_image.png"]],
                        [[ReceiverObject alloc] initWithName:@"Potato" Address:@"Address6" Relation:@"relation6" receiverImage:[UIImage imageNamed:@"no_image.png"]],
                         [[ReceiverObject alloc] initWithName:@"Potato" Address:@"Address7" Relation:@"relation7" receiverImage:[UIImage imageNamed:@"no_image.png"]],
                          [[ReceiverObject alloc] initWithName:@"Bread" Address:@"Address8" Relation:@"relation8" receiverImage:[UIImage imageNamed:@"no_image.png"]],
                           [[ReceiverObject alloc] initWithName:@"Bread" Address:@"Address9" Relation:@"relation9" receiverImage:[UIImage imageNamed:@"no_image.png"]],
                            [[ReceiverObject alloc] initWithName:@"Hot Dog" Address:@"Address10" Relation:@"relation10" receiverImage:[UIImage imageNamed:@"no_image.png"]],
                             [[ReceiverObject alloc] initWithName:@"Hot Dog" Address:@"Address11" Relation:@"relation11" receiverImage:[UIImage imageNamed:@"no_image.png"]],
                              [[ReceiverObject alloc] initWithName:@"Hot Dog" Address:@"Address12" Relation:@"relation12" receiverImage:[UIImage imageNamed:@"no_image.png"]],
                               [[ReceiverObject alloc] initWithName:@"Pizza" Address:@"Address13" Relation:@"relation13" receiverImage:[UIImage imageNamed:@"no_image.png"]], nil];
    

    //Set Navigator
    [self navigationButtons];
    //[self.MainScroll setScrollEnabled:YES];
    //[self.MainScroll setContentSize:CGSizeMake(320, 600)];
    
    //Set Background
    if ([UIScreen mainScreen].bounds.size.height >= 568) //4 inch
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground1.png"]]];
    }
    else //4 inc below
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground3.png"]]];
        self.receiverTableView.frame = CGRectMake(0, 204, self.view.frame.size.width, self.view.frame.size.height);
        self.receiverSearchBar.frame = CGRectMake(0, 150, 320, 44);
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount;
    if(self.isFiltered)
        rowCount = filteredTableData.count;
    else
        rowCount = allTableData.count;
    
    return rowCount;
}

//Add view Height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ReceiverCell";
    ReceiverCell *cell = (ReceiverCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ReceiverCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    ReceiverObject* reciver;
    if(isFiltered)
        reciver = [filteredTableData objectAtIndex:indexPath.row];
    else
        reciver = [allTableData objectAtIndex:indexPath.row];
    	
    cell.nameLabel.text             = reciver.ReceiverName;
    cell.thumbnailImageView.image   = reciver.ReceiverImage;
    cell.relationLabel.text         = reciver.Relation;
    cell.addressLabel.text          = reciver.Address;
    
    return cell;
}

#pragma mark - Table view delegate

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = true;
        filteredTableData = [[NSMutableArray alloc] init];
        
        for (ReceiverObject* receiver in allTableData)
        {
            NSRange nameRange       = [receiver.ReceiverName rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange addressRange    = [receiver.Address rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange ralationRange   = [receiver.Relation rangeOfString:text options:NSCaseInsensitiveSearch];
            
            if(nameRange.location != NSNotFound || addressRange.location != NSNotFound || ralationRange.location != NSNotFound )
            {
                [filteredTableData addObject:receiver];
            }
        }
    }

    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self showDetailsForIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetailsForIndexPath:indexPath];
}

-(void) showDetailsForIndexPath:(NSIndexPath*)indexPath
{
    [self.searchBar resignFirstResponder];
    ReceiverAvatarViewController* vc = [[ReceiverAvatarViewController alloc] initWithNibName:@"ReceiverAvatarViewController" bundle:nil];
    ReceiverObject* receiver;
    
    if(isFiltered)
    {
        receiver = [filteredTableData objectAtIndex:indexPath.row];
    }
    else
    {
        receiver = [allTableData objectAtIndex:indexPath.row];
    }
    
    self.searchBar.showsCancelButton = NO;
    vc.receiver = receiver;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma Start #Selector for HomeClick
-(void)homeClick
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma Start #Selector for Create New Receiver
- (void)newReceiver
{
    CreateNewReceiverViewController *nxtPage = [[CreateNewReceiverViewController alloc] initWithNibName:@"CreateNewReceiverViewController" bundle:nil];
    [self.navigationController pushViewController:nxtPage animated:YES];
}

#pragma Start #Add button for NavigationBar
-(void)navigationButtons
{
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"MY RECEIVERS";
    UIBarButtonItem *buttonHome = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(homeClick)];
    UIBarButtonItem *buttonAddReceiver = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"receiver_add_person.png"]
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(newReceiver)];
    
    self.navigationItem.leftBarButtonItem = buttonHome;
    self.navigationItem.rightBarButtonItem = buttonAddReceiver;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)TsearchBar
{
    self.searchBar.showsCancelButton = YES;
    [TsearchBar setShowsScopeBar:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)TsearchBar
{
    [self.searchBar resignFirstResponder];
    return YES;
}

//If Button Search click
- (void)searchBarSearchButtonClicked:(UISearchBar *)TsearchBar
{
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
}

//if Button Cancel click
- (void)searchBarCancelButtonClicked:(UISearchBar *)TsearchBar
{
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
    isFiltered = FALSE;
    [self.tableView reloadData];
}
#pragma End #UISearchBar <<====



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
