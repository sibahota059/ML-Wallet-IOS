//
//  MLRatesTableViewController.m
//  SendMoney
//
//  Created by mm20 on 2/17/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import "MLRatesTableViewController.h"
#import "MLUI.h"
#import "MLRatesTableViewCell.h"

@interface MLRatesTableViewController (){
    
    MLUI *getUI;
    KpRates *rate;
    NSMutableArray *amount, *charges, *getValueRates;
    MBProgressHUD *HUD;
    
}
@end

@implementation MLRatesTableViewController

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
    
    //Create object of MBProgressHUD class, set delegate to this class and add Progress Bar view
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    
    //Display Progress Bar View
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    
    //Create object of MLUI, KpRates class
    getUI = [MLUI new];
    rate = [KpRates new];
    
    //Set the KpRates delegate to this class
    rate.delegate = self;
    
    //Call swipe methods to swipe left
    [self swipe];
    
    //Call the loadRates method of KpRates to retrieve data from webservice
    [rate loadRates];
}

#pragma mark - Retrieve Rates Data from Webservice
- (void)didFinishLoadingRates:(NSString *)indicator{
    
    //Hide Progress Bar
    [HUD hide:YES];
    [HUD show:NO];
    
    //Store the NSDictionary rates data into static array
    NSArray *ratess       = [rate.getRates objectForKey:@"getChargeValuesResult"];
    
    //Store the value of ratess array into mutable array
    getValueRates         = [ratess valueForKey:@"<chargeList>k__BackingField"];
    
    //Get the value of respcode & respmessage in retrieving rates
    NSString *respcode    = [ratess valueForKey:@"<respcode>k__BackingField"];
    NSString *respmessage = [ratess valueForKey:@"<respmessage>k__BackingField"];
    
    //Check if retrieving rates is successful or not and if successful, stored in charges and amount mutable array
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", respcode]isEqualToString:@"1"]){
        
        //Create an object of charges & amount mutable array
        charges = [NSMutableArray new];
        amount = [NSMutableArray new];
        
        //Looping rates value and add to charges & amount array
        for (NSDictionary *items in getValueRates) {
            
            NSString *minAmount  = [items valueForKey:@"minAmount"];
            NSString *maxAmount  = [items valueForKey:@"maxAmount"];
            NSString *ch  = [items valueForKey:@"chargeValue"];
            
            
            [charges addObject:ch];
            [amount addObject:[NSString stringWithFormat:@"%@ - %@", minAmount, maxAmount]];
            
        }
        
    }else if ([[NSString stringWithFormat:@"%@", respcode] isEqualToString:@"0"]){
        [getUI displayAlert:@"Message" message:[NSString stringWithFormat:@"%@", respmessage]];
    }else{
        [getUI displayAlert:@"Message" message:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948"];
    }
    
    //reload tableview after retrieving
    [self.tableView reloadData];
}

#pragma mark - Create Gesture to swipe left
-(void)swipe{
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(left)];
    
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}

#pragma mark - Set Tab 1
- (void)left{
    self.tabBarController.selectedIndex = 0;
    [self.navigationController.tabBarController.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Hide Status Bar
- (BOOL)prefersStatusBarHidden{
    return YES;
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
    return [charges count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"rates";
    
    MLRatesTableViewCell *cell = (MLRatesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MLRatesTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    NSString *charge = [charges objectAtIndex:[indexPath row]];
    NSString *min = [amount objectAtIndex:[indexPath row]];
    //NSString *max = [maxAmounts objectAtIndex:[indexPath row]];
    
    cell.labelRates.text   = [NSString stringWithFormat:@"%2@.00", charge ];
    cell.labelAmount.text    = min;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        return 44;
    }
    
    return 70;
    
}

#pragma mark - Set Up Rates Navigation
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"MLKP RATES";
    self.tabBarController.navigationItem.hidesBackButton = YES;
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}

@end
