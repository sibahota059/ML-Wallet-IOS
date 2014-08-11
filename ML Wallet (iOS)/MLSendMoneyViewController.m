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
#import "DeviceID.h"
#import "SaveWalletData.h"
#import "UIAlertView+alertMe.h"

@interface MLSendMoneyViewController (){
    
    UITapGestureRecognizer *tapRecognizer;
    double inputPrint, conv, bal, total, amountValue;
    NSString *string1, *string2, *newString, *getRlname, *getRfname, *getRmname, *getRimage, *getRnumber, *walletno, *smname, *confirmInd;
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
    DeviceID *di;

}

@end


@implementation MLSendMoneyViewController
@synthesize chTotal;
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
    
    //Create object of MBProgressHUD class and add progress dialog view
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    
    //Display the Progress Dialog
    [self displayProgressBar];
    
    //Create object of MLUI, KpRates, GetReceiver, and DeviceID class
    getUI          =  [MLUI new];
    rates          =  [KpRates new];
    getReceiver    =  [GetReceiver new];
    di             =  [DeviceID new];
    
    //Setting GetReceiver & KpRates delegate to this class
    getReceiver.delegate = self;
    rates.delegate = self;
    
    //Create object on UIImage and set image on it
    wrong = [UIImage imageNamed:@"wrong.png"];
    right = [UIImage imageNamed:@"right.png"];
    
    //Create a NavigationBar Left & Right Button and add link
    //next = [getUI navBarButton:self navLink:@selector(btn_preview:) imageNamed:@"next.png"];
    home = [getUI navBarButton:self navLink:@selector(btn_back:) imageNamed:@"home.png"];
    
    next = [[UIBarButtonItem alloc]
                                initWithTitle:@"Next"
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(btn_preview:)];
    self.navigationItem.rightBarButtonItem = next;
    
    
    //Set Up the Receivers View area
    [self setUpReceivers];
    
    //Add background image of a view
    self.view_main.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    
    
    //Check if device is iphone or ipad and create object of UIImage and add image on it
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        image = [UIImage imageNamed:@"content_bg"];
        payment = [UIImage imageNamed:@"payment_bg.png"];
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        image = [UIImage imageNamed:@"content_bg_ipad"];
        payment = [UIImage imageNamed:@"payment_bg_ipad.png"];
    }
    
    //Setting background image of a view
    self.view_sender.backgroundColor = [UIColor colorWithPatternImage:image];
    self.view_receiver.backgroundColor = [UIColor colorWithPatternImage:image];
    self.view_charge.backgroundColor = [UIColor colorWithPatternImage:payment];
    self.view_total.backgroundColor = [UIColor colorWithPatternImage:payment];
    
    //Create a swipe Gesture Recognizer for swiping right
    [self swipe];
    
    //Add observer of a keyboard show/hide
    [self keyboardNotification];
    
    //Call the loadRates methods in KpRates Class
    [rates loadRates];
    
    //Create object of CLLocationManager to get the location, latitude, longitude
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    
    //Create object of NSDictionary and load data from Property List
    dic = [NSDictionary initRead_LoadWallet_Data];
    
    //Get the value of walletno in Property List
    walletno = [dic objectForKey:@"walletno"];
    
    //Setup data about senderInfo and balance
    [self aboutSender];
    
    //Register a notification to check  if Transaction is finished
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(clearAction:) name:@"NotificationMessageEvent" object:nil];
}


#pragma mark - Notification Called when Transaction is successful
-(void) clearAction:(NSNotification *) notification
{
//    if ([notification.object isKindOfClass:[MLSendMoneyViewController class]])
//    {
//        NSLog(@"Nahuman nang transaction, mao nga class");
//    }
//    else
//    {
//        NSLog(@"Nahuman nang transaction, d mao nga class");
//    }
    
    //Set view after transaction
    _tf_amount.text = @"";
    _chargeValue.text = @"0.00";
    _tf_amount.rightView = [[UIImageView alloc] initWithImage:nil];
    _lblNoReceiver.hidden = NO;
    _receiverName.hidden = YES;
    _receiverAddress.hidden = YES;
    [_btn_receiver setTitle:@"Select" forState:UIControlStateNormal];
    _receiverImage.image = [UIImage imageNamed:@"noImage.png"];

    //Get the total ammount of transaction and deduct to the balance
    double getTotal = [_label_balance.text doubleValue] - [_totalValue.text doubleValue];
    _label_balance.text = [NSString stringWithFormat:@"%0.2f", getTotal];
    _totalValue.text = @"0.00";
    
    //Get the user balance
    NSString *finalBalance = [NSString stringWithFormat:@"%@", _label_balance.text];
    
    //Saving balance data to property list
    SaveWalletData *saveData = [SaveWalletData new];
    [saveData initSaveData:finalBalance forKey:@"balance"];
    
}

