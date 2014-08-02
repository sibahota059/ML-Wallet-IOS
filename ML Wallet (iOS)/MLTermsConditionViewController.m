//
//  MLTermsConditionViewController.m
//  SendMoney
//
//  Created by mm20 on 2/26/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import "MLTermsConditionViewController.h"
#import "MLUI.h"
#import "MLSendMoneyViewController.h"
#import "MLRatesTableViewController.h"
#import "MenuViewController.h"
#import "NSDictionary+LoadWalletData.h"

@interface MLTermsConditionViewController (){
    MLUI *getUI;
    SendoutMobile *sendout;
    MBProgressHUD *HUD;
    SendEmail *se;
    MLSendMoneyViewController *sm;
    NSString *confirmInd;
}

@end

@implementation MLTermsConditionViewController

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
    
    getUI   = [MLUI new];
    sendout = [SendoutMobile new];
    se      = [SendEmail new];
    
    //self.navigationItem.titleView = [getUI navTitle:@"Terms & Conditions"];
    self.title = @"TERMS & CONDITIONS";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    
    _tv_termsCondition.text = [getUI termsConditions];
    _tv_termsCondition.editable = NO;
    [getUI shadowView:_view_tc];
    //    self.view_dialogHeader.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar_bg.png"]];
    
    //UIBarButtonItem *home = [getUI navBarButtonTc:self navLink:@selector(btn_back:) imageNamed:@"back.png"];
    
    //[self.navigationItem setLeftBarButtonItem:home];
    
    sendout = [[SendoutMobile alloc]initWithWalletNo:__walletNo senderFname:__senderFname senderMname:__senderMname senderLname:__senderLname receiverFname:__receiverFname receiverMname:__receiverMname receiverLname:__receiverLname receiverNo:__receiverNo principal:__total latitude:__latitude longitude:__longitude location:__location deviceId:__divice];
    
    se.delegate = self;
    sendout.delegate = self;
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnDecline:(id)sender {
    
    MenuViewController *smv = (MenuViewController *)[self.navigationController.viewControllers objectAtIndex:1];
    
    [self.navigationController popToViewController:smv.tabBarController animated:YES];
    
    
}

- (void)didFinishLoading:(NSString *)indicator andEror:(NSString *)getError{
    [self dismissProgressBar];
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", sendout.getRespcode]isEqualToString:@"1"]){

        _lbl_kptn.text = [NSString stringWithFormat:@"Money Successfully Sent\nKPTN:\n%@",[self formatKptn:sendout.getKptn]];
        _view_success.hidden = NO;
        _view_success.alpha = 0.2f;
        _view_successOption.hidden = NO;
        _btnDecline.enabled = NO;
        _btnAgree.enabled = NO;
        [getUI shadowView:_view_successOption];
        self.title = @"TRANSACTION SUCCESS";
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = nil;
    }else if ([[NSString stringWithFormat:@"%@", sendout.getRespcode] isEqualToString:@"0"]){
        [getUI displayAlert:@"Message" message:[NSString stringWithFormat:@"%@", sendout.getRespmessage]];
    }else if ([indicator isEqualToString:@"error"]){
        confirmInd = @"sendout";
        [self dismissProgressBar];
        [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
    }else{
        [getUI displayAlert:@"Message" message:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948"];
    }
    
    
}

- (NSString *)formatKptn:(NSString *)kptn{
    
    NSString *sub1 = [kptn substringToIndex:4];
    NSString *sub2 = [kptn substringWithRange:NSMakeRange(4, 3)];
    NSString *sub3 = [kptn substringWithRange:NSMakeRange(7, 4)];
    NSString *sub4 = [kptn substringWithRange:NSMakeRange(11, 3)];
    NSString *sub5 = [kptn substringWithRange:NSMakeRange(14, 4)];
    NSString *sendKptn = [NSString stringWithFormat:@"%@-%@-%@-%@-%@", sub1, sub2, sub3, sub4, sub5];
    
    return sendKptn;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)btn_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnAgree:(id)sender {
    [self displayProgressBar];
    [sendout postDataToUrl];
}
- (IBAction)btnClose:(id)sender {
    
    [self dismissView];
    
}

- (void)dismissView{
    
    sm = [MLSendMoneyViewController new];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationMessageEvent" object:sm];
    MenuViewController *smv = (MenuViewController *)[self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:smv.tabBarController animated:NO];
  
}

- (void) didFinishLoadingEmail:(NSString *)indicator andError:(NSString *)getError{
    
    [self dismissProgressBar];
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", se.respcode]isEqualToString:@"1"]){
        
        [self dismissView];
        [getUI displayAlert:@"Message" message:@"KPTN successfully sent to your email."];
        
    }else if ([[NSString stringWithFormat:@"%@", se.respcode] isEqualToString:@"0"]){
        
        [getUI displayAlert:@"Message" message:[NSString stringWithFormat:@"%@", se.respmessage]];
        
    }else if ([indicator isEqualToString:@"error"]){
        confirmInd = @"email";
        [self dismissProgressBar];
        [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
    
    }else{
        
        [getUI displayAlert:@"Message" message:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948"];
    }
    
    
}
- (IBAction)btnSms:(id)sender {
    
    [getUI displayAlert:@"Message" message:@"This will send kptn to your email and function it later."];
}

- (IBAction)btnEmail:(id)sender {
    
    [self displayProgressBar];
 
    [se sendEmail:__walletNo andKptn:[self formatKptn:sendout.getKptn]];
    
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
        if ([confirmInd isEqualToString:@"sendout"]) {
            [self displayProgressBar];
            [sendout postDataToUrl];
        }else{
            [self displayProgressBar];
            [se sendEmail:__walletNo andKptn:[self formatKptn:sendout.getKptn]];
        }
    }
    else if (buttonIndex == 1) {
        if ([confirmInd isEqualToString:@"sendout"] || [confirmInd isEqualToString:@"email"]) {
            //do nothing
        }
    }
}


@end
