
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
#import "MenuViewController.h"
#import "NSDictionary+LoadWalletData.h"
#import "UIAlertView+alertMe.h"


@interface MLTermsConditionViewController (){
    MLUI *getUI;
    SendoutMobile *sendout;
    MBProgressHUD *HUD;
    SendEmail *se;
    SavePartnersBill *savePartners;
    MLSendMoneyViewController *sm;
    NSString *confirmInd, *emailKptn;
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
    
    getUI        = [MLUI new];
    sendout      = [SendoutMobile new];
    se           = [SendEmail new];
    savePartners = [SavePartnersBill new];
    
    //self.navigationItem.titleView = [getUI navTitle:@"Terms & Conditions"];
    self.title = @"TERMS & CONDITIONS";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    
    _tv_termsCondition.text = [getUI termsConditions];
    _tv_termsCondition.editable = NO;
    //[getUI shadowView:_view_tc];
    //    self.view_dialogHeader.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar_bg.png"]];
    
    //UIBarButtonItem *home = [getUI navBarButtonTc:self navLink:@selector(btn_back:) imageNamed:@"back.png"];
    
    //[self.navigationItem setLeftBarButtonItem:home];
    
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                                         initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    if ([__transType isEqualToString:@"remittance"] || [__transType isEqualToString:@"own"]) {
        sendout = [[SendoutMobile alloc]initWithWalletNo:__walletNo senderFname:__senderFname senderMname:__senderMname senderLname:__senderLname receiverFname:__receiverFname receiverMname:__receiverMname receiverLname:__receiverLname receiverNo:__receiverNo principal:__amount latitude:__latitude longitude:__longitude location:__location deviceId:__divice];
    }
    
    se.delegate = self;
    sendout.delegate = self;
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    savePartners.delegate = self;
    
    
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

