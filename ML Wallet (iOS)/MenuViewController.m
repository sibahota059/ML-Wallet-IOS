//
//  MenuViewController.m
//  ML Wallet
//
//  Created by ml on 2/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "MenuViewController.h"
#import "UIAlertView+alertMe.h"
#import "LoginViewController.h"
#import "UIView+MenuAnimationUIVIew.h"
#import "ReceiverMenuListViewController.h"
#import "TopupViewController.h"
#import "InfoViewController.h"
#import "MLSendMoneyViewController.h"
#import "MLRatesTableViewController.h"
#import "MLUI.h"
#import "AccountMain.h"
#import "MLHistoryViewController.h"
#import "NSDictionary+LoadWalletData.h"
#import "MapViewController.h"
#define  VIEW_HIDDEN -320
#define  VIEW_HIDDEN_IPAD -580


@interface MenuViewController ()
{
        MLUI *getUI;
}
@end

@implementation MenuViewController
{
    BOOL isClickPopUp;
}

@synthesize topLayer = _topLayer;
@synthesize layerPosition = _layerPosition;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self hidePopUP];
    isClickPopUp = TRUE;
    
    self.navigationController.navigationBarHidden = YES;
    
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
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground4.png"]]];
    }
    
    self.lblMain.textAlignment      = NSTextAlignmentCenter;
    self.lblUserName.textAlignment  = NSTextAlignmentCenter;
    self.layerPosition              = self.topLayer.frame.origin.x;
    
    getUI = [MLUI new];
    
    
    //Get Data.plist
    [self getDataPlist];
}

#pragma mark -Get From data.plist
- (void) getDataPlist
{
    //Get Name From PLIST
    NSDictionary *dic   = [NSDictionary initRead_LoadWallet_Data];
    self.fullname       = [NSString stringWithFormat:@"%@ %@ %@",
                           [dic valueForKey:@"fname"],
                           [dic valueForKey:@"mname"],
                           [dic valueForKey:@"lname"]];
    
  
    
    
    
    self.lblUserName.text   = self.fullname;
    self.lblBalance.text    = [NSString stringWithFormat:@"%@", [self convertDecimal:[[dic objectForKey:@"balance"] doubleValue]]];
    self.lblWalletno.text   = [dic valueForKey:@"walletno"];
    self.lblDate.text       = [self getCurrentDate];
    
}

#pragma mark - get Current Date
- (NSString*)getCurrentDate
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE MMM dd, yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    NSLog(@"date: %@", dateString);
    
    return dateString;
}

//Tue, Feb. 18, 2014

#pragma mark - Convert to Decimal
- (NSString *)convertDecimal:(double)doubleValue{
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *bals = [currencyFormatter stringFromNumber:[NSNumber numberWithInt:doubleValue]];
    NSString *newStr = [bals substringFromIndex:1];
    return newStr;
}


#pragma mark -Pan Gesture
- (IBAction)panLayer:(UIPanGestureRecognizer *)pan {
    //Phone User
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (pan.state == UIGestureRecognizerStateChanged){
            CGPoint point = [pan translationInView:self.topLayer];
            CGRect frame = self.topLayer.frame;
            frame.origin.x = self.layerPosition + point.x;
        
            if (frame.origin.x > 160) frame.origin.x = 0;
            self.topLayer.frame = frame;
        }
    
        if (pan.state == UIGestureRecognizerStateEnded) {
            if (self.topLayer.frame.origin.x > -160)
            {
                [self animateLayerToPoint:0];
            
                //For Label
                [self.lblMain setBounds:CGRectMake(161, 112, 70, 21)];
                [self.lblAccount setHidden:NO];
                self.lblMain.text = @"MENU";
                self.lblMenu.text = @"";
            }else{
                [self animateLayerToPoint: VIEW_HIDDEN];
            
                //For Label
                [self.lblAccount setHidden:YES];
                self.lblMain.text = @"ACCOUNT";
                self.lblMenu.text = @"MENU";
            }
        }
    } else { //iPad User
        if (pan.state == UIGestureRecognizerStateChanged){
            CGPoint point = [pan translationInView:self.topLayer];
            CGRect frame = self.topLayer.frame;
            frame.origin.x = self.layerPosition + point.x;
            
            if (frame.origin.x > 300) frame.origin.x = 0;
            self.topLayer.frame = frame;
        }
        
        if (pan.state == UIGestureRecognizerStateEnded) {
            NSLog(@"TOPLayer X : %f", self.topLayer.frame.origin.x);
            if (self.topLayer.frame.origin.x > -200)
            {
                [self animateLayerToPoint:0];
                
                //For Label
                [self.lblMain setBounds:CGRectMake(161, 112, 70, 21)];
                [self.lblAccount setHidden:NO];
                self.lblMain.text = @"MENU";
                self.lblMenu.text = @"";
            }else{
                [self animateLayerToPoint: VIEW_HIDDEN_IPAD];
                
                //For Label
                [self.lblAccount setHidden:YES];
                self.lblMain.text = @"ACCOUNT";
                self.lblMenu.text = @"MENU";
            }
        }
    }
}

