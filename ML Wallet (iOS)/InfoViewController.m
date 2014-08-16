//
//  InfoViewController.m
//  ML Wallet
//
//  Created by ml on 2/28/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "InfoViewController.h"
#import "UIAlertView+alertMe.h"
#import "UIView+MenuAnimationUIVIew.h"


@interface InfoViewController ()

@end

@implementation InfoViewController

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
    [self setNavigation];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void) setNavigation
{
    self.navigationController.navigationBarHidden = NO;
    self.title= @"Information";
    UIBarButtonItem *btnHome = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(gotoHome)];
    
//    UIBarButtonItem *btnHome = [[UIBarButtonItem alloc] initWithTitle:@"Back"
//                                                                style:UIBarButtonItemStyleBordered
//                                                               target:self
//                                                               action:@selector(gotoHome)];
    
    self.navigationItem.leftBarButtonItem = btnHome;
    
    
    //Set Background
    [self.view setBackgroundColor:[UIColor whiteColor]];

}

- (void)gotoHome
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCotactUs:(id)sender {
    NSString *call  = @"Call : (032)232-1035 or 232-1036\n\n";
    NSString *email = @"Email: customercare@mlhuillier1.com\n\n";
    NSString *sms   = @"SMS  : Helpdesk:\n09479992754\n09479992755\n09479991948 \n\nCustomer Care:\n09479990337";
    [UIAlertView myCostumeAlert:nil alertMessage:[NSString stringWithFormat:@"%@%@%@", call, email, sms] delegate:nil cancelButton:@"Ok" otherButtons:nil];
}

- (IBAction)btnFAQ:(id)sender {
//    NSString *faq = @"What is ML Wallet Mobile?\nML Wallet Mobile is M. Lhuillier’s official mobile application that allows customer to send money at your own convenience using your mobile device.\nWhat can I do with my ML Wallet Mobile application?\nYou can perform the following:\nSend money to your registered beneficiary\nRegister beneficiary\nCheck balance of your account\nReload your account\nView transaction history\nTransfer fund withdrawable to any of ML locations nationwide\nCheck mobile sendout rates\nLocate nearest ML branch\nHow do I register to ML Wallet mobile application?\nIf you are an existing M. Lhuillier customer, call, text or email ML Helpdesk to request your customer ID or you can go to a nearest ML branch to obtain your ML Customer ID.  Once you have your ML Customer ID, on your mobile, tap Register here and supply your customer ID to proceed with the registration.\nIf you are a new customer, it is required to go to a nearest ML branch and register.  Please bring valid ID (SSS, GSIS, Passport, etc).  You may be required to present Statement of Account or utility bill as additional proof of identity.\nDo I need to pay for using ML Wallet application?\nUsing ML Wallet application will follow the Sendout Rate stated in the login page and will depend on the amount of money you are going to transfer.  This also charged you when loading your wallet.  However, when you withdraw an amount, it is free of charge.  Just go to an ML branch near you.\nIs there a limit of amount I can load to my ML Wallet?\nYes.  The system only allows you to maintain P50, 000.00 in your ML Wallet.\nIs there a limit of amount I can send in a day?\nYes.  The system allows sendout transaction amount at P50,000.00 per day.\nWill I be charged of a dormancy fee of my account?  How about my sendout  transaction when unclaimed?\nNo.  You will not be charged of any fee of your deposit.  However, your sendout transaction will be charged P500.00 dormancy fee when left unclaimed after three (3) months.\nIs the ML Wallet mobile application safe and secure?\nYes.  M. Lhuillier ensures your account to be safe and secured.  M. Lhuillier employs the best security practices and methods to safeguard your account.\nPIN is required for every transaction done.\nTransaction cannot proceed when you are using a new SIM or cellphone number.\nVerisign security certificate is employed for transaction encryption.\nFive (5) minutes idle time that allows system to log out automatically, requiring username and password to re-login.\nDevice ID, transaction location and IP addresses are logged\nCan I install or access ML Wallet mobile app to any device?\nYes but you have also to insert along your SIM card to the new mobile device you are going to use.  This is a part of a security feature of the system.\n";
    
    [UIView popView:self.FaqView];
    self.FaqView.hidden = NO;
    
    self.FaqView.layer.masksToBounds    = NO;
    self.FaqView.layer.cornerRadius     = 8;
    self.FaqView.layer.shadowOffset     = CGSizeMake(-15, 20);
    self.FaqView.layer.shadowRadius     = 5;
    self.FaqView.layer.shadowOpacity    = 0.5;
}

      
- (IBAction)btnAbout:(id)sender {
    NSString *version   = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *deviceN   = [[UIDevice currentDevice] name];
    NSString *msg       = [NSString stringWithFormat:@"ML Wallet v%@\n%@\nThis will run in IOS 7 or higher version",version, deviceN];
    
    [UIAlertView myCostumeAlert:@"About" alertMessage:msg delegate:nil cancelButton:@"Ok" otherButtons:nil];
    
}
- (IBAction)bntClose:(id)sender {
    self.FaqView.hidden = YES;
}
@end
