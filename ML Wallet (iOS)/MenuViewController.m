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
#import "ServiceConnection.h"
#import "SaveWalletData.h"
#import "MLhuillierWebViewController.h"
#import "UIImage+DecodeStringToImage.h"
#import "AccountMainPad.h"

#import "SaveWalletData.h"


#define  VIEW_HIDDEN -320
#define  VIEW_HIDDEN_IPAD -580


@interface MenuViewController ()
{
    MLUI *getUI;
    NSNumber *walletno;
}
@end

@implementation MenuViewController
{
    BOOL isClickPopUp;
}

@synthesize topLayer = _topLayer;
@synthesize layerPosition = _layerPosition;
@synthesize responseData;


AccountMobilePad *account;
NSDate *date;
MBProgressHUD *HUD;

NSString *firstName ,*middleName, *lastName , *country, *province, *address, *zipcode, *gender, *bdate, *age, *mobileno, *emailadd, *nationality, *work, *answer1, *answer2, *answer3, *question1, *question2, *question3,
*walletNo, *respMessage, *resCode, *photo1, *photo2, *photo3, *photo4, *finalDateString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    //Refresh user
    self.responseData = [NSMutableData data];
    NSString *srvcURL1 = [[[ServiceConnection alloc] NSgetURLService] stringByAppendingString:@"RefreshUser/?walletno"];
    NSString *srvcURL = [NSString stringWithFormat:@"%@=%@",srvcURL1, walletno];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    
    NSLog(@"On resume");
    
}


