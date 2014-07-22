//
//  MLSendMoneyViewController.m
//  SendMoney
//
//  Created by mm20 on 2/17/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import "MLSendMoneyViewController.h"
#import "MLPreviewViewController.h"
#import "MLUI.h"
#import "MLRatesTableViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "NSDictionary+LoadWalletData.h"

@interface MLSendMoneyViewController (){
    UITapGestureRecognizer *tapRecognizer;
    double inputPrint, conv, bal, total, amountValue;
    NSString *string1, *string2, *newString, *getRlname, *getRfname, *getRmname, *getRimage, *getRnumber, *walletno;
    NSArray *checkdot;
    UIImage *right, *wrong;
    MLUI *getUI;
    UIBarButtonItem *next, *home;
    UIImage *image, *payment;
    SendoutMobile *sendout;
    NSMutableData *contentData;
    NSURLConnection *conn;
    KpRates *rates;
    GetReceiver *getReceiver;
    NSMutableArray *getValueRates, *getValueReceiver;
    NSDictionary *getCharges, *getReceivers, *dic;
    MBProgressHUD *HUD;
    CLLocationManager *locationManager;
}

@end

@implementation MLSendMoneyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.tabBarController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //WaitScreen
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    
    // Do any additional setup after loading the view from its nib.
    getUI = [MLUI new];
    rates = [KpRates new];
    getReceiver = [GetReceiver new];
    
    getReceiver.delegate = self;
    self.tabBarController.navigationItem.title = @"Send Money";
    //self.tabBarController.navigationItem.titleView = [getUI navTitle:@"Send Money"];
    
    wrong = [UIImage imageNamed:@"wrong.png"];
    right = [UIImage imageNamed:@"right.png"];
    
    //create a bar button
    next = [getUI navBarButton:self navLink:@selector(btn_preview:) imageNamed:@"next.png"];
    home = [getUI navBarButton:self navLink:@selector(btn_back:) imageNamed:@"home.png"];
    
    [self.tabBarController.navigationItem setRightBarButtonItem:next];
    [self.tabBarController.navigationItem setLeftBarButtonItem:home];
    
    [self setUpReceivers];
    
    self.view_main.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    _label_balance.font = [UIFont boldSystemFontOfSize:24.0f];
    _chargeValue.font = [UIFont boldSystemFontOfSize:24.0f];
    _totalValue.font = [UIFont boldSystemFontOfSize:24.0f];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        image = [UIImage imageNamed:@"content_bg"];
        payment = [UIImage imageNamed:@"payment_bg"];
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        image = [UIImage imageNamed:@"content_bg_ipad"];
        payment = [UIImage imageNamed:@"payment_bg_ipad"];
    }
    
    
    self.view_sender.backgroundColor = [UIColor colorWithPatternImage:image];
    self.view_receiver.backgroundColor = [UIColor colorWithPatternImage:image];
    self.view_charge.backgroundColor = [UIColor colorWithPatternImage:payment];
    self.view_total.backgroundColor = [UIColor colorWithPatternImage:payment];
    
    [self swipe];
    [self keyboardNotification];
    
    rates.delegate = self;
    getReceiver.delegate = self;
    
    [rates loadRates];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    
    dic = [NSDictionary initRead_LoadWallet_Data];
    walletno = [dic objectForKey:@"walletno"];
    [self aboutSender];
    
}

#pragma mark - Sender Info
- (void)aboutSender{

    NSString *smname;
    if ([[NSString stringWithFormat:@"%@", [dic objectForKey:@"mname"]] isEqualToString:@""]) {
        smname = @"";
    }else{
        smname = [NSString stringWithFormat:@"%@.", [self capitalizeFirstChar:[[[dic objectForKey:@"mname"] substringToIndex:1] lowercaseString]]];
    }
    
    _senderName.text = [NSString stringWithFormat:@"%@, %@ %@", [self capitalizeFirstChar:[[dic objectForKey:@"lname"] lowercaseString]], [self capitalizeFirstChar:[[dic objectForKey:@"fname"] lowercaseString]], smname];
    _senderAddress.text = [dic objectForKey:@"address"];
    _label_balance.text = [NSString stringWithFormat:@"%@", [self convertDecimal:[[dic objectForKey:@"balance"] doubleValue]]];
    //_label_balance.text = [NSString stringWithFormat:@"%0.2f", [[dic objectForKey:@"balance"] doubleValue]];
    NSData *data = [[NSData alloc] initWithBase64EncodedString:[dic objectForKey:@"photo"] options: NSDataBase64DecodingIgnoreUnknownCharacters];
    
    if ([UIImage imageWithData:data] == nil) {
        _senderImage.image = [UIImage imageNamed:@"noImage.png"];
    }else{
        _senderImage.image = [UIImage imageWithData:data];
    }
    
}

