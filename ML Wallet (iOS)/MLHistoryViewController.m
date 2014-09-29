//
//  MLHistoryViewController.m
//  SendMoney
//
//  Created by mm20 on 3/3/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import "MLHistoryViewController.h"
#import "MLHistoryTableViewCell.h"
#import "MLUI.h"
#import "LoadHistory.h"
#import "NSDictionary+LoadWalletData.h"
#import <CoreLocation/CoreLocation.h>
#import "DeviceID.h"
#import "UIAlertView+alertMe.h"

@interface MLHistoryViewController (){

    UIBarButtonItem *back, *right, * rightPending;
    MLUI *getUI;
    LoadHistory *loadHistory;
    CheckPin *chk;
    SoCancel *sc;
    NSDictionary *dic;
    NSString *walletno, *statusInd, *confirmInd;
    MBProgressHUD *HUD;
    NSMutableArray *getLoadHistory, *getDate, *getType, *getAmmount, *getBalance, *getReceiverName, *getKptn, *getStatus, *getDateP, *getTypeP, *getAmmountP, *getBalanceP, *getReceiverNameP, *getKptnP, *getStatusP;
    CLLocationManager *locationManager;
    DeviceID *di;
    PrintTransaction *pt;
    int transCounter;
    
}

@end

@implementation MLHistoryViewController

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
    
    //Create object of MLUI, NSDictionary+LoadWalletData, & LoadHistory class
    getUI       = [MLUI new];
    loadHistory = [LoadHistory new];
    chk         = [CheckPin new];
    sc          = [SoCancel new];
    dic         = [NSDictionary initRead_LoadWallet_Data];
    di          = [DeviceID new];
    pt          = [PrintTransaction new];
    
    chk.delegate = self;
    pt.delegate  = self;
    
    //Create object of MBProgressHUD class and add progress dialog view
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    
    //Display the Progress Dialog
    [self displayProgressBar];
    
    //Create object of CLLocationManager to get the location, latitude, longitude
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    
    //Get the value of walletno in Property List
    walletno = [dic objectForKey:@"walletno"];
    
    //Show the navigation bar
    self.navigationController.navigationBarHidden = NO;

    //Create object of navigation bar button
    back = [getUI navBarButtonHistory:self navLink:@selector(btn_back:) imageNamed:@"home.png"];
    right = [getUI navBarButtonHistory:self navLink:@selector(btn_sendPreview:) imageNamed:@"ic_print.png"];
    rightPending = [getUI navBarButtonHistory:self navLink:@selector(btn_pending:) imageNamed:@"ic_pending.png"];
    
    //Set background image of the view
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    
    //Setting navigationbar button
    [self.navigationItem setLeftBarButtonItem:back];
    self.navigationItem.rightBarButtonItems = @[right,rightPending];
    
    //Set Title
    self.title = @"HISTORY";
    
    sc.delegate = self;
    loadHistory.delegate = self;
    [loadHistory getUserWalletNo:walletno];
    
    statusInd = @"all";
    [self setTextField:_tf_pin1];
    
    
    self.view_keyboard.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    self.view_pinInput.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
}

