//
//  MenuViewController.h
//  ML Wallet
//
//  Created by ml on 2/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountMobilePad.h"
#import "MBProgressHUD.h"


@interface MenuViewController : UIViewController <UIAlertViewDelegate, AccountMobilePadDelegate, MBProgressHUDDelegate>

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) NSMutableData *responseData;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imgPopup;

- (IBAction)pop_ActbtnRate:(id)sender;
- (IBAction)pop_ActLocate:(id)sender;
- (IBAction)pop_ActbtnInfo:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *topLayer;
- (IBAction)panLayer:(id)sender;
@property (nonatomic) CGFloat layerPosition;
@property (strong, nonatomic) IBOutlet UILabel *lblMain;
@property (strong, nonatomic) IBOutlet UILabel *lblAccount;
@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UILabel *lblMenu;
@property (strong, nonatomic) IBOutlet UILabel *lblNoAttempts;


@property (strong, nonatomic) IBOutlet UIButton *pop_btnLocator;
@property (strong, nonatomic) IBOutlet UIButton *pop_btnInfo;
@property (strong, nonatomic) IBOutlet UIButton *pop_btnRate;
@property (strong, nonatomic) IBOutlet UIView *kycLayer;
@property (strong, nonatomic) IBOutlet UIImageView *imageUser;

#pragma Middle Button
- (IBAction)btnKYC:(id)sender;
- (IBAction)kycGesture:(id)sender;
- (IBAction)btnReceiver:(id)sender;
- (IBAction)btn_Myprofile:(id)sender;
- (IBAction)btn_SendMoney:(id)sender;


#pragma Buttom Button
- (IBAction)btnLogout:(id)sender;
- (IBAction)btnOthers:(id)sender;
- (IBAction)btnReload:(id)sender;
- (IBAction)btnHistory:(id)sender;
- (IBAction)bntWebview:(id)sender;
- (IBAction)btnBillsPay:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lblBalance;
@property (strong, nonatomic) IBOutlet UILabel *lblWalletno;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UIButton *logout;
@property (strong, nonatomic) IBOutlet UIButton *mlSite;
@property (strong, nonatomic) IBOutlet UIButton *others;
@property (strong, nonatomic) IBOutlet UIView *view_Others;

//Assign From LoginviewController
@property (assign, nonatomic) NSString *fullname;
@end
