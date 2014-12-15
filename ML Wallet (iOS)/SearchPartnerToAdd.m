//
//  SearchPartnerToAdd.m
//  ML Wallet
//
//  Created by mm20-18 on 12/11/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "SearchPartnerToAdd.h"

@interface SearchPartnerToAdd ()

@end

@implementation SearchPartnerToAdd
{
    NSArray *searchResults;
    NSArray *partnersList;
}


@synthesize partnersTableView;
@synthesize allPartners;
@synthesize searchBar;
@synthesize searchDisplayController;

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
    
    partnersList = self.allPartners;
    
    CGRect usableSpace = [[UIScreen mainScreen] applicationFrame];
    CGFloat usableWidth = usableSpace.size.width;
    CGFloat usableHeight = usableSpace.size.height;
    
    partnersTableView = [[UITableView alloc] init];
    [partnersTableView setFrame:CGRectMake(0,0,usableWidth, usableHeight)];
    //    [tableView setFrame:CGRectMake(20, 20, 280, 320)];
    partnersTableView.dataSource = self;
    partnersTableView.delegate = self;
    [self.view addSubview:partnersTableView];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
     self.searchDisplayController = [[MySearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    
    self.searchDisplayController.delegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    
    self.partnersTableView.tableHeaderView = searchBar.self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [partnersList count];
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    static NSString *simpleTableIdentifier = @"EditInformationCell";
    
    //    EditInformationCell *cell = (EditInformationCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    //
    //    if (cell == nil)
    //    {
    //        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EditInformationCell" owner:self options:nil];
    //        cell = [nib objectAtIndex:0];
    //    }
    //
    //    NSString *singlePartner = [allPartners objectAtIndex:indexPath.row];
    //    NSString *singlePartnerName = [singlePartner valueForKey:@"PartnersName"];
    //    cell.textLabel.text = singlePartnerName;
    //
    //    return cell;
    //
    
    //
    
    static NSString *simpleTableIdentifier = @"EditInformationCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    } else {
        
        cell.textLabel.text = [partnersList objectAtIndex:indexPath.row];
        
    }
    
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchResults = [partnersList filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    // This method has been called when u enter some text on search or Cancel the search.
    // so make some condition for example:
    
    if([searchText isEqualToString:@""] || searchText==nil) {
        // Nothing to search, empty result.
        
        [partnersTableView reloadData];
    }
}



- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)TsearchBar
{
    self.searchBar.showsCancelButton = YES;
    [TsearchBar setShowsScopeBar:YES];
    return YES;
}



@end