#pragma mark - #Animate Swipe
-(void) animateLayerToPoint:(CGFloat)x
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect frame = self.topLayer.frame;
                         frame.origin.x = x;
                         self.topLayer.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         self.layerPosition = self.topLayer.frame.origin.x;
                         
                     }];
    
}

#pragma Start #HIDE POPUP
- (void) hidePopUP
{
    [self.imgPopup setHidden:YES];
    [self.pop_btnInfo setHidden:YES];
    [self.pop_btnLocator setHidden:YES];
    [self.pop_btnRate setHidden:YES];

}

#pragma Start #SHOW POPUP
-(void) showPopUP
{
        [self.imgPopup setHidden:NO];
        [self.pop_btnInfo setHidden:NO];
        [self.pop_btnLocator setHidden:NO];
        [self.pop_btnRate setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Start Click Popup Button Rate
- (IBAction)pop_ActbtnRate:(id)sender {
    [UIAlertView myCostumeAlert:@"Button Rate" alertMessage:@"You click me" delegate:nil cancelButton:nil otherButtons:@"OK"];
}

#pragma Start Click Popup Button Locator
- (IBAction)pop_ActLocate:(id)sender {
    
    MapViewController *detailViewController = [[MapViewController alloc]
                                               initWithNibName:@"MapViewController"
                                               bundle:nil];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma Start Click Popup Button Info
- (IBAction)pop_ActbtnInfo:(id)sender {
    self.navigationController.navigationBarHidden = NO;
    InfoViewController *info = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    [self.navigationController pushViewController:info animated:YES];
}


#pragma Start Click KYC Button
- (IBAction)btnKYC:(id)sender {
    
    [UIView AnimationPopUp:self.kycLayer];
    [self.kycLayer setHidden:NO];
    
    isClickPopUp = FALSE;
    [self onClickOthers];
    
    //Blur layer
    [self.topLayer setAlpha:0.5f];
}

#pragma Start #KYC Gesture
- (IBAction)kycGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (sender) {
            isClickPopUp = TRUE;
            [self.kycLayer setHidden:YES];
            [self hidePopUP];
            //Blur layer
            [self.topLayer setAlpha:1.0f];
        }
    }
}

#pragma Start #Click Button Receiver @t KYC
- (IBAction)btnReceiver:(id)sender {
    
    self.kycLayer.hidden = YES;
    ReceiverMenuListViewController *nxtpage = [[ReceiverMenuListViewController alloc] initWithNibName:@"ReceiverMenuListViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:nxtpage animated:YES];
    
    //Blur layer
    [self.topLayer setAlpha:1.0f];
}


#pragma Start #Click button Logout
- (IBAction)btnLogout:(id)sender {
    UIAlertView *alertLogout = [[UIAlertView alloc] initWithTitle:@"Logout" message:@"Do you want to logout?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alertLogout show];
}

#pragma Start Delegate On Click #Logout Button
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self.navigationController popToRootViewControllerAnimated:YES];         
    }
}


#pragma Start #Click Button Others
- (IBAction)btnOthers:(id)sender {
    [self onClickOthers];
    [self.kycLayer setHidden:YES];
}

#pragma Start #Reload Button
- (IBAction)btnReload:(id)sender {
    
    TopupViewController *reloadController = [[TopupViewController alloc] initWithNibName:@"TopupViewController" bundle:nil];
    
    [self.navigationController pushViewController:reloadController animated:YES];
}



- (void) onClickOthers
{
    [UIView AnimationPopUp:self.imgPopup];
    if (isClickPopUp)
    {
        [self showPopUP];
        isClickPopUp = FALSE;
    }
    else
    {
        isClickPopUp = TRUE;
        [self hidePopUP];
    }
}




#pragma mark - Next View

- (IBAction)btnTopup_2nd_view:(id)sender {
    
    TopupViewController *reloadController = [[TopupViewController alloc] initWithNibName:@"TopupViewController" bundle:nil];
    
    [self.navigationController pushViewController:reloadController animated:YES];
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - Send mOney MENU
- (IBAction)btn_SendMoney:(id)sender {
    UIViewController *viewController1 = [[MLSendMoneyViewController alloc] initWithNibName:@"MLSendMoneyViewController" bundle:nil];
    UITableViewController *viewController2 = [[MLRatesTableViewController alloc] initWithNibName:@"MLRatesTableViewController" bundle:nil];
    
    [getUI navigationAppearance];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, viewController2];
    
    //object to customize tabBar
    [getUI customTabBar:self.tabBarController];
    
    [self.navigationController pushViewController:self.tabBarController animated:YES];
    self.tabBarController.navigationController.navigationBarHidden = NO;
    
}

- (IBAction)btnHistory:(id)sender {
    MLHistoryViewController *htr = [[MLHistoryViewController alloc] initWithNibName:@"MLHistoryViewController" bundle:nil];
    
    [getUI navigationAppearance];
    
    [self.navigationController pushViewController:htr animated:YES];
    self.navigationController.navigationBarHidden = NO;
}


- (IBAction)btn_Myprofile:(id)sender {
    AccountMain *accountMain = [[AccountMain alloc] initWithNibName:@"AccountMain" bundle:nil];

    
    [self.navigationController pushViewController:accountMain animated:YES];
    
    
    
    
}



@end