#pragma mark -NSURLConnection Delegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIAlertView myCostumeAlert:@"Connection Error" alertMessage:[error localizedDescription] delegate:nil cancelButton:@"Ok" otherButtons:nil];
}
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // convert to JSON
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    if (myError == nil){
        NSArray *result = [res valueForKey:@"RefreshUserResult"];
        
        NSNumber *respCode  = [result valueForKey:@"respcode"];
        NSString *respMesg  = [result valueForKey:@"respmessage"];
        NSLog(@"Respmessage %@",respMesg);
        
        NSString *bal          = [result valueForKey:@"walletno"] ; //Itz Balance not wallet
        int attemps           = (int)[[result valueForKey:@"noofattempt"] integerValue] ;
        
        if ([respCode isEqualToNumber:[NSNumber numberWithInt:0]]) //Success
        {
            SaveWalletData *saveData = [SaveWalletData new];
            [saveData initSaveData:bal forKey:@"balance"];
            self.lblNoAttempts.text = [NSString stringWithFormat:@"%d", attemps];
        }
        
        [self getDataPlist];
    }
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self hidePopUP];
    isClickPopUp = TRUE;
    
    self.navigationController.navigationBarHidden = YES;
    [self.scrollView setScrollEnabled:YES];
    
    //Set Background
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        
        if ([UIScreen mainScreen].bounds.size.height == 568) //4 inch
        {
            [self.scrollView setContentSize:CGSizeMake(320, 568)];
        }
        else //4 inc below
        {
            self.logout.frame = CGRectMake(self.logout.frame.origin.x + 40,
                                           self.logout.frame.origin.y + 38,
                                           self.logout.frame.size.width,
                                           self.logout.frame.size.height);
            self.others.frame = CGRectMake(self.others.frame.origin.x - 38,
                                           self.others.frame.origin.y + 38,
                                           self.others.frame.size.width,
                                           self.others.frame.size.height);
            
            [self.scrollView setContentSize:CGSizeMake(320, 400)];
        }
    }
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    self.lblMain.textAlignment      = NSTextAlignmentCenter;
    self.lblUserName.textAlignment  = NSTextAlignmentCenter;
    self.layerPosition              = self.topLayer.frame.origin.x;
    
    getUI = [MLUI new];
    
    account = [AccountMobilePad new];
    account.delegate = self;
    
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
//    [self.scrollView setScrollEnabled:YES];
//    [self.scrollView setContentSize:CGSizeMake(320, 600)];
    
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
    walletno                = [dic valueForKey:@"walletno"];
    self.lblDate.text       = [self getCurrentDate];
    if (![[dic valueForKey:@"photo"] isEqualToString:@""]){
        self.imageUser.image = [UIImage decodeBase64ToImage:[NSString stringWithFormat:@"%@", [dic valueForKey:@"photo"]]];
    }
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
    NSString *bals = [currencyFormatter stringFromNumber:[NSNumber numberWithDouble:doubleValue]];
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
-(void) animateLayerToPoint:(CGFloat)x{
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
- (void) hidePopUP{
    [self.imgPopup setHidden:YES];
    [self.pop_btnInfo setHidden:YES];
    [self.pop_btnLocator setHidden:YES];
    [self.pop_btnRate setHidden:YES];

}

#pragma Start #SHOW POPUP
-(void) showPopUP{
        [self.imgPopup setHidden:NO];
        [self.pop_btnInfo setHidden:NO];
        [self.pop_btnLocator setHidden:NO];
        [self.pop_btnRate setHidden:NO];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Start Click Popup Button Rate
- (IBAction)pop_ActbtnRate:(id)sender {
//    [UIAlertView myCostumeAlert:@"Button Rate" alertMessage:@"You click me" delegate:nil cancelButton:nil otherButtons:@"OK"];
    
    MLRatesTableViewController *rates = [[MLRatesTableViewController alloc] initWithNibName:@"MLRatesTableViewController" bundle:nil];
    
    rates.indicator = @"menu";
    
    [self.navigationController pushViewController:rates animated:YES];
    self.navigationController.navigationBarHidden = NO;
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
//        LoginViewController *loginPage = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil navigationHidden:YES ];
//        [self.navigationController pushViewController:loginPage animated:YES];
        [self.navigationController removeFromParentViewController];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
//        LoginViewController *loginPage = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        
        //LoginViewController *loginPage = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil navigationHidden:YES ];
        
        //[self.navigationController pushViewController:loginPage animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark Button Webview
- (IBAction)bntWebview:(id)sender {
    MLhuillierWebViewController *webViewController = [[MLhuillierWebViewController alloc]
                                                      initWithNibName:@"MLhuillierWebViewController"
                                                      bundle:nil];
    
    [self.navigationController pushViewController:webViewController animated:YES];
}


- (IBAction)btn_Myprofile:(id)sender {

    
    [self checkDevice];
    
    
//    [UIAlertView myCostumeAlert:@"My Profile" alertMessage:@"Todo." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    
}


-(void)checkDevice{
    
    [self displayProgressBar];
    [account loadAccount];
    
    
    
}



- (void)didFinishLoadingRates:(NSString *)indicator andError:(NSString *)getError{
    
    
    [self dismissProgressBar];
    [self retrieveData];
    [self saveToPaylist];

    
    if([@"1" isEqualToString:[[NSString alloc] initWithFormat:@"%@", resCode]])
    {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            AccountMain *accountMain = [[AccountMain alloc] initWithNibName:@"AccountMain" bundle:nil];
            [self.navigationController pushViewController:accountMain animated:YES];
        }
        else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            AccountMainPad *accountMainPad = [[AccountMainPad alloc] initWithNibName:@"AccountMainPad" bundle:nil];
            [self.navigationController pushViewController:accountMainPad animated:YES];
        }
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:respMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alertView show];


    }
    
        
    
    
    
    
    
    
    

    

    
    
    
}

