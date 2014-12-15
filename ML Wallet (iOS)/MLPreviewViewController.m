//
//  MLPreviewViewController.m
//  SendMoney
//
//  Created by mm20 on 2/17/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import "MLPreviewViewController.h"
#import "MLUI.h"
#import <QuartzCore/QuartzCore.h>
#import "MLTermsConditionViewController.h"
#import "UIAlertView+alertMe.h"

@interface MLPreviewViewController (){
    MLUI *getUI;
    UIBarButtonItem *next;
    MBProgressHUD *HUD;
    CheckPin *chk;
    NSString *confirmInd, *pin;
    
    
}

@end

@implementation MLPreviewViewController

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
    // Do any additional setup after loading the view from its nib.
    
    //create object of CheckPin class and set delegate to it
    chk = [CheckPin new];
    chk.delegate = self;
    
    //create object of MLUI class
    getUI = [MLUI new];
    
    //create object of MBProgressHUD class, set delegate, and add loader view
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
    //set title for navigation bar
    self.title = @"PREVIEW";
    
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                                         initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //set background image of each view
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    self.view_keyboard.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    self.preview_main.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];

    //call shadowView method to create a shadow of view_content view
    [self shadowView];
    
    //check if device is iphone or ipad and set background image of view_content view and change radius of sender and receiver image
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        _image_mine.layer.cornerRadius = 20;
        _image_mine.clipsToBounds = YES;
        _image_receiver.layer.cornerRadius = 20;
        _image_receiver.clipsToBounds = YES;
        self.view_content.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"preview_bg"]];
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        _image_mine.layer.cornerRadius = 30;
        _image_mine.clipsToBounds = YES;
        _image_receiver.layer.cornerRadius = 30;
        _image_receiver.clipsToBounds = YES;
        self.view_content.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"preview_bg_ipad"]];
    }

    //hid the view_keyboard view
    _view_keyboard.hidden = YES;
    
    //Input Pin start at 1st textfield
    [self setText:_tf_pin1];
    
    //setting sender and receiver information on it's label
    _lbl_sname.text   = [[NSString stringWithFormat:@"%@, %@ %@", __senderLname, __senderFname, [__senderMname substringFromIndex:1]] uppercaseString];
    
    
    if ([__transType isEqualToString:@"remittance"]) {
        _lbl_rname.text   = [[NSString stringWithFormat:@"%@, %@ %@", __receiverLname, __receiverFname, __receiverMname] uppercaseString];
    }else if ([__transType isEqualToString:@"own"]){
        _lbl_rname.text = @"SEND TO OWN";
    }else{
        _lbl_rname.text   = [[NSString stringWithFormat:@"%@", __receiverFname] uppercaseString];
        _image_receiver.hidden = YES;
    }
    
    if ([[NSString stringWithFormat:@"%@", __charge] isEqualToString:@"Free"] || [[NSString stringWithFormat:@"%@", __charge] isEqualToString:@"0"]) {
        _lbl_charge.text  = @"Free";
    }else{
        _lbl_charge.text  = [NSString stringWithFormat:@"%0.2f", [__charge doubleValue]];
    }
    
    _lbl_amount.text  = [NSString stringWithFormat:@"%0.2f", [__amount doubleValue]];
    _lbl_total.text   = [NSString stringWithFormat:@"%0.2f", [__total doubleValue]];
    
    //convert base64string of sender and receiver image into data
    NSData *dataSenderImage = [[NSData alloc] initWithBase64EncodedString:__senderImage options: NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *dataReceiverImage = [[NSData alloc] initWithBase64EncodedString:__receiver_image options: NSDataBase64DecodingIgnoreUnknownCharacters];
    
    //setting image for sender
    if ([UIImage imageWithData:dataSenderImage] == nil) {
        _image_mine.image = [UIImage imageNamed:@"noImage.png"];
    }
    else{
        _image_mine.image = [UIImage imageWithData:dataSenderImage];
    }
    
    //setting image for receiver
    if ([UIImage imageWithData:dataReceiverImage] == nil) {
        _image_receiver.image = [UIImage imageNamed:@"noImage.png"];
    }else{
        _image_receiver.image = [UIImage imageWithData:dataReceiverImage];
    }
    
}