#pragma mark - Capital 1st Letter
- (NSString *)capitalizeFirstChar:(NSString *)str{
    
    NSString *capFirstL = str;
    capFirstL = [capFirstL stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[capFirstL substringToIndex:1] uppercaseString]];
    
    return capFirstL;
}

#pragma mark - Convert to Decimal
- (NSString *)convertDecimal:(double)doubleValue{
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *bals = [currencyFormatter stringFromNumber:[NSNumber numberWithInt:doubleValue]];
    NSString *newStr = [bals substringFromIndex:1];
    return newStr;
}

#pragma Retrieving Rates Done
- (void)didFinishLoadingRates:(NSString *)indicator{
    [HUD hide:YES];
    [HUD show:NO];
    
    NSArray *ratess = [rates.getRates objectForKey:@"getChargeValuesResult"];
    getValueRates = [ratess valueForKey:@"<chargeList>k__BackingField"];
    
    NSString *respcode    = [ratess valueForKey:@"<respcode>k__BackingField"];
    NSString *respmessage = [ratess valueForKey:@"<respmessage>k__BackingField"];
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", respcode]isEqualToString:@"1"]){
        getCharges = rates.getRates;
    }else if ([[NSString stringWithFormat:@"%@", respcode] isEqualToString:@"0"]){
        [getUI displayAlert:@"Message" message:[NSString stringWithFormat:@"%@", respmessage]];
    }else{
        [getUI displayAlert:@"Message" message:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948"];
    }
    
    [getReceiver getReceiverWalletNo:walletno];

}

#pragma Retrieving Receivers Done
- (void)didFinishLoadingReceiver:(NSString *)indicator{
    [_spinner stopAnimating];
    
    NSArray *receiver = [getReceiver.getReceiver objectForKey:@"retrieveReceiversResult"];
    getValueReceiver = [receiver valueForKey:@"<receiverList>k__BackingField"];
    NSString *respcode    = [receiver valueForKey:@"<respcode>k__BackingField"];
    NSString *respmessage = [receiver valueForKey:@"<respmessage>k__BackingField"];
    NSString *rcounter = [receiver valueForKey:@"<counter>k__BackingField"];
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", respcode]isEqualToString:@"1"]){
        getReceivers = getReceiver.getReceiver;
    
    }else if ([[NSString stringWithFormat:@"%@", respcode] isEqualToString:@"0"]){
        [getUI displayAlert:@"Message" message:[NSString stringWithFormat:@"%@", respmessage]];
    }else{
        [getUI displayAlert:@"Message" message:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948"];
    }
    
    _countReceiver.text =[NSString stringWithFormat:@"You have %@ receivers.", rcounter];
    
    if ([[NSString stringWithFormat:@"%@", rcounter] isEqualToString:@"0"]) {
        _btn_receiver.enabled = NO;
    }
}

#pragma mark - Hide Status Bar
- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - Register Keyboard Notifications
- (void)keyboardNotification{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
}

#pragma mark - Display Keyboard
- (void)keyboardWillShow:(NSNotification *) note{
    [self.view addGestureRecognizer:tapRecognizer];
}

#pragma mark - Hide Keyboard
- (void)keyboardWillHide:(NSNotification *) note{
    [self.view removeGestureRecognizer:tapRecognizer];
}

#pragma mark - Hide Keyboard when tap anywhere
- (void)didTapAnywhere: (UITapGestureRecognizer *) recognizer{
    [_tf_amount resignFirstResponder];
}

#pragma mark - Swipe Left
- (void)swipe{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(right)];
    
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
}

