//
//  APPChildViewController.m
//  PageApp
//
//  Created by Rafael Garcia Leiva on 10/06/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "MLRatesAllChildViewController.h"
#import "MLUI.h"
#import "MLRatesTableViewCell.h"
#import "MenuViewController.h"
#import "LoginViewController.h"
#import "UIAlertView+alertMe.h"



@interface MLRatesAllChildViewController (){
    
    MLUI *getUI;
    KpRates *rate;
    KpRatesOwn *rateOwn;
    BOOL isReceiver;
    NSMutableArray *amount, *chargesReceiver, *chargesOwn, *finalGetCharges, *getValueRates;
    MBProgressHUD *HUD;
    NSString *confirmInd;
    UIBarButtonItem *home;
    
}

@end

@implementation MLRatesAllChildViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    rateOwn = [KpRatesOwn new];
    finalGetCharges = [NSMutableArray new];
    
    //Set the KpRates delegate to this class
    rate.delegate = self;
    rateOwn.delegate = self;
    
    //customize the icon for back button and call the btn_back method
    home = [getUI navBarButtonRates:self navLink:@selector(btn_back:) imageNamed:@"back.png"];
    
    //set the bar button home to left
    [self.navigationItem setLeftBarButtonItem:home];
    
    //Call swipe methods to swipe left
    [self swipe];
    
    if (self.index == 0) {
        self.screenNumber.text = [NSString stringWithFormat:@"Send Money Rates"];
        
        //Call the loadRates method of KpRates to retrieve data from webservice
        [rate loadRates:@"getChargeValues"];
        isReceiver = YES;;
        
    }else{
        self.screenNumber.text = [NSString stringWithFormat:@"Cash Out Rates"];
        
        //Call the loadRates method of KpRates to retrieve data from webservice
        [rateOwn loadRates:@"GetWithdrawalCharges"];
        isReceiver = NO;
    }
    
    
    //Register a notification to check  if Transaction is finished
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(chooseTab:) name:@"CheckView" object:nil];
    
}