#pragma mark - Sender Info
- (void)aboutSender{

    //Check if user middlename is empty and if not get the first character of a middlename and add dot and display
    if ([[NSString stringWithFormat:@"%@", [dic objectForKey:@"mname"]] isEqualToString:@""]) {
        smname = @"";
    }else{
        smname = [NSString stringWithFormat:@"%@.", [self capitalizeFirstChar:[[[dic objectForKey:@"mname"] substringToIndex:1] lowercaseString]]];
    }
    
    //Get the user info and balance then capitalize each first character
    _senderName.text = [NSString stringWithFormat:@"%@, %@ %@", [self capitalizeFirstChar:[[dic objectForKey:@"lname"] lowercaseString]], [self capitalizeFirstChar:[[dic objectForKey:@"fname"] lowercaseString]], smname];
    _senderAddress.text = [dic objectForKey:@"address"];
    _label_balance.text = [NSString stringWithFormat:@"%@", [self convertDecimal:[[dic objectForKey:@"balance"] doubleValue]]];

    //Convert the user base64string image and set to NSData object
    NSData *data = [[NSData alloc] initWithBase64EncodedString:[dic objectForKey:@"photo"] options: NSDataBase64DecodingIgnoreUnknownCharacters];
    
    //Check if user image is empty or not and set corresponding image
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
    NSString *bals = [currencyFormatter stringFromNumber:[NSNumber numberWithDouble:doubleValue]];
    NSString *newStr = [bals substringFromIndex:1];
    return newStr;
}

