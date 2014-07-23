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
    
    getUI = [MLUI new];
    rate = [KpRates new];
    
    rate.delegate = self;
    
    self.tabBarController.navigationItem.title = @"MLKP RATES";
    //self.tabBarController.navigationItem.titleView = [getUI navTitle:@"MLKP Rates"];
    self.tabBarController.navigationItem.hidesBackButton = YES;
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
    [self swipe];
    
    //WaitScreen
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    
    [rate loadRates];
}

- (void)didFinishLoadingRates:(NSString *)indicator{
    
    [HUD hide:YES];
    [HUD show:NO];
    
    NSArray *ratess       = [rate.getRates objectForKey:@"getChargeValuesResult"];
    getValueRates         = [ratess valueForKey:@"<chargeList>k__BackingField"];
    NSString *respcode    = [ratess valueForKey:@"<respcode>k__BackingField"];
    NSString *respmessage = [ratess valueForKey:@"<respmessage>k__BackingField"];
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", respcode]isEqualToString:@"1"]){
        
        charges = [NSMutableArray new];
        amount = [NSMutableArray new];
        
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
    
    [self.tableView reloadData];
}

-(void)swipe{
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(left)];
    
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}

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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"MLKP Rates";
    self.tabBarController.navigationItem.hidesBackButton = YES;
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}

@end
