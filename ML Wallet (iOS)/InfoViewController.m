//
//  InfoViewController.m
//  ML Wallet
//
//  Created by ml on 2/28/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "InfoViewController.h"
#import "UIAlertView+alertMe.h"


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
    UIBarButtonItem *btnHome = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(gotoHome)];
    
    self.navigationItem.leftBarButtonItem = btnHome;
    
    
    //Set Background
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        
        if ([UIScreen mainScreen].bounds.size.height == 568) //4 inch
        {
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground1.png"]]];
        }
        else //4 inc below
        {
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground2.png"]]];
        }
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground5.png"]]];
    }
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
}

- (IBAction)btnAbout:(id)sender {
    NSString *version   = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *deviceN   = [[UIDevice currentDevice] name];
    NSString *msg       = [NSString stringWithFormat:@"ML Wallet v%@\n%@\nThis will run in IOS 7 or higher version",version, deviceN];
    
    [UIAlertView myCostumeAlert:@"About" alertMessage:msg delegate:nil cancelButton:@"Ok" otherButtons:nil];
    
}
@end