#pragma mark - Retrieving Rates Done
- (void)didFinishLoadingRates:(NSString *)indicator andError:(NSString *)getError{
    
    //Store the rates data return from webservice into static array
    NSArray *ratess = [rates.getRates objectForKey:@"getChargeValuesResult"];
    
    //Parse the data of <chargeList>k__BackingField and stored in mutable array
    getValueRates = [ratess valueForKey:@"<chargeList>k__BackingField"];
    
    //Get the value of respcode and respmessage
    NSString *respcode    = [ratess valueForKey:@"<respcode>k__BackingField"];
    NSString *respmessage = [ratess valueForKey:@"<respmessage>k__BackingField"];
    
    //Check if response is successful or not
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", respcode]isEqualToString:@"1"]){
        
        //store the NSDicationary rates data to mutable array
        getCharges = rates.getRates;
        //Call Webservice to get the list of receiver
        [getReceiver getReceiverWalletNo:walletno];
        
    }else if ([[NSString stringWithFormat:@"%@", respcode] isEqualToString:@"0"]){
        [UIAlertView myCostumeAlert:@"Message" alertMessage:[NSString stringWithFormat:@"%@", respmessage] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if([indicator isEqualToString:@"error"]){

        confirmInd = @"rates";
        [self dismissProgressBar];
        [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
        
    }else{
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" delegate:nil cancelButton:@"Ok" otherButtons:nil];
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    

}

#pragma Retrieving Receivers Done
- (void)didFinishLoadingReceiver:(NSString *)indicator andError:(NSString *)getError{
    
    //Store the NSDicationary receivers data to static array
    NSArray *receiver = [getReceiver.getReceiver objectForKey:@"retrieveReceiversResult"];
    
    //Store the value of <receiverList>k__BackingField arry to mutable array
    getValueReceiver = [receiver valueForKey:@"<receiverList>k__BackingField"];
    
    //Get the repscode, respmessage, and number of receiver
    NSString *respcode    = [receiver valueForKey:@"<respcode>k__BackingField"];
    NSString *respmessage = [receiver valueForKey:@"<respmessage>k__BackingField"];
    NSString *rcounter = [receiver valueForKey:@"<counter>k__BackingField"];
    
    //Check if getting the receiver is successful or not
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", respcode]isEqualToString:@"1"]){
        
        //Store the NSDicationary receivers data to NSDicatonary for MLGetReceiverClass usage
        getReceivers = getReceiver.getReceiver;
    
    }else if ([[NSString stringWithFormat:@"%@", respcode] isEqualToString:@"0"]){
        [UIAlertView myCostumeAlert:@"Message" alertMessage:[NSString stringWithFormat:@"%@", respmessage] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if ([indicator isEqualToString:@"error"]){
        [self dismissProgressBar];
        confirmInd = @"receiver";
        [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
    }else{
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" delegate:nil cancelButton:@"Ok" otherButtons:nil];
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    //Set the number of receiver in a label
    _countReceiver.text =[NSString stringWithFormat:@"You have %@ receivers.", rcounter];
    
    //If user has no receiver, disable the button to select receiver
    if ([[NSString stringWithFormat:@"%@", rcounter] isEqualToString:@"0"]) {
        _btn_receiver.enabled = NO;
    }
    
    //dismiss the progress dialog
    [self dismissProgressBar];
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
    MLRatesTableViewController *ratess = [MLRatesTableViewController new];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckView" object:ratess];
    
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
    self.tabBarController.navigationItem.title = @"SEND MONEY";
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
    
    //Hide the keyboard
    [_tf_amount resignFirstResponder];
    
    //Validating user input
    if (getRlname == nil && getRfname == nil) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Please provide a receiver!" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if([[NSString stringWithFormat:@"%@", _tf_amount.text] isEqualToString:@""]){
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Please enter an amount!" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if ([[_tf_amount.text componentsSeparatedByString:@"."] count]>2) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Invalid Amount!" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if (total > bal) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Insuficient Balance!" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if([[NSString stringWithFormat:@"%@", _tf_amount.text] doubleValue] < 0.01){
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Amount must be greater than zero!" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    else{
        
        //Create object of MLPreviewViewController and pass data to it
        MLPreviewViewController *preview = [[MLPreviewViewController alloc] initWithNibName:@"MLPreviewViewController" bundle:nil];
        preview._senderLname    =  [[dic objectForKey:@"lname"] uppercaseString];
        preview._senderFname    =  [[dic objectForKey:@"fname"] uppercaseString];
        preview._senderMname    =  [smname uppercaseString];
        preview._senderImage    =  [dic objectForKey:@"photo"];
        preview._receiverLname  =  [self capitalizeFirstChar:getRlname];
        preview._receiverFname  =  [self capitalizeFirstChar:getRfname];
        preview._receiverMname  =  getRmname;
        preview._receiver_image =  getRimage;
        preview._amount         = _tf_amount.text;
        preview._charge         = _chargeValue.text;
        preview._total          = _totalValue.text;
        preview._walletNo       = walletno;
        preview._latitude       = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude];
        preview._longitude      = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude];
        preview._divice         = di.NSGetDeviceID;
        preview._location       = [dic objectForKey:@"address"];
        preview._receiverNo     = getRnumber;
    
    //hide tabBar
    preview.hidesBottomBarWhenPushed = YES;
        
    //Pushing to MLPreviewViewController
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
    
    //Set empty to corresponding label
    _tf_amount.text = @"";
    _chargeValue.text = @"0.00";
    _totalValue.text = @"0.00";
    _tf_amount.rightView = [[UIImageView alloc] initWithImage:nil];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
    //Convert the receiver base64string to data
    NSData *data = [[NSData alloc] initWithBase64EncodedString:rimage options: NSDataBase64DecodingIgnoreUnknownCharacters];
    
    //Create UIImage object and check if receiver has image or not and add corresponding image
    if ([UIImage imageWithData:data] == nil) {
        _receiverImage.image = [UIImage imageNamed:@"noImage.png"];
    }else{
        _receiverImage.image = [UIImage imageWithData:data];
    }
    
    //getting the lname and more of receiver
    getRlname   = rlname;
    getRfname   = rfname;
    getRmname   = rmname;
    getRimage   = rimage;
    getRnumber  = rnumber;
    
    //Check if user middlename is empty and if not get the first character of a middlename and add dot and display
    if ([rmname isEqualToString:@""]) {
        rmname = @"";
    }else{
        rmname = [NSString stringWithFormat:@"%@.", [self capitalizeFirstChar:[[rmname substringToIndex:1] lowercaseString]]];
    }
    
    //setting the name of a receiver to a label
    _receiverName.text = [NSString stringWithFormat:@"%@, %@ %@", [self capitalizeFirstChar:rlname], [self capitalizeFirstChar:rfname], rmname];
    _receiverAddress.text = raddress;
    
    //setup receivers view
    [self setUpReceivers];
}

#pragma mark - getting the charge & total
-(void)setAmount:(double)input{
    
    //Store rates NSDictionarry data to static array
    NSArray *ratess = [getCharges objectForKey:@"getChargeValuesResult"];
    
    //Store the value of array into NSMutable array
    getValueRates = [ratess valueForKey:@"<chargeList>k__BackingField"];
    
    //Looping value of rates in corresponding amount input
    for (NSDictionary *items in getValueRates) {
        
        //Getting the minimum, maximum, charge data
        NSString *minAmount  = [items valueForKey:@"minAmount"];
        NSString *maxAmount  = [items valueForKey:@"maxAmount"];
        NSString *ch  = [items valueForKey:@"chargeValue"];
        
        //Set corresponding value
        NSInteger charge = [ch integerValue];
        NSInteger min = [minAmount integerValue];
        NSInteger max = [maxAmount integerValue];
        
        //User sending to it's own
        if ([[NSString stringWithFormat:@"%@", [getRlname uppercaseString]] isEqualToString:[[dic objectForKey:@"lname"]uppercaseString]] && [[NSString stringWithFormat:@"%@", [getRfname uppercaseString]] isEqualToString:[[dic objectForKey:@"fname"]uppercaseString]] && [[NSString stringWithFormat:@"%@", [getRmname uppercaseString]] isEqualToString:[[dic objectForKey:@"mname"]uppercaseString]]) {
            
            string1 = [NSString stringWithFormat:@"%@", @"0.00"];
            inputPrint = input;
            [self display:inputPrint charge:string1];
            
            break;
        }
        
        //User sending to another
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
    
    //Count the number of dots inputed
    checkdot = [newString componentsSeparatedByString:@"."];
    conv = [string1 doubleValue];
    total = conv + input;
    
    //Get the user balance
    bal = [[dic objectForKey:@"balance"] doubleValue];
    
    //Check if total is greater than balance
    if (total > bal) {
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Insuficient Balance!" delegate:nil cancelButton:@"Ok" otherButtons:nil];
        _tf_amount.rightView = [[UIImageView alloc] initWithImage:wrong];
    }
    
    //Validating valid amoutn input
    if([checkdot count] >=3){
        _tf_amount.rightView = [[UIImageView alloc] initWithImage:wrong];
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Invalid Amount!" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
}

#pragma mark - Supply corresponding charge & total on amount
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //User are allowed to input for example 11111.111.
    NSString *newStrings = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *expression = @"^([0-9]{1,5})?(\\.([0-9]{1,3})?)?$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:newStrings
                                                        options:0
                                                          range:NSMakeRange(0, [newStrings length])];
    [_tf_amount setRightViewMode:UITextFieldViewModeAlways];
    
    amountValue = [newStrings doubleValue];
    [self setAmount:amountValue];
    
    if (numberOfMatches == 0)
        return NO;
    
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
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
//test

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        if ([confirmInd isEqualToString:@"rates"]) {
            [self displayProgressBar];
            [rates loadRates];
        }else if ([confirmInd isEqualToString:@"receiver"]){
            [self displayProgressBar];
            [getReceiver getReceiverWalletNo:walletno];
        }
    }
    else if (buttonIndex == 1) {
        if ([confirmInd isEqualToString:@"rates"] || [confirmInd isEqualToString:@"receiver"]) {
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