#pragma mark - Done loading transaction
- (void)didFinishLoadingHistory:(NSString *)indicator andError:(NSString *)getError{
    
    //Store the NSDictionary rates data into static array
    NSArray *ratess       = [loadHistory.getHistory objectForKey:@"sendoutTopUpHistoryResult"];
    
    //Store the value of ratess array into mutable array
    getLoadHistory         = [ratess valueForKey:@"<historyList>k__BackingField"];
    
    //Get the value of respcode & respmessage in retrieving rates
    NSString *respcode    = [ratess valueForKey:@"<respcode>k__BackingField"];
    //NSString *respmessage = [ratess valueForKey:@"<respmessage>k__BackingField"];
    
    //Check if retrieving rates is successful or not and if successful, stored in charges and amount mutable array
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", respcode]isEqualToString:@"1"]){
        
        //Create an object of charges & amount mutable array
        getDate         = [NSMutableArray new];
        getType         = [NSMutableArray new];
        getAmmount      = [NSMutableArray new];
        getBalance      = [NSMutableArray new];
        getReceiverName = [NSMutableArray new];
        getKptn         = [NSMutableArray new];
        getStatus       = [NSMutableArray new];
        
        getDateP         = [NSMutableArray new];
        getTypeP         = [NSMutableArray new];
        getAmmountP      = [NSMutableArray new];
        getBalanceP      = [NSMutableArray new];
        getReceiverNameP = [NSMutableArray new];
        getKptnP         = [NSMutableArray new];
        getStatusP       = [NSMutableArray new];
     
        //Looping rates value and add to charges & amount array
        for (NSDictionary *items in getLoadHistory) {
            
            NSString *name  = [NSString stringWithFormat:@"%@, %@ %@", [items valueForKey:@"lname"], [items valueForKey:@"fname"], [items valueForKey:@"mname"]];
            NSString *dates  = [items valueForKey:@"txndate"];
            NSString *types  = [items valueForKey:@"transtype"];
            NSString *ammount  = [items valueForKey:@"principal"];
            NSString *bal  = [items valueForKey:@"runningbalance"];
            NSString *receiverName  = name;
            NSString *kptn  = [items valueForKey:@"kptn"];
            NSString *status  = [items valueForKey:@"status"];
            
            if ([[NSString stringWithFormat:@"%@", status] isEqualToString:@"PENDING"]) {
                
                [getDateP addObject:dates];
                [getTypeP addObject:types];
                [getAmmountP addObject:ammount];
                [getBalanceP addObject:bal];
                [getReceiverNameP addObject:receiverName];
                [getKptnP addObject:kptn];
                [getStatusP addObject:status];
                
            }
            
                [getDate addObject:dates];
                [getType addObject:types];
                [getAmmount addObject:ammount];
                [getBalance addObject:bal];
                [getReceiverName addObject:receiverName];
                [getKptn addObject:kptn];
                [getStatus addObject:status];
           
            
        }
        
        transCounter += 1;
        
    }else if ([[NSString stringWithFormat:@"%@", respcode] isEqualToString:@"0"]){
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"You have no transaction for this month." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if ([indicator isEqualToString:@"error"]){
        
        confirmInd = @"loadHistory";
        [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
        
    }else{
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
    //reload tableview after retrieving
    [self.tblHistory reloadData];

    
    //dismiss the progress dialog
    [self dismissProgressBar];
    
}

#pragma mark - Back Button Pressed
- (IBAction)btn_back:(id)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Send Email PDF Transaction
- (IBAction)btn_sendPreview:(id)sender {

    confirmInd = @"pdf";
    [self confirmDialog:@"Message" andMessage:@"This will send all your transaction history to your email. Click OK to proceed." andButtonNameOK:@"OK" andButtonNameCancel:@"No, Thanks"];
    
}

- (void)didFinishLoadingTransaction:(NSString *)indicator andError:(NSString *)getError{
    
    self.navigationItem.leftBarButtonItem.enabled = YES;
    for(UIBarButtonItem *button in self.navigationItem.rightBarButtonItems) {
        button.enabled = YES;
    }
    
    //dismiss the progress dialog
    [self dismissProgressBar];
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", pt.respcode] isEqualToString:@"1"]) {
        [UIAlertView myCostumeAlert:@"Message" alertMessage:pt.respmessage delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if([[NSString stringWithFormat:@"%@", pt.respcode] isEqualToString:@"0"]){
        [UIAlertView myCostumeAlert:@"Message" alertMessage:pt.respmessage delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if([indicator isEqualToString:@"error"]){
        [UIAlertView myCostumeAlert:@"Message" alertMessage:getError delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else{
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
}

#pragma mark - Display List Pending Transaction Button Pressed
- (IBAction)btn_pending:(id)sender {
    
    
    if ([statusInd isEqualToString:@"pending"]) {
        
        [self displayProgressBar];
        
        statusInd = @"all";
        rightPending = [getUI navBarButtonHistory:self navLink:@selector(btn_pending:) imageNamed:@"ic_pending.png"];
        [self.tblHistory reloadData];
        self.title = @"HISTORY";

        
    }else{
        
        [self displayProgressBar];
        
        statusInd = @"pending";
        rightPending = [getUI navBarButtonHistory:self navLink:@selector(btn_pending:) imageNamed:@"ic_all.png"];
        [self.tblHistory reloadData];
        self.title = @"PENDING";
        
        
    }
    
    self.navigationItem.rightBarButtonItems = @[right,rightPending];
    
    //dismiss the progress dialog
    [self dismissProgressBar];
}

#pragma mark - Hide Status Bar
- (BOOL)prefersStatusBarHidden{
    return YES;
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
    
    if ([[NSString stringWithFormat:@"%@", statusInd] isEqualToString:@"pending"]) {
        
        return [getDateP count];
        
    }
        return [getDate count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"history";
    
    MLHistoryTableViewCell *cell = (MLHistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MLHistoryTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *date, *type, *ammount, *balance;
    
    if ([[NSString stringWithFormat:@"%@", statusInd] isEqualToString:@"pending"]) {
        
        date = [getDateP objectAtIndex:[indexPath row]];
        type = [getTypeP objectAtIndex:[indexPath row]];
        ammount = [getAmmountP objectAtIndex:[indexPath row]];
        balance = [getBalanceP objectAtIndex:[indexPath row]];
        
    }else{
        
        date = [getDate objectAtIndex:[indexPath row]];
        type = [getType objectAtIndex:[indexPath row]];
        ammount = [getAmmount objectAtIndex:[indexPath row]];
        balance = [getBalance objectAtIndex:[indexPath row]];
    }
    
    
    NSArray * arrDate = [date componentsSeparatedByString:@" "];

    if ([type isEqualToString:@"CANCEL"]) {
        cell.labelType.text    = @"CANCELLED";
    }else{
        cell.labelType.text    = [NSString stringWithFormat:@"%@", type];
    }
    cell.labelDate.text    = [NSString stringWithFormat:@"%@", arrDate[0]];
    cell.labelAmount.text  = [NSString stringWithFormat:@"%0.2f", [ammount doubleValue]];
    cell.labelBalance.text = [NSString stringWithFormat:@"%0.2f", [balance doubleValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _view_fade.hidden = NO;
    _view_fade.alpha = 0.2f;
    _view_transform.hidden = NO;
    
    
    if ([[NSString stringWithFormat:@"%@", statusInd] isEqualToString:@"pending"]) {
        
        _labelName.text = [[getReceiverNameP objectAtIndex:indexPath.row] uppercaseString];
        _labelKptn.text = [getKptnP objectAtIndex:indexPath.row];
        _labelReceiverId.text = walletno;
        _labelDate.text = [self getDate:[getDateP objectAtIndex:indexPath.row]];
        
        if ([[getTypeP objectAtIndex:indexPath.row] isEqualToString:@"CANCEL"]) {
            _labelType.text = @"CANCELLED";
            _btn_cancel.hidden = YES;
        }else{
            _labelType.text = [getTypeP objectAtIndex:indexPath.row];
            _btn_cancel.hidden = NO;
        }
        
        if ([[NSString stringWithFormat:@"%@", [getStatusP objectAtIndex:indexPath.row]] isEqualToString:@"PENDING"]) {
            _img_status.image = [UIImage imageNamed:@"ic_seal_pending.png"];
        }else if ([[NSString stringWithFormat:@"%@", [getStatusP objectAtIndex:indexPath.row]] isEqualToString:@"CLAIMED"]){
            _img_status.image = [UIImage imageNamed:@"ic_seal_claimed.png"];
        }else{
            _img_status.image = [UIImage imageNamed:@"ic_seal_cancelled.png"];
        }
        
    }else{
        
        _labelName.text = [[getReceiverName objectAtIndex:indexPath.row]uppercaseString];
        _labelKptn.text = [getKptn objectAtIndex:indexPath.row];
        _labelReceiverId.text = walletno;
        _labelDate.text = [self getDate:[getDate objectAtIndex:indexPath.row]];
        
        if ([[getStatus objectAtIndex:indexPath.row] isEqualToString:@"CANCEL"]) {
            _labelType.text = @"CANCELLED";
            _btn_cancel.hidden = YES;
        }else if ([[getStatus objectAtIndex:indexPath.row] isEqualToString:@"CLAIMED"]){
            _labelType.text = [getType objectAtIndex:indexPath.row];
            _btn_cancel.hidden = YES;
        }else if ([[getStatus objectAtIndex:indexPath.row] isEqualToString:@"LOADING"]){
//            NSString* cleanedString = [[[[getReceiverName objectAtIndex:indexPath.row]uppercaseString] stringByReplacingOccurrencesOfString:@"," withString:@""]
//                                       stringByTrimmingCharactersInSet: [NSCharacterSet symbolCharacterSet]];
//            _labelName.text = cleanedString;
            _labelType.text = [getType objectAtIndex:indexPath.row];
            _btn_cancel.hidden = YES;
        }else{
            _labelType.text = [getType objectAtIndex:indexPath.row];
            _btn_cancel.hidden = NO;
        }

        NSString *getRStatus = [getStatus objectAtIndex:indexPath.row];
        
        if ([[NSString stringWithFormat:@"%@", getRStatus] isEqualToString:@"PENDING"]) {
            _img_status.image = [UIImage imageNamed:@"ic_seal_pending.png"];
        }else if ([[NSString stringWithFormat:@"%@", [getStatus objectAtIndex:indexPath.row]] isEqualToString:@"CLAIMED"]){
            _img_status.image = [UIImage imageNamed:@"ic_seal_claimed.png"];
        }else if ([[NSString stringWithFormat:@"%@", [getStatus objectAtIndex:indexPath.row]] isEqualToString:@"LOADING"]){
            _img_status.image = [UIImage imageNamed:@"ic_seal_claimed.png"];
        }else{
            _img_status.image = [UIImage imageNamed:@"ic_seal_cancelled.png"];
        }
        
    }
    
    
    

    
    [self shadowView:_view_transform];

    self.navigationItem.leftBarButtonItem.enabled = NO;
    for(UIBarButtonItem *button in self.navigationItem.rightBarButtonItems) {
        button.enabled = NO;
    }
}

- (NSString *)getDate:(NSString *)defaultString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    NSDate *date = [formatter dateFromString:defaultString];
    [formatter setDateFormat:@"MMMM dd, yyyy"];
    NSString *newDate = [formatter stringFromDate:date];
    return newDate;
}

- (UIView *)shadowView:(UIView*)viewContent{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:viewContent.bounds];
    viewContent.layer.masksToBounds = NO;
    viewContent.layer.shadowColor = [UIColor blackColor].CGColor;
    viewContent.layer.shadowOffset = CGSizeMake(0.0f, 8.0f);
    viewContent.layer.shadowOpacity = 0.32f;
    viewContent.layer.shadowPath = shadowPath.CGPath;
    
    return viewContent;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return 70;
    }
    return 44;
}

#pragma mark - Dismiss Preview View
- (IBAction)btnClose:(id)sender {
    _view_fade.hidden = YES;
    _view_transform.hidden = YES;
    self.view_keyboard.hidden = YES;
    self.view_pinInput.hidden = YES;
    
    self.navigationItem.leftBarButtonItem.enabled = YES;
    for(UIBarButtonItem *button in self.navigationItem.rightBarButtonItems) {
        button.enabled = YES;
    }
}



- (IBAction)btn_cancel:(id)sender {

    confirmInd = @"cancel";
    [self confirmDialog:@"Message" andMessage:@"Are you sure to cancel this transaction?" andButtonNameOK:@"Yes" andButtonNameCancel:@"No, Thanks"];
    
}

- (void)btnPin{
    
    confirmInd = @"pin";
    
    NSString *pin = [NSString stringWithFormat:@"%@%@%@%@", _tf_pin1.text, _tf_pin2.text, _tf_pin3.text, _tf_pin4.text];
    
    NSUInteger pinCount = pin.length;
    
    if (pinCount == 4) {
        
        //call webservice to check if inputted pin is correct
        [chk getReceiverWalletNo:walletno andReceiverPinNo:pin];
        
        //display progress dialog
        [self displayProgressBar];
        
    }else{
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Pin must be 4 characters!" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
   
}

- (void)didFinishLoadingPin:(NSString *)indicator andError:(NSString *)getError{
    
    //get the results of pin request
    NSDictionary* _getPin = [chk.getPin objectForKey:@"checkPinResult"];
    
    //extract dictionary and get value for repscode & respmessage
    NSString* repscode = [_getPin objectForKey:@"respcode"];
    NSString* respmessage = [_getPin objectForKey:@"respmessage"];
    
    //if requesting pin is successful go to next page, else display error message
    if ([[NSString stringWithFormat:@"%@", repscode] isEqualToString:@"1"]) {
        
        [sc soCancel:walletno andKptn:_labelKptn.text andLatitude:[NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude] andLongitude:[NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude] andDeviceId:di.NSGetDeviceID andLocation:[dic objectForKey:@"address"]];
        
        //[self reset];
    }else if([indicator isEqualToString:@"error"]){
        
        [self dismissProgressBar];
        [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
        
    }else if ([[NSString stringWithFormat:@"%@", repscode] isEqualToString:@"0"]){
        [UIAlertView myCostumeAlert:@"Message" alertMessage:respmessage delegate:nil cancelButton:@"Ok" otherButtons:nil];
        [self dismissProgressBar];
        [self reset];
    }else if ([[NSString stringWithFormat:@"%@", repscode] isEqualToString:@"3"]){
        [UIAlertView myCostumeAlert:@"Message" alertMessage:respmessage delegate:nil cancelButton:@"Ok" otherButtons:nil];
        [self dismissProgressBar];
        [self.navigationController popToRootViewControllerAnimated:YES];
        self.navigationController.navigationBarHidden = YES;

    }else{
        [self dismissProgressBar];
        [UIAlertView myCostumeAlert:@"Message" alertMessage:respmessage delegate:nil cancelButton:@"Ok" otherButtons:nil];
        [self reset];
    }
    
}

- (void)didFinishLoadingCancellation:(NSString *)indicator andError:(NSString *)getError{

    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", sc.respcode]isEqualToString:@"1"]){
        
        [loadHistory getUserWalletNo:walletno];

        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Sendout Successfully Cancelled. Just kindly check your balance." delegate:nil cancelButton:@"Ok" otherButtons:nil];
        
        self.view_pinInput.alpha = 1.0;
        self.view_keyboard.alpha = 1.0;
        self.view_inputted.alpha = 1.0;
        
        [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.view_pinInput.alpha = 0.0;
            self.view_keyboard.alpha = 0.0;
            self.view_inputted.alpha = 0.0;
            self.view_transform.alpha = 1.0;
            
        }completion:^(BOOL finished) {
            
        }];
        
        self.view_transform.hidden = YES;
        
        if ([statusInd isEqualToString:@"pending"]) {
            rightPending = [getUI navBarButtonHistory:self navLink:@selector(btn_pending:) imageNamed:@"ic_all.png"];
            self.title = @"PENDING";
        }else{
            rightPending = [getUI navBarButtonHistory:self navLink:@selector(btn_pending:) imageNamed:@"ic_pending.png"];
            self.title = @"HISTORY";
        }
        
        right = [getUI navBarButtonHistory:self navLink:@selector(btn_sendPreview:) imageNamed:@"ic_print.png"];
        
        self.navigationItem.rightBarButtonItems = @[right,rightPending];
        self.navigationItem.leftBarButtonItem.enabled = YES;
        for(UIBarButtonItem *button in self.navigationItem.rightBarButtonItems) {
            button.enabled = YES;
        }
        _view_fade.hidden = YES;
        [self reset];
        
    }else if ([[NSString stringWithFormat:@"%@", sc.respcode] isEqualToString:@"0"]){
        
        [UIAlertView myCostumeAlert:@"Message" alertMessage:[NSString stringWithFormat:@"%@", sc.respmessage] delegate:nil cancelButton:@"Ok" otherButtons:nil];
        
    }else if([indicator isEqualToString:@"error"]){
        
        [self dismissProgressBar];
        [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
    
    }else{
        
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }

}

- (IBAction)didTapSurface:(UITapGestureRecognizer *)sender {

    self.view_pinInput.alpha = 1.0;
    self.view_keyboard.alpha = 1.0;
    self.view_inputted.alpha = 1.0;
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{

        self.view_pinInput.alpha = 0.0;
        self.view_keyboard.alpha = 0.0;
        self.view_inputted.alpha = 0.0;
        self.view_transform.alpha = 1.0;

    }completion:^(BOOL finished) {
        
    }];
    
    self.view_transform.hidden = NO;
    
    if ([statusInd isEqualToString:@"pending"]) {
        rightPending = [getUI navBarButtonHistory:self navLink:@selector(btn_pending:) imageNamed:@"ic_all.png"];
        self.title = @"PENDING";
    }else{
        rightPending = [getUI navBarButtonHistory:self navLink:@selector(btn_pending:) imageNamed:@"ic_pending.png"];
        self.title = @"HISTORY";
    }
    
    right = [getUI navBarButtonHistory:self navLink:@selector(btn_sendPreview:) imageNamed:@"ic_print.png"];
    
    self.navigationItem.rightBarButtonItems = @[right,rightPending];
    for(UIBarButtonItem *button in self.navigationItem.rightBarButtonItems) {
        button.enabled = NO;
    }
    
    [self reset];
    
}

- (UITextField *)toBeInputted{
    
    UITextField *checkNext;
    
    if(![_tf_pin1.text isEqualToString:@""]){
        checkNext = _tf_pin2;
    }
    
    if(![_tf_pin2.text isEqualToString:@""]){
        checkNext = _tf_pin3;
    }
    
    if(![_tf_pin3.text isEqualToString:@""]){
        checkNext = _tf_pin4;
    }
    
    if(![_tf_pin4.text isEqualToString:@""]){
        _btnOne.enabled = NO;
        _btnTwo.enabled = NO;
        _btnThree.enabled = NO;
        _btnFour.enabled = NO;
        _btnFive.enabled = NO;
        _btnSix.enabled = NO;
        _btnSeven.enabled = NO;
        _btnEight.enabled = NO;
        _btnNine.enabled = NO;
        _btnZero.enabled = NO;
    }
    
    return checkNext;
    
}
- (IBAction)btnOne:(id)sender {
    [self getTextField].text = @"1";
    [self setTextField:[self toBeInputted]];
}

- (IBAction)btnTwo:(id)sender {
    [self getTextField].text = @"2";
    [self setTextField:[self toBeInputted]];
}

- (IBAction)btnThree:(id)sender {
    [self getTextField].text = @"3";
    [self setTextField:[self toBeInputted]];
}

- (IBAction)btnFour:(id)sender {
    [self getTextField].text = @"4";
    [self setTextField:[self toBeInputted]];
}

- (IBAction)btnFive:(id)sender {
    [self getTextField].text = @"5";
    [self setTextField:[self toBeInputted]];
}

- (IBAction)btnSix:(id)sender {
    [self getTextField].text = @"6";
    [self setTextField:[self toBeInputted]];
}

- (IBAction)btnSeven:(id)sender {
    [self getTextField].text = @"7";
    [self setTextField:[self toBeInputted]];
}

- (IBAction)btnEight:(id)sender {
    [self getTextField].text = @"8";
    [self setTextField:[self toBeInputted]];
}

- (IBAction)btnNine:(id)sender {
    [self getTextField].text = @"9";
    [self setTextField:[self toBeInputted]];
}

- (IBAction)btnZero:(id)sender {
    [self getTextField].text = @"0";
    [self setTextField:[self toBeInputted]];
}

- (IBAction)btnClear:(id)sender {
    [self reset];
}

- (void)reset{
    
    _tf_pin1.text = @"";
    _tf_pin2.text = @"";
    _tf_pin3.text = @"";
    _tf_pin4.text = @"";
    
    _btnOne.enabled = YES;
    _btnTwo.enabled = YES;
    _btnThree.enabled = YES;
    _btnFour.enabled = YES;
    _btnFive.enabled = YES;
    _btnSix.enabled = YES;
    _btnSeven.enabled = YES;
    _btnEight.enabled = YES;
    _btnNine.enabled = YES;
    _btnZero.enabled = YES;
    
    [self setTextField:_tf_pin1];
    
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
        
        if ([confirmInd isEqualToString:@"cancel"]) {
         
        self.view_pinInput.alpha = 0.0;
        self.view_keyboard.alpha = 0.0;
        self.view_inputted.alpha = 0.0;
        //self.btn_pin.hidden = YES;
        
        [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _view_keyboard.hidden = NO;
            self.view_pinInput.alpha = 1.0;
            self.view_keyboard.alpha = 1.0;
            self.view_inputted.alpha = 1.0;
        }completion:^(BOOL finished) {
            
        }];
        
        [_view_pinInput setAlpha:0.9f];
        self.navigationItem.rightBarButtonItems = nil;
        
        self.title = @"ENTER YOUR PIN";
            
        UIBarButtonItem *next = [[UIBarButtonItem alloc]
                    initWithTitle:@"Next"
                    style:UIBarButtonItemStyleBordered
                    target:self
                    action:@selector(btnPin)];
        self.navigationItem.rightBarButtonItem = next;
            
        _view_pinInput.hidden = NO;
        _view_inputted.hidden = NO;
            
            
        }else if ([confirmInd isEqualToString:@"loadHistory"]){
            
            [self displayProgressBar];
            [loadHistory getUserWalletNo:walletno];
            
        }else if ([confirmInd isEqualToString:@"pin"]){
            
            [self btnPin];
            
        }else{
            
            if (transCounter > 0) {
                //Display the Progress Dialog
                [self displayProgressBar];
                
                [pt getUserWalletNo:walletno];
                
                self.navigationItem.leftBarButtonItem.enabled = NO;
                for(UIBarButtonItem *button in self.navigationItem.rightBarButtonItems) {
                    button.enabled = NO;
                }
            } else {
                [UIAlertView myCostumeAlert:@"Message" alertMessage:@"You have no transactions yet." delegate:nil cancelButton:@"Ok" otherButtons:nil];
            }
            
        }
    }
    else if (buttonIndex == 1) {
        //dismiss dialog
        
        if ([confirmInd isEqualToString:@"loadHistory"]) {
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([confirmInd isEqualToString:@"pin"]){
            [self dismissProgressBar];
            [self reset];
        }
    }
}

@end