#pragma mark - Back Button
- (IBAction)btn_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View Shadow
- (void)shadowView{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.view_content.bounds];
    self.view_content.layer.masksToBounds = NO;
    self.view_content.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view_content.layer.shadowOffset = CGSizeMake(0.0f, 8.0f);
    self.view_content.layer.shadowOpacity = 0.12f;
    self.view_content.layer.shadowPath = shadowPath.CGPath;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Checking Pin
- (void)didFinishLoadingPin:(NSString *)indicator andError:(NSString *)getError{
    
    //hide the progress dialog
    [self dismissProgressBar];
    
    //create object of MLTermsConditionViewController and setting value on it
    MLTermsConditionViewController *tc = [[MLTermsConditionViewController alloc]initWithNibName:@"MLTermsConditionViewController" bundle:nil];
    
    tc._senderLname    =  __senderLname;
    tc._senderFname    =  __senderFname;
    tc._senderMname    =  __senderMname;
    tc._receiverLname  =  __receiverLname;
    tc._receiverFname  =  __receiverFname;
    tc._receiverMname  =  __receiverMname;
    tc._transType      =  __transType;
    tc._amount         =  __amount;
    
    if ([__transType isEqualToString:@"billsPay"]) {
        tc._operatorId     = __operatorId;
        tc._bcode          = __bcode;
        tc._zcode          = __zcode;
        tc._kptn           = __kptn;
        tc._partnersId     = __partnersId;
        tc._accountNo      = __accountNo;
        tc._customerCharge = __customerCharge;
        tc._partnersCharge = __partnersCharge;
    }else{
        tc._receiverNo = __receiverNo;
    }

    tc._walletNo       = __walletNo;
    tc._latitude       = __latitude;
    tc._longitude      = __longitude;
    tc._divice         = __divice;
    tc._location       = __location;

    //extract dictionary and get value for repscode & respmessage
    NSString* repscode = [chk.getPin objectForKey:@"respcode"];
    NSString* respmessage = [chk.getPin objectForKey:@"respmessage"];
    
    //if requesting pin is successful go to next page, else display error message
    if ([[NSString stringWithFormat:@"%@", repscode] isEqualToString:@"1"]) {
        [self.navigationController pushViewController:tc animated:YES];
        
        [self.preview_scroll setContentSize:CGSizeMake(320, 400)];
        self.view_pinInput.alpha = 1.0;
        self.view_keyboard.alpha = 1.0;
        self.view_content.alpha = 0.0;
        self.btn_pin.hidden = NO;
        self.btn_pin.alpha = 0.0;
        [self reset];
        
        [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _view_keyboard.hidden = NO;
            self.view_pinInput.alpha = 0.0;
            self.view_keyboard.alpha = 0.0;
            self.btn_pin.alpha = 1.0;
            self.view_content.alpha = 1;
        }completion:^(BOOL finished) {
            
        }];
        
        [_view_content setAlpha:1];
        self.title = @"PREVIEW";
        [self.navigationItem setRightBarButtonItem:nil];
        
    }else if ([indicator isEqualToString:@"error"]){
        confirmInd = @"pin";	
        [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
    }else if ([[NSString stringWithFormat:@"%@", repscode] isEqualToString:@"0"]){
        [UIAlertView myCostumeAlert:@"Message" alertMessage:respmessage delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if ([[NSString stringWithFormat:@"%@", repscode] isEqualToString:@"3"]){
        [UIAlertView myCostumeAlert:@"Message" alertMessage:respmessage delegate:nil cancelButton:@"Ok" otherButtons:nil];
        [self dismissProgressBar];
        [self.navigationController popToRootViewControllerAnimated:YES];
        self.navigationController.navigationBarHidden = YES;
        
    }else{
        [UIAlertView myCostumeAlert:@"Message" alertMessage:respmessage delegate:nil cancelButton:@"Ok" otherButtons:nil];
        [self reset];
    }
}

#pragma mark - Button Next is Pressed
- (void)btnPin{
    
    //get the inputted pin
    pin = [NSString stringWithFormat:@"%@%@%@%@",_tf_pin1.text, _tf_pin2.text, _tf_pin3.text, _tf_pin4.text];
    
    NSUInteger pinCount = pin.length;
    
    if (pinCount == 4) {
        
        //call webservice to check if inputted pin is correct
        [chk getReceiverWalletNo:__walletNo andReceiverPinNo:pin];
        
        //display progress dialog
        [self displayProgressBar];
        
    }else{
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Pin must be 4 characters!" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
}

#pragma mark - Tap Gesture Recognizer Event
- (IBAction)tapPreview:(UITapGestureRecognizer *)sender {
    [self.preview_scroll setContentSize:CGSizeMake(320, 400)];
    self.view_pinInput.alpha = 1.0;
    self.view_keyboard.alpha = 1.0;
    self.view_content.alpha = 0.0;
    self.btn_pin.hidden = NO;
    self.btn_pin.alpha = 0.0;
    [self reset];
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _view_keyboard.hidden = NO;
        self.view_pinInput.alpha = 0.0;
        self.view_keyboard.alpha = 0.0;
        self.btn_pin.alpha = 1.0;
        self.view_content.alpha = 1;
    }completion:^(BOOL finished) {
        
    }];
    
    [_view_content setAlpha:1];
    self.title = @"PREVIEW";
    [self.navigationItem setRightBarButtonItem:nil];
}


#pragma mark - Click on Next Button
- (IBAction)btn_pin:(id)sender {
    [self.preview_scroll setContentSize:CGSizeMake(320, 400)];
    self.view_pinInput.alpha = 0.0;
    self.view_keyboard.alpha = 0.0;
    self.btn_pin.hidden = YES;
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _view_keyboard.hidden = NO;
        self.view_pinInput.alpha = 1.0;
        self.view_keyboard.alpha = 1.0;
    }completion:^(BOOL finished) {
        
    }];
    
    [_view_content setAlpha:0.1f];
    self.title = @"ENTER YOUR PIN";
    //self.navigationItem.titleView = [getUI navTitle:@"Enter Your Pin"];
    
    
    next = [[UIBarButtonItem alloc]
            initWithTitle:@"Next"
            style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(btnPin)];
    self.navigationItem.rightBarButtonItem = next;
    
    //next = [getUI navBarButtonPreview:self navLink:@selector(btnPin) imageNamed:@"next.png"];
    [self.navigationItem setRightBarButtonItem:next];
    _view_pinInput.hidden = NO;
}

