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

@interface MLPreviewViewController (){
    MLUI *getUI;
    UIBarButtonItem *next;
    MBProgressHUD *HUD;
    CheckPin *chk;
    
    
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
    
    //customize the icon for back button and call the btn_back method
    UIBarButtonItem *home = [getUI navBarButtonPreview:self navLink:@selector(btn_back:) imageNamed:@"back.png"];
    
    //set the bar button home to left
    [self.navigationItem setLeftBarButtonItem:home];
    
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
    _lbl_sname.text   = [NSString stringWithFormat:@"%@, %@ %@", __senderLname, __senderFname, __senderMname];
    _lbl_rname.text   = [NSString stringWithFormat:@"%@, %@ %@", __receiverLname, __receiverFname, __receiverMname];
    _lbl_amount.text  = [NSString stringWithFormat:@"%0.2f", [__amount doubleValue]];
    _lbl_charge.text  = __charge;
    _lbl_total.text   = __total;
    
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
- (void)didFinishLoadingPin:(NSString *)indicator{
    
    //hide the progress dialog
    [HUD hide:YES];
    [HUD show:NO];
    
    //create object of MLTermsConditionViewController and setting value on it
    MLTermsConditionViewController *tc = [[MLTermsConditionViewController alloc]initWithNibName:@"MLTermsConditionViewController" bundle:nil];
    
    tc._senderLname    =  __senderLname;
    tc._senderFname    =  __senderFname;
    tc._senderMname    =  __senderMname;
    tc._receiverLname  =  __receiverLname;
    tc._receiverFname  =  __receiverFname;
    tc._receiverMname  =  __receiverMname;
    tc._total          = __amount;
    tc._walletNo       = __walletNo;
    tc._latitude       = __latitude;
    tc._longitude      = __longitude;
    tc._divice         = __divice;
    tc._location       = __location;
    tc._receiverNo     = __receiverNo;
    
    //get the results of pin request
    NSDictionary* _getPin = [chk.getPin objectForKey:@"checkPinResult"];
    
    //extract dictionary and get value for repscode & respmessage
    NSString* repscode = [_getPin objectForKey:@"respcode"];
    NSString* respmessage = [_getPin objectForKey:@"respmessage"];
    
    //if requesting pin is successful go to next page, else display error message
    if ([[NSString stringWithFormat:@"%@", repscode] isEqualToString:@"1"]) {
        [self.navigationController pushViewController:tc animated:YES];
        [self reset];
    }else{
        [getUI displayAlert:@"Message" message:respmessage];
        [self reset];
    }
}

#pragma mark - Button Next is Pressed
- (void)btnPin{
    
    //get the inputted pin
    NSString *pin = [NSString stringWithFormat:@"%@%@%@%@",_tf_pin1.text, _tf_pin2.text, _tf_pin3.text, _tf_pin4.text];
    
    //call webservice to check if inputted pin is correct
    [chk getReceiverWalletNo:__walletNo andReceiverPinNo:pin];
    
    //display progress dialog
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    
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
    next = [getUI navBarButtonPreview:self navLink:@selector(btnPin) imageNamed:@"next.png"];
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

@end
