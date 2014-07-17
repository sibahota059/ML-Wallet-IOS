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
#import "MBProgressHUD.h"
#import "ServiceConnection.h"
#import "UIAlertView+alertMe.h"
#import "UIImage+DecodeStringToImage.h"

@interface ReceiverMenuListViewController ()

@end

@implementation ReceiverMenuListViewController

@synthesize responseData;
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


- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //WaitScreen
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
    
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
    
    
    //RetrieveReciever's
    [self RetrieveReceiverList];

}

#pragma mark - NSURLConnection Delegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:[error description] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    //Hide Loader
    [HUD hide:YES];
    [HUD show:NO];
}

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
    
    
    if (myError == nil){
        NSArray *result = [res valueForKey:@"retrieveReceiversResult"];
        
        NSNumber *respCode = [result valueForKey:@"<respcode>k__BackingField"];
        NSString *respMesg = [result valueForKey:@"<respmessage>k__BackingField"];
        
        //Hide Loader
        [HUD hide:YES];
        [HUD show:NO];
        
        allTableData = [NSMutableArray new];
        
        if ([respCode isEqualToNumber:[NSNumber numberWithInt:1]]) //Success
        {
            if ([result valueForKey:@"<receiverList>k__BackingField"] != [NSNull null])
            {
                NSArray *itemArray = [result valueForKey:@"<receiverList>k__BackingField"]; // check null if need
                for (NSDictionary *itemDic in itemArray){
                    NSString *address = [itemDic valueForKey:@"address"];
                    NSString *fname = [itemDic valueForKey:@"fname"];
                    NSString *lname = [itemDic valueForKey:@"lname"];
                    NSString *mname = [itemDic valueForKey:@"mname"];
                    NSString *photo = [itemDic valueForKey:@"photo"];
                    NSNumber *receiverNo = [itemDic valueForKey:@"receiverNo"];
                    NSString *relation = [itemDic valueForKey:@"relation"];
                
                    NSLog(@"ReceiverNo : %@", receiverNo);
                    //Convert to Image
                    UIImage *photoImage = [UIImage decodeBase64ToImage:photo];
                    
                    NSString *fullName = [NSString stringWithFormat:@"%@ %@ %@",fname, mname, lname];
                    
                    if (photoImage == nil) {
                        photoImage = [UIImage imageNamed:@"no_image.png"];
                    }
                    
                    //Add to NSMutableArray
                    [allTableData addObject:[[ReceiverObject alloc] initWithName:fullName Address:address Relation:relation receiverImage:photoImage receiverNo:receiverNo]];
                    
                    
                    
                    //refresh tableView
                    [self.tableView reloadData];
                }
            } else {
                [UIAlertView myCostumeAlert:@"Validation Arror" alertMessage:respMesg delegate:nil cancelButton:@"Ok" otherButtons:nil];
                return;
            }
            
            return;
        }
        else
        {
            //Show Error
            [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:respMesg delegate:nil cancelButton:@"Ok" otherButtons:nil];
            return;
        }
        
        
    } else {
        //Show if Error
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:[myError localizedDescription] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
}

- (void) RetrieveReceiverList
{
    
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"retrieveReceivers/?walletno=14030000000123"];
    
    self.responseData = [NSMutableData data];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [con start];
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
    MenuViewController *menuPage = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [self.navigationController pushViewController:menuPage animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - Search Delegate
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
