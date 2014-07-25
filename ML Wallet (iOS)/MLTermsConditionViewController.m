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
    
    UIBarButtonItem *home = [getUI navBarButtonTc:self navLink:@selector(btn_back:) imageNamed:@"back.png"];
    
    [self.navigationItem setLeftBarButtonItem:home];
    
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

- (void)didFinishLoading:(NSString *)indicator{
    [HUD hide:YES];
    [HUD show:NO];
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", sendout.getRespcode]isEqualToString:@"1"]){
        NSLog(@"KPTN: %@", sendout.getKptn);
        _lbl_kptn.text = [NSString stringWithFormat:@"Money Successfully Sent\nKPTN:\n%@",sendout.getKptn];
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
    }else{
        [getUI displayAlert:@"Message" message:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948"];
    }
    
    
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
    
    [self dismissView];
    
}

- (void)dismissView{
    
    sm = [MLSendMoneyViewController new];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationMessageEvent" object:sm];
    MenuViewController *smv = (MenuViewController *)[self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:smv.tabBarController animated:NO];
  
}

- (void) didFinishLoadingEmail:(NSString *)indicator{
    
    [HUD hide:YES];
    [HUD show:NO];
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", se.respcode]isEqualToString:@"1"]){
        
        [self dismissView];
        [getUI displayAlert:@"Message" message:@"KPTN successfully sent to your email."];
        
    }else if ([[NSString stringWithFormat:@"%@", se.respcode] isEqualToString:@"0"]){
        
        [getUI displayAlert:@"Message" message:[NSString stringWithFormat:@"%@", se.respmessage]];
        
    }else{
        
        [getUI displayAlert:@"Message" message:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948"];
    }
    
    
}
- (IBAction)btnSms:(id)sender {
    
    [getUI displayAlert:@"Message" message:@"This will send kptn to your email and function it later."];
}

- (IBAction)btnEmail:(id)sender {
    
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
 
    NSString *sub1 = [sendout.getKptn substringToIndex:4];
    NSString *sub2 = [sendout.getKptn substringWithRange:NSMakeRange(4, 3)];
    NSString *sub3 = [sendout.getKptn substringWithRange:NSMakeRange(7, 4)];
    NSString *sub4 = [sendout.getKptn substringWithRange:NSMakeRange(11, 3)];
    NSString *sub5 = [sendout.getKptn substringWithRange:NSMakeRange(14, 4)];
    
    NSString *sendKptn = [NSString stringWithFormat:@"%@-%@-%@-%@-%@", sub1, sub2, sub3, sub4, sub5];
    [se sendEmail:__walletNo andKptn:sendKptn];
    
}
@end
