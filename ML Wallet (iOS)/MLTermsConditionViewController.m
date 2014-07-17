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

@interface MLTermsConditionViewController (){
    MLUI *getUI;
    SendoutMobile *sendout;
    MBProgressHUD *HUD;
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
    getUI = [MLUI new];
    sendout = [SendoutMobile new];
    //self.navigationItem.titleView = [getUI navTitle:@"Terms & Conditions"];
    self.title = @"Terms & Conditions";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    
    _tv_termsCondition.text = [getUI termsConditions];
    _tv_termsCondition.editable = NO;
    [getUI shadowView:_view_tc];
    //    self.view_dialogHeader.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar_bg.png"]];
    
    UIBarButtonItem *home = [getUI navBarButtonTc:self navLink:@selector(btn_back:) imageNamed:@"back.png"];
    
    [self.navigationItem setLeftBarButtonItem:home];
    
    sendout = [[SendoutMobile alloc]initWithWalletNo:__walletNo senderFname:__senderFname senderMname:__senderMname senderLname:__senderLname receiverFname:__receiverFname receiverMname:__receiverMname receiverLname:__receiverLname receiverNo:__receiverNo principal:__total latitude:__latitude longitude:__longitude location:__location deviceId:__divice];
    
    sendout.delegate = self;
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
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

- (void)didFinishLoading{
    [HUD hide:YES];
    [HUD show:NO];
    
    NSLog(@"KPTN: %@", sendout.getKptn);
    _lbl_kptn.text = [NSString stringWithFormat:@"KPTN: %@",sendout.getKptn];
    _view_success.hidden = NO;
    _view_success.alpha = 0.2f;
    _view_successOption.hidden = NO;
    _btnDecline.enabled = NO;
    _btnAgree.enabled = NO;
    [getUI shadowView:_view_successOption];
    self.title = @"Done";
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)btn_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnAgree:(id)sender {
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    [sendout postDataToUrl];
}
- (IBAction)btnClose:(id)sender {
    
    MenuViewController *smv = (MenuViewController *)[self.navigationController.viewControllers objectAtIndex:1];
    
    [self.navigationController popToViewController:smv.tabBarController animated:YES];
}

- (IBAction)btnSms:(id)sender {
    [getUI displayAlert:@"Message" message:@"This will redirect to sms and function it later."];
}

- (IBAction)btnEmail:(id)sender {
    [getUI displayAlert:@"Message" message:@"This will send kptn to your email and function it later."];
}
@end