-(void)retrieveData{
    //Store the NSDictionary rates data into static array
    NSArray *accountArray       = [account.getAccount objectForKey:@"retrieveMobileAccountResult"];
    
    firstName = [accountArray valueForKey:@"fname"];
    middleName = [accountArray valueForKey:@"mname"];
    lastName = [accountArray valueForKey:@"lname"];
    country = [accountArray valueForKey:@"country"];
    province = [accountArray valueForKey:@"provinceCity"];
    address = [accountArray valueForKey:@"permanentAdd"];
    zipcode = [accountArray valueForKey:@"zipcode"];
    gender = [accountArray valueForKey:@"gender"];
    bdate = [accountArray valueForKey:@"bdate"];
    mobileno = [accountArray valueForKey:@"mobileno"];
    emailadd = [accountArray valueForKey:@"emailadd"];
    nationality = [accountArray valueForKey:@"nationality"];
    work = [accountArray valueForKey:@"natureOfWork"];
    
    
    
    answer1 = [accountArray valueForKey:@"secanswer1"];
    answer2 = [accountArray valueForKey:@"secanswer2"];
    answer3 = [accountArray valueForKey:@"secanswer3"];
    question1 = [accountArray valueForKey:@"secquestion1"];
    question2 = [accountArray valueForKey:@"secquestion2"];
    question3 = [accountArray valueForKey:@"secquestion3"];
    
    walletNo = [accountArray valueForKey:@"walletno"];
    
    respMessage = [accountArray valueForKey:@"respmessage"];
    resCode = [accountArray valueForKey:@"respcode"];
    
    photo1 = [accountArray valueForKey:@"photo1"];
    photo2 = [accountArray valueForKey:@"photo2"];
    photo3 = [accountArray valueForKey:@"photo3"];
    photo4 = [accountArray valueForKey:@"photo4"];
    
    
    
    //Format date====================================================
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    date = [dateFormatter dateFromString:bdate];
    [dateFormatter setDateFormat:@"MMM. dd, yyyy"];
    finalDateString = [dateFormatter stringFromDate:date];
    //End Format Date===============================================

}


-(int) userAge:(NSDate *)birthDay{
    
    NSDate* currentDate = [NSDate date];
    NSTimeInterval secondsBetween = [currentDate timeIntervalSinceDate:birthDay];
    int days = secondsBetween / 86400;
    int  age = days/ 364 ;
    return age;
}


-(void) saveToPaylist{
    
    SaveWalletData *saveData = [SaveWalletData new];
    
    int userAge = [self userAge:date];
    
    [saveData initSaveData:firstName forKey:@"fname"];
    [saveData initSaveData:middleName forKey:@"mname"];
    [saveData initSaveData:lastName forKey:@"lname"];
    [saveData initSaveData:country forKey:@"country"];
    [saveData initSaveData:province forKey:@"provinceCity"];
    [saveData initSaveData:address forKey:@"permanentAdd"];
    [saveData initSaveData:zipcode forKey:@"zipcode"];
    [saveData initSaveData:gender forKey:@"gender"];
    [saveData initSaveData:finalDateString forKey:@"bdate"];
    
    [saveData initSaveData:[NSString stringWithFormat:@"%i", userAge] forKey:@"age"];
    [saveData initSaveData:mobileno forKey:@"mobileno"];
    [saveData initSaveData:emailadd forKey:@"emailadd"];
    [saveData initSaveData:nationality forKey:@"nationality"];
    [saveData initSaveData:work forKey:@"natureOfWork"];
    
    
    [saveData initSaveData:answer1 forKey:@"secanswer1"];
    [saveData initSaveData:answer2 forKey:@"secanswer2"];
    [saveData initSaveData:answer3 forKey:@"secanswer3"];
    [saveData initSaveData:question1 forKey:@"secquestion1"];
    [saveData initSaveData:question2 forKey:@"secquestion2"];
    [saveData initSaveData:question3 forKey:@"secquestion3"];
    
    
    [saveData initSaveData:walletNo forKey:@"walletno"];
    
    
    [saveData initSaveData:photo1 forKey:@"photo1"];
    [saveData initSaveData:photo2 forKey:@"photo2"];
    [saveData initSaveData:photo3 forKey:@"photo3"];
    [saveData initSaveData:photo4 forKey:@"photo4"];
    
    
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


@end
