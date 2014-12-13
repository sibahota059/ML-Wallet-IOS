//
//  SelectBillsPayPartners.m
//  ML Wallet
//
//  Created by mm20-18 on 12/9/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "SelectBillsPayPartners.h"
#import "SearchPartnerToAdd.h"
#import "EditInformationCell.h"
#import "SearchPartnerToAdd.h"
#import "DimLightDialogBackground.h"

@interface SelectBillsPayPartners ()

@end

@implementation SelectBillsPayPartners
{
    NSMutableArray *allPartners;
    NSArray *testData;
    NSArray *searchResults;
    NSArray *partnersList;
}

@synthesize partnersTableView;

GetAllPartnerWS *getAllPartnerWs;
MBProgressHUD *HUD;

UIView *backgroundDim;

SearchPartnerToAdd *searchPartnersToAdd;
UISearchDisplayController *setSearchController;


DimLightDialogBackground *dialogBackground;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    testData = [[NSArray alloc] init];
    getAllPartnerWs = [GetAllPartnerWS new];
    getAllPartnerWs.delegate = self;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
    
    [self displayProgressBar];
    [getAllPartnerWs loadPartners];

    
    
    //Selected Partner
    UIView *leftMarginSelectedPartner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    UITextField *selectedPartnerTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 20, 200, 26)];
    selectedPartnerTF.layer.cornerRadius = 8.0f;
    selectedPartnerTF.layer.masksToBounds = YES;
    selectedPartnerTF.layer.borderColor=[[UIColor redColor]CGColor];
    selectedPartnerTF.layer.borderWidth = 1.0f;
    selectedPartnerTF.leftView = leftMarginSelectedPartner;
    selectedPartnerTF.leftViewMode = UITextFieldViewModeAlways;
    [selectedPartnerTF setBackgroundColor:[UIColor whiteColor]];
    [selectedPartnerTF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [selectedPartnerTF setPlaceholder:@"Select a partner"];
    [selectedPartnerTF setReturnKeyType:UIReturnKeyDone];
    selectedPartnerTF.delegate = self;
    [selectedPartnerTF setReturnKeyType:UIReturnKeyNext];
    
    
    //SHOW PARTNERS BUTTON
    UIButton *partnersButton = [[UIButton alloc] initWithFrame:CGRectMake(220, 20, 90, 26)];
    [partnersButton setBackgroundImage:[UIImage imageNamed:@"headerbackground.png"] forState:UIControlStateNormal];
    [partnersButton setTitle:@"Partners" forState:UIControlStateNormal];
    [partnersButton setTintColor:[UIColor whiteColor]];
    partnersButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [partnersButton addTarget:self action:@selector(showPartners:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //accountNoLabel
    UILabel *accountNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 66, 280, 25)];
    [accountNoLabel setFont:[UIFont fontWithName:nil size:13.0f]];
    [accountNoLabel setText:@"ACCOUNT NUMBER"];
    
    
    //accountNoTF
    UIView *leftMarginAccountNo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    UITextField *accountNoTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 95, 300, 26)];
    accountNoTF.layer.cornerRadius = 8.0f;
    accountNoTF.layer.masksToBounds = YES;
    accountNoTF.layer.borderColor=[[UIColor redColor]CGColor];
    accountNoTF.layer.borderWidth = 1.0f;
    accountNoTF.leftView = leftMarginAccountNo;
    accountNoTF.leftViewMode = UITextFieldViewModeAlways;
    [accountNoTF setBackgroundColor:[UIColor whiteColor]];
    [accountNoTF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [accountNoTF setPlaceholder:@"Account number"];
    [accountNoTF setReturnKeyType:UIReturnKeyDone];
    accountNoTF.delegate = self;
    [accountNoTF setReturnKeyType:UIReturnKeyNext];

    [self navigationButtons];
    
    [self.view addSubview:selectedPartnerTF];
    [self.view addSubview:accountNoLabel];
    [self.view addSubview:accountNoTF];
    [self.view addSubview:partnersButton];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)navigationButtons{
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"BILLSPAYMENT PARTNER";
    UIBarButtonItem *buttonHome = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backPressed:)];
    
    UIBarButtonItem *buttonSelectReceiver = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"my_save.png"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(save:)];
    
    self.navigationItem.leftBarButtonItem = buttonHome;
    self.navigationItem.rightBarButtonItem = buttonSelectReceiver;
}

