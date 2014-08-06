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
#import "MenuViewController.h"
#import "LoginViewController.h"

@interface MLRatesTableViewController (){
    
    MLUI *getUI;
    KpRates *rate;
    NSMutableArray *amount, *charges, *getValueRates;
    MBProgressHUD *HUD;
    NSString *confirmInd;
    
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
    
    //customize the icon for back button and call the btn_back method
    UIBarButtonItem *home = [getUI navBarButtonRates:self navLink:@selector(btn_back:) imageNamed:@"back.png"];
    
    //set the bar button home to left
    [self.navigationItem setLeftBarButtonItem:home];
    
    //Call swipe methods to swipe left
    [self swipe];
    
    //Call the loadRates method of KpRates to retrieve data from webservice
    [rate loadRates];
    
    
    self.tabBarController.navigationItem.title = @"MLKP RATES";
    self.tabBarController.navigationItem.hidesBackButton = YES;
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
    
    //Register a notification to check  if Transaction is finished
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(chooseTab:) name:@"CheckView" object:nil];
    
    // Initialize the refresh control.
//    self.refreshControl = [[UIRefreshControl alloc] init];
//    self.refreshControl.backgroundColor = [UIColor purpleColor];
//    self.refreshControl.tintColor = [UIColor whiteColor];
//    [self.refreshControl addTarget:self
//                            action:@selector(refresher)
//                  forControlEvents:UIControlEventValueChanged];
    
    
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
    
}

- (void)refresher{
    [rate loadRates];
}

#pragma mark - Notification Called when Transaction is successful
-(void) chooseTab:(NSNotification *) notification
{

    self.tabBarController.navigationItem.title = @"MLKP RATES";
    self.tabBarController.navigationItem.hidesBackButton = YES;
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
}

#pragma mark - Back Button
- (IBAction)btn_back:(id)sender {
    
    NSLog(@"%@", _indicator);
    if ([_indicator isEqualToString:@"login"])
    {
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    else
    {
        self.navigationController.navigationBarHidden = YES;
        MenuViewController *smv = (MenuViewController *)[self.navigationController.viewControllers objectAtIndex:1];
        [self.navigationController popToViewController:smv animated:NO];
    }
    
    
    
}

#pragma mark - Retrieve Rates Data from Webservice
- (void)didFinishLoadingRates:(NSString *)indicator andError:(NSString *)getError{
    
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
    }else if ([indicator isEqualToString:@"error"]){
        confirmInd = @"rates";
        [self dismissProgressBar];
        [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
    }else{
        [getUI displayAlert:@"Message" message:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948"];
    }
    
    //reload tableview after retrieving
    [self.tableView reloadData];
    
    //Hide Progress Bar
    [HUD hide:YES];
    [HUD show:NO];
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
    
    if ([_indicator isEqualToString:@"login"] || [_indicator isEqualToString:@"menu"])
    {
        self.navigationItem.title = @"MLKP RATES";
    }else
    {
        self.tabBarController.navigationItem.title = @"MLKP RATES";
        self.tabBarController.navigationItem.hidesBackButton = YES;
        self.tabBarController.navigationItem.leftBarButtonItem = nil;
        self.tabBarController.navigationItem.rightBarButtonItem = nil;
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

- (void)confirmDialog:(NSString *)title andMessage:(NSString *)message andButtonNameOK:(NSString *)btnOne andButtonNameCancel:(NSString *)btnTwo{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:btnOne otherButtonTitles:btnTwo,nil];
    [alert show];
    
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        if ([confirmInd isEqualToString:@"rates"]) {
            [self displayProgressBar];
            [rate loadRates];
        }
    }
    else if (buttonIndex == 1) {
        if ([_indicator isEqualToString:@"login"]) {
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
}



@end