#pragma mark - Notification Called when Transaction is successful
-(void) chooseTab:(NSNotification *) notification
{

    self.tabBarController.navigationItem.title = @"MLKP RATES";
    //set the bar button home to left
    [self.navigationItem setLeftBarButtonItem:home];
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
    
    //Store the NSDictionary rates data into static array
    //NSArray *ratess = [rate.getRates objectForKey:@"getChargeValuesResult"];
    
    //Store the value of ratess array into mutable array
    //getValueRates         = [ratess valueForKey:@"<chargeList>k__BackingField"];
    
    //Get the value of respcode & respmessage in retrieving rates
    //NSString *respcode    = [ratess valueForKey:@"<respcode>k__BackingField"];
    //NSString *respmessage = [ratess valueForKey:@"<respmessage>k__BackingField"];
    
    getValueRates = [rate.getRates valueForKey:@"chargeList"];
    
    
    //Get the value of respcode and respmessage
    NSString *respcode    = [rate.getRates valueForKey:@"respcode"];
    NSString *respmessage = [rate.getRates valueForKey:@"respmessage"];
    
    //Check if retrieving rates is successful or not and if successful, stored in charges and amount mutable array
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", respcode]isEqualToString:@"1"]){
        
        //Create an object of charges & amount mutable array
        chargesReceiver = [NSMutableArray new];
        amount = [NSMutableArray new];
        
        //Looping rates value and add to charges & amount array
        for (NSDictionary *items in getValueRates) {
            
            NSString *minAmount  = [items valueForKey:@"minAmount"];
            NSString *maxAmount  = [items valueForKey:@"maxAmount"];
            NSString *ch  = [items valueForKey:@"chargeValue"];
            
            
            [chargesReceiver addObject:ch];
            [amount addObject:[NSString stringWithFormat:@"%@ - %@", minAmount, maxAmount]];
            
        }
        
    }else if ([[NSString stringWithFormat:@"%@", respcode] isEqualToString:@"0"]){
        [UIAlertView myCostumeAlert:@"Message" alertMessage:[NSString stringWithFormat:@"%@", respmessage] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if ([indicator isEqualToString:@"error"]){
        confirmInd = @"rates";
        [self dismissProgressBar];
        [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
    }else{
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
    //reload tableview after retrieving
    [_rates_tableview reloadData];
    
    //Hide Progress Bar
    [HUD hide:YES];
    [HUD show:NO];
}


#pragma mark - Retrieve Rates Data from Webservice
- (void)didFinishLoadingRatesOwn:(NSString *)indicator andError:(NSString *)getError{

    getValueRates = [rateOwn.getRates valueForKey:@"chargeList"];
    
    //Get the value of respcode and respmessage
    NSString *respcode    = [rateOwn.getRates valueForKey:@"respcode"];
    NSString *respmessage = [rateOwn.getRates valueForKey:@"respmessage"];
    
    //Check if retrieving rates is successful or not and if successful, stored in charges and amount mutable array
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", respcode]isEqualToString:@"1"]){
        
        //Create an object of charges & amount mutable array
        chargesOwn = [NSMutableArray new];
        amount = [NSMutableArray new];
        
        //Looping rates value and add to charges & amount array
        for (NSDictionary *items in getValueRates) {
            
            NSString *minAmount  = [items valueForKey:@"minAmount"];
            NSString *maxAmount  = [items valueForKey:@"maxAmount"];
            NSString *ch  = [items valueForKey:@"chargeValue"];
            
            
            [chargesOwn addObject:ch];
            [amount addObject:[NSString stringWithFormat:@"%@ - %@", minAmount, maxAmount]];
            
        }
        
    }else if ([[NSString stringWithFormat:@"%@", respcode] isEqualToString:@"0"]){
        [UIAlertView myCostumeAlert:@"Message" alertMessage:[NSString stringWithFormat:@"%@", respmessage] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if ([indicator isEqualToString:@"error"]){
        confirmInd = @"rates";
        [self dismissProgressBar];
        [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
    }else{
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
    //reload tableview after retrieving
    [_rates_tableview reloadData];
    
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

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (isReceiver) {
        return [chargesReceiver count];
    }else{
        return [chargesOwn count];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"rates";
    
    MLRatesTableViewCell *cell = (MLRatesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MLRatesTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if (isReceiver) {
        finalGetCharges = chargesReceiver;
    }else{
        finalGetCharges = chargesOwn;
    }
    
    NSString *charge = [finalGetCharges objectAtIndex:[indexPath row]];
    NSString *min = [amount objectAtIndex:[indexPath row]];
    //NSString *max = [maxAmounts objectAtIndex:[indexPath row]];
    

    NSString *checkRates  = [NSString stringWithFormat:@"%@", charge ];
    
    if ([self doesString:checkRates containCharacter:'.'])
        cell.labelRates.text = [NSString stringWithFormat:@"%2@", charge ];
    else
        cell.labelRates.text = [NSString stringWithFormat:@"%2@.00", charge ];
    
    cell.labelAmount.text    = min;
    
    return cell;
}

-(BOOL)doesString:(NSString *)string containCharacter:(char)character
{
    if ([string rangeOfString:[NSString stringWithFormat:@"%c",character]].location != NSNotFound)
    {
        return YES;
    }
    return NO;
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
        //set the bar button home to left
        [self.navigationItem setLeftBarButtonItem:home];
        self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
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
    
    [self performSelector:@selector(dismiss:) withObject:alert afterDelay:60.0];
    
    [alert show];
    
}

- (void)dismiss:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:-1 animated:YES];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        if ([confirmInd isEqualToString:@"rates"]) {
            [self displayProgressBar];
            [rate loadRates:@"getChargeValues"];
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