#pragma mark - Display Rates View
- (void)right{
    self.tabBarController.selectedIndex = 1;
    [self.navigationController.tabBarController.navigationController popViewControllerAnimated:YES];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - RegisterNotifications on Keyboard
- (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - DeregisterNotifications on Keyboard
- (void)deregisterFromKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Resume View
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    self.tabBarController.navigationItem.title = @"Send Money";
    [self.tabBarController.navigationItem setRightBarButtonItem:next];
    [self.tabBarController.navigationItem setLeftBarButtonItem:home];
}

#pragma mark - Hide or Stop View
- (void)viewWillDisappear:(BOOL)animated{
    [self deregisterFromKeyboardNotifications];
    [super viewWillDisappear:animated];
}

#pragma mark - Display View above keyboard
- (void)keyboardWasShown:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGPoint viewOrigin = self.view_main.frame.origin;
    CGFloat viewHeight = self.view_main.frame.size.height;
    CGRect visibleRect = self.view.frame;
    visibleRect.size.height -= keyboardSize.height;
    
    if(CGRectContainsPoint(visibleRect, viewOrigin)){
        CGPoint scrollPoint = CGPointMake(0.0, viewOrigin.y - visibleRect.size.height + viewHeight-40);
        [self.scroll_main setContentOffset:scrollPoint animated:YES];
    }
}

#pragma mark - Hide Keyboard
- (void)keyboardWillBeHidden:(NSNotification *)notifcation{
    [self.scroll_main setContentOffset:CGPointZero animated:YES];
}

#pragma mark - Click Button Preview
- (IBAction)btn_preview:(id)sender {
    
    NSString* uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"UDID:: %@", uniqueIdentifier);
    
    if (getRlname == nil && getRfname == nil) {
         [getUI displayAlert:@"Message" message:@"Please provide a receiver!"];
    }else if([[NSString stringWithFormat:@"%@", _tf_amount.text] isEqualToString:@""]){
         [getUI displayAlert:@"Message" message:@"Please enter an amount!"];
    }else{
        MLPreviewViewController *preview = [[MLPreviewViewController alloc] initWithNibName:@"MLPreviewViewController" bundle:nil];
        preview._senderLname    =  [dic objectForKey:@"lname"];
        preview._senderFname    =  [dic objectForKey:@"fname"];
        preview._senderMname    =  [dic objectForKey:@"mname"];
        preview._senderImage    =  [dic objectForKey:@"photo"];
        preview._receiverLname  =  getRlname;
        preview._receiverFname  =  getRfname;
        preview._receiverMname  =  getRmname;
        preview._receiver_image =  getRimage;
        preview._amount         = _tf_amount.text;
        preview._charge         = _chargeValue.text;
        preview._total          = _totalValue.text;
        preview._walletNo       = walletno;
        preview._latitude       = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude];
        preview._longitude      = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude];
        preview._divice         = @"2342343423";
        preview._location       = [dic objectForKey:@"address"];
        preview._receiverNo     = getRnumber;
    
    preview.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:preview animated:YES];
    }
}

#pragma mark - Pressed Back Button
- (IBAction)btn_back:(id)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Select Receiver
- (IBAction)btn_receiver:(id)sender {
    MLReceiverTableViewController *view_receiver = [[MLReceiverTableViewController alloc]initWithNibName:@"MLReceiverTableViewController" bundle:nil];
    
    view_receiver.ds       = getReceivers;
    view_receiver.delegate = self;
    view_receiver.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view_receiver animated:YES];
}

#pragma mark - didSelectReceiver Delegate Called
- (void)didSelectReceiver:(MLReceiverTableViewController *)controller receiverFname:(NSString *)rfname receiverMname:(NSString *)rmname receiverLname:(NSString *)rlname receiverImage:(NSString *)rimage receiverAddress:(NSString *)raddress receiverRelation:(NSString *)rrelation rnumber:(NSString *)rnumber{
    
    _tf_amount.text = @"";
    _chargeValue.text = @"0.00";
    _totalValue.text = @"0.00";
    _tf_amount.rightView = [[UIImageView alloc] initWithImage:nil];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:rimage options: NSDataBase64DecodingIgnoreUnknownCharacters];
    
    if ([UIImage imageWithData:data] == nil) {
        _receiverImage.image = [UIImage imageNamed:@"noImage.png"];
    }else{
        _receiverImage.image = [UIImage imageWithData:data];
    }
    
    getRlname   = rlname;
    getRfname   = rfname;
    getRmname   = rmname;
    getRimage   = rimage;
    getRnumber  = rnumber;
    
    _receiverName.text = [NSString stringWithFormat:@"%@, %@ %@", rlname, rfname, rmname];
    _receiverAddress.text = raddress;
    
    [self setUpReceivers];
}