-(void)backPressed:(id)sender{
//    self.navigationController.navigationBarHidden = YES;
    [self.navigationController  popViewControllerAnimated:YES];
}

-(void)save:(id)sender{
    SearchPartnerToAdd *searchPartnerToAdd = [[SearchPartnerToAdd alloc] initWithNibName:@"SearchPartnerToAdd" bundle:nil];
    searchPartnerToAdd.allPartners = partnersList;
    [self.navigationController pushViewController:searchPartnerToAdd animated:YES];
}

-(void)showPartners:(id)sender{
    
//    [self displayProgressBar];
//    [getAllPartnerWs loadPartners];
    

    // Fading in the disableViewOverlay
//    self.disableViewOverlay.alpha = 0;
//    [self.view addSubview:self.disableViewOverlay];
//	
    
    
    
    dialogBackground = [[DimLightDialogBackground alloc] init];
    [self.view addSubview:dialogBackground];

    partnersTableView = [[UITableView alloc] init];
    [partnersTableView setFrame:CGRectMake(20,20,280, 400)];
//    [tableView setFrame:CGRectMake(20, 20, 280, 320)];
    partnersTableView.dataSource = self;
    partnersTableView.delegate = self;
    [self.view addSubview:partnersTableView];
    
    partnersSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    partnersSearchBar.delegate = self;
    searchDisplayController = [[MySearchDisplayController alloc] initWithSearchBar:partnersSearchBar contentsController:self];
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    
    self.partnersTableView.tableHeaderView = partnersSearchBar;
    
    [UIView beginAnimations:@"FadeIn" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView commitAnimations];
}

- (void) didFinishLoadingPartners:(NSString *)indicator andError:(NSString *)getError{
    
    UIAlertView *resultAlertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    allPartners = [getAllPartnerWs.getPartners valueForKey:@"ListBillsPayPartners"];
    
    NSMutableArray *retrievePartner = [[NSMutableArray alloc] init];
    
    int i = 0;
    while (i < [allPartners count])
    {
        NSString *singlePartner = [allPartners objectAtIndex:i];
        NSString *singlePartnerName = [singlePartner valueForKey:@"PartnersName"];
        [retrievePartner addObject:singlePartnerName];
        i++;
    }
    
    partnersList = [[NSArray alloc] initWithArray:retrievePartner];
    
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", getAllPartnerWs.respcode]isEqualToString:@"1"]){
        
        [self dismissProgressBar];
        
    }
    else if ([[NSString stringWithFormat:@"%@", getAllPartnerWs.respcode] isEqualToString:@"0"])
        
    {
        [resultAlertView setMessage:getAllPartnerWs.respmessage];
        [resultAlertView show];
    }
    else if ([indicator isEqualToString:@"error"])
    {
        [resultAlertView setMessage:@"Error in retrieving partners."];
        [resultAlertView show];
    }else{
        
        [resultAlertView setMessage:getAllPartnerWs.respmessage];
        [resultAlertView show];
    }
    
    
    
}

- (void)displayProgressBar{
    
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    
}

- (void)dismissProgressBar{
    
    [HUD hide:YES];
    [HUD show:NO];
    
}

// SHOWING ALL THE PARTNERS ==========================================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [partnersList count];
        
    }
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    // Existing code
    // Fading in the disableViewOverlay
   
//	 
//    [UIView beginAnimations:@"FadeIn" context:nil];
//    [UIView setAnimationDuration:0.5];
//    self.disableViewOverlay.alpha = 0.6;
//    [UIView commitAnimations];

    }

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    searchBar.text=@"";

    [partnersTableView reloadData];
    [dialogBackground removeFromSuperview];
    [partnersTableView removeFromSuperview];
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)TsearchBar
{
    
    // Fading in the disableViewOverlay
    
    partnersSearchBar.showsCancelButton = YES;
    [TsearchBar setShowsScopeBar:YES];
    return YES;
}

@end