#pragma mark - Reset
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
    
    [self setText:_tf_pin1];
    
}

- (IBAction)btnOne:(id)sender {
    [self getText].text = @"1";
    [self setText:[self nextField]];
}

- (IBAction)btnTwo:(id)sender {
    [self getText].text = @"2";
    [self setText:[self nextField]];
}

- (IBAction)btnThree:(id)sender {
    [self getText].text = @"3";
    [self setText:[self nextField]];
}

- (IBAction)btnFour:(id)sender {
    [self getText].text = @"4";
    [self setText:[self nextField]];
}

- (IBAction)btnFive:(id)sender {
    [self getText].text = @"5";
    [self setText:[self nextField]];
}

- (IBAction)btnSix:(id)sender {
    [self getText].text = @"6";
    [self setText:[self nextField]];
}

- (IBAction)btnSeven:(id)sender {
    [self getText].text = @"7";
    [self setText:[self nextField]];
}

- (IBAction)btnEight:(id)sender {
    [self getText].text = @"8";
    [self setText:[self nextField]];
}

- (IBAction)btnNine:(id)sender {
    [self getText].text = @"9";
    [self setText:[self nextField]];
}

- (IBAction)btnZero:(id)sender {
    [self getText].text = @"0";
    [self setText:[self nextField]];
}

#pragma mark - Hide Status Bar
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)btnClear:(id)sender {
    [self reset];
}

#pragma mark - TextField Input
//create a function that return UITextField to be inputted
- (UITextField *)nextField{
    
    UITextField *checkNext;
    
    if (![_tf_pin1.text isEqualToString:@""]) {
        checkNext = _tf_pin2;
    }
    
    if (![_tf_pin2.text isEqualToString:@""]) {
        checkNext = _tf_pin3;
    }
    
    if (![_tf_pin3.text isEqualToString:@""]) {
        checkNext = _tf_pin4;
    }
    
    if (![_tf_pin4.text isEqualToString:@""]) {
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
        if ([confirmInd isEqualToString:@"pin"]) {
            [self displayProgressBar];
            [chk getReceiverWalletNo:__walletNo andReceiverPinNo:pin];
        }
    }
    else if (buttonIndex == 1) {
        if ([confirmInd isEqualToString:@"pin"]) {
            //do nothing
        }
    }
}


@end