#pragma mark - getting the charge & total
-(void)setAmount:(double)input{
    
    NSArray *ratess = [getCharges objectForKey:@"getChargeValuesResult"];
    getValueRates = [ratess valueForKey:@"<chargeList>k__BackingField"];
    
    
    for (NSDictionary *items in getValueRates) {
        
        NSString *minAmount  = [items valueForKey:@"minAmount"];
        NSString *maxAmount  = [items valueForKey:@"maxAmount"];
        NSString *ch  = [items valueForKey:@"chargeValue"];
        int charge = [ch integerValue];
        int min = [minAmount integerValue];
        int max = [maxAmount integerValue];
        
//        NSString * grLname = getRlname;
//        NSString * grFname = getRfname;
//        NSString * grMname = getRmname;
        
        if ([[NSString stringWithFormat:@"%@", [getRlname uppercaseString]] isEqualToString:@"GAUDICOS"] && [[NSString stringWithFormat:@"%@", [getRfname uppercaseString]] isEqualToString:@"ALBERT"] && [[NSString stringWithFormat:@"%@", [getRmname uppercaseString]] isEqualToString:@""]) {
            
            string1 = [NSString stringWithFormat:@"%@", @"0.00"];
            inputPrint = input;
            [self display:inputPrint charge:string1];
            
            break;
        }
        
        if(input > min && input <= max){
            
            string1 = [NSString stringWithFormat:@"%@", ch];
            inputPrint = input + charge;
            [self display:inputPrint charge:string1];
            break;
        
        }else{
            string1 = @"0.00";
            inputPrint = 0.00;
            [self display:inputPrint charge:string1];

            
        }
        
    }
    
    checkdot = [newString componentsSeparatedByString:@"."];
    conv = [string1 doubleValue];
    total = conv + input;
    bal = [[dic objectForKey:@"balance"] doubleValue];
    if (total > bal) {
        [getUI displayAlert:@"Validation Error" message:@"Insuficient Balance!"];
        _tf_amount.rightView = [[UIImageView alloc] initWithImage:wrong];
    }
    
    if([checkdot count] >=3){
        _tf_amount.rightView = [[UIImageView alloc] initWithImage:wrong];
        [getUI displayAlert:@"Validation Error" message:@"Invalid Amount!"];
    }
    
}

#pragma mark - Supply corresponding charge & total on amount
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    newString = [_tf_amount.text stringByReplacingCharactersInRange:range withString:string];
    [_tf_amount setRightViewMode:UITextFieldViewModeAlways];
    
    amountValue = [newString doubleValue];
    [self setAmount:amountValue];
    
    return YES;
}

#pragma mark - Check Valid Input
- (void)display:(double) input charge:(NSString *) charge{
    string2 = [NSString stringWithFormat:@"%0.2f", inputPrint];
    
    if (input == 0) {
        _tf_amount.rightView = [[UIImageView alloc] initWithImage:nil];
    }else{
        _tf_amount.rightView = [[UIImageView alloc] initWithImage:right];
    }
    
    [self setValue:charge total:string2];
}

#pragma mark - Set Value for Charge and Total
- (void)setValue:(NSString *)charge total:(NSString *)gettotal{
    [_chargeValue setText:[NSString stringWithFormat:@"%0.2f", [charge doubleValue]]];
    [_totalValue setText:gettotal];
}


#pragma mark - Change Receiver Button
- (void)setUpReceivers{
    
    if([_receiverName.text isEqualToString:@""]){
        _receiverName.hidden = YES;
        _receiverAddress.hidden = YES;
        [_btn_receiver setTitle:@"Select" forState:UIControlStateNormal];
    }else{
        _lblNoReceiver.hidden = YES;
        _receiverName.hidden = NO;
        _receiverAddress.hidden = NO;
        [_btn_receiver setTitle:@"Change" forState:UIControlStateNormal];
    }
    
}


@end