        emailKptn = [self formatKptn:sendout.getKptn];
        
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
        [UIAlertView myCostumeAlert:@"Message" alertMessage:[NSString stringWithFormat:@"%@", sendout.getRespmessage] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if ([indicator isEqualToString:@"error"]){
        confirmInd = @"sendout";
        [self dismissProgressBar];
        [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
    }else{
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" delegate:nil cancelButton:@"Ok" otherButtons:nil];
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
    [self.navigationItem setHidesBackButton:YES];
    
    if ([__transType isEqualToString:@"billsPay"]) {
        [savePartners getReceiverWalletNo:__walletNo andOperatorId:__operatorId andBarcode:__bcode andZoneCode:__zcode andKptn:__kptn andPartnersId:__partnersId andAccountNo:__accountNo andAmountPaid:__amount andCustomerCharge:__customerCharge andPartnersCharge:__partnersCharge andLatitude:__latitude andLongitude:__longitude andDeviceId:__divice andLocation:__location];
    }else{
        [sendout postDataToUrl];
    }
}


- (void)didFinishLoadingPartnersSendout:(NSString *)indicator andError:(NSString *)getError{
    
    [self dismissProgressBar];
    NSString *getRepscode = [savePartners.partnersSendout valueForKey:@"RespCode"];
    NSString *getRepsMessage = [savePartners.partnersSendout valueForKey:@"RespMsg"];
    
    if ([getRepscode integerValue] == 1) {
        
        emailKptn = __kptn;
        
        _lbl_kptn.text = [NSString stringWithFormat:@"Money Successfully Sent\nKPTN:\n%@",__kptn];
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
            [UIAlertView myCostumeAlert:@"Message" alertMessage:getRepsMessage delegate:nil cancelButton:@"Ok" otherButtons:nil];
        }else if ([indicator isEqualToString:@"error"]){
            confirmInd = @"bills";
            [self dismissProgressBar];
            [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
        }else{
            [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" delegate:nil cancelButton:@"Ok" otherButtons:nil];
        }
}

- (IBAction)btnClose:(id)sender {
    
    //This for loop iterates through all the view controllers in navigation stack.
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        
        //This if condition checks whether the viewController's class is MyGroupViewController
        // if true that means its the MyGroupViewController (which has been pushed at some point)
        if ([viewController isKindOfClass:[MenuViewController class]] ) {
            
            // Here viewController is a reference of UIViewController base class of MyGroupViewController
            // but viewController holds MyGroupViewController  object so we can type cast it here
            self.navigationController.navigationBarHidden = YES;
            MenuViewController *groupViewController = (MenuViewController*)viewController;
            [self.navigationController popToViewController:groupViewController animated:YES];
            
        }
    }
    
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
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"KPTN successfully sent to your email." delegate:nil cancelButton:@"Ok" otherButtons:nil];
        
    }else if ([[NSString stringWithFormat:@"%@", se.respcode] isEqualToString:@"0"]){
        [UIAlertView myCostumeAlert:@"Message" alertMessage:[NSString stringWithFormat:@"%@", se.respmessage] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }else if ([indicator isEqualToString:@"error"]){
        confirmInd = @"email";
        [self dismissProgressBar];
        [self confirmDialog:@"Message" andMessage:getError andButtonNameOK:@"Retry" andButtonNameCancel:@"No, Thanks"];
    
    }else{
        
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
    
}
- (IBAction)btnSms:(id)sender {
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms:+1234567890"]];

    //[getUI displayAlert:@"Message" message:@"This will redirect kptn to your sms."];
    
//    if([MFMessageComposeViewController canSendText]) {
//        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
//        controller.body = [self formatKptn:sendout.getKptn];
//        controller.recipients = [NSArray arrayWithObjects:@"", nil];
//        controller.messageComposeDelegate = self;
//        //[self presentViewController:controller animated:YES completion:nil];
//        [self.navigationController pushViewController:controller animated:YES];
//    }else{
//        [getUI displayAlert:@"Message" message:@"Your device doesn't support Messages."];
//    }
 
    if([MFMessageComposeViewController canSendText]){
        
        [[UINavigationBar appearance] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [getUI navMessageAppearance];
        
        MFMessageComposeViewController *smsComposer =
        [[MFMessageComposeViewController alloc] init];
        
        //smsComposer.recipients = [NSArray arrayWithObject:@""];
        smsComposer.body = [self formatKptn:sendout.getKptn];
        
        smsComposer.messageComposeDelegate = self;
        
        [[smsComposer navigationBar] setBarTintColor:[UIColor whiteColor]];
        [[smsComposer navigationBar] setTintColor: [UIColor redColor]]; //color
        [self presentViewController: smsComposer animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
        }];
        
        [self presentViewController:smsComposer animated:YES completion:nil];
    }
    else{
        //You probably want to show a UILocalNotification here.
        [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Your device doesn't support Messages." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    switch(result) {
        case MessageComposeResultCancelled:
            // user canceled sms
            [getUI navigationAppearance];
            [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Your message has been cancelled." delegate:nil cancelButton:@"Ok" otherButtons:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self dismissView];
            
            break;
        case MessageComposeResultSent:
            // user sent sms
            //perhaps put an alert here and dismiss the view on one of the alerts buttons
            [getUI navigationAppearance];
            [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Your message has been sent." delegate:nil cancelButton:@"Ok" otherButtons:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self dismissView];
            break;
        case MessageComposeResultFailed:
            // sms send failed
            //perhaps put an alert here and dismiss the view when the alert is canceled
            [getUI navigationAppearance];
            [UIAlertView myCostumeAlert:@"Message" alertMessage:@"Failed to send message." delegate:nil cancelButton:@"Ok" otherButtons:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self dismissView];
            break;
        default:
            break;
    }
}

- (IBAction)btnEmail:(id)sender {
    
    [self displayProgressBar];
 
    [se sendEmail:__walletNo andKptn:emailKptn];
    
}

- (IBAction)btnContinue:(id)sender {
    
    _view_successOption.hidden = YES;
    _viewConfirm.hidden = NO;
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
        if ([confirmInd isEqualToString:@"sendout"]) {
            [self displayProgressBar];
            [sendout postDataToUrl];
        }else if ([confirmInd isEqualToString:@"bills"]) {
            [self displayProgressBar];
            [savePartners getReceiverWalletNo:__walletNo andOperatorId:__operatorId andBarcode:__bcode andZoneCode:__zcode andKptn:__kptn andPartnersId:__partnersId andAccountNo:__accountNo andAmountPaid:__amount andCustomerCharge:__customerCharge andPartnersCharge:__partnersCharge andLatitude:__latitude andLongitude:__longitude andDeviceId:__divice andLocation:__location];
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



- (IBAction)btnOnother:(id)sender {
    [self dismissView];
}

- (IBAction)btnDone:(id)sender {
    //This for loop iterates through all the view controllers in navigation stack.
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        
        //This if condition checks whether the viewController's class is MyGroupViewController
        // if true that means its the MyGroupViewController (which has been pushed at some point)
        if ([viewController isKindOfClass:[MenuViewController class]] ) {
            
            // Here viewController is a reference of UIViewController base class of MyGroupViewController
            // but viewController holds MyGroupViewController  object so we can type cast it here
            self.navigationController.navigationBarHidden = YES;
            MenuViewController *groupViewController = (MenuViewController*)viewController;
            [self.navigationController popToViewController:groupViewController animated:YES];
            
        }
    }
}
@end
