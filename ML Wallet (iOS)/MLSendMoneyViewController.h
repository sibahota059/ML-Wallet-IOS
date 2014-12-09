//
//  MLSendMoneyViewController.h
//  SendMoney
//
//  Created by mm20 on 2/17/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLReceiverTableViewController.h"
#import "SendoutMobile.h"
#import "KpRates.h"
#import "KpRatesOwn.h"
#import "GetReceiver.h"
#import "MBProgressHUD.h"
#import "PartnersTableViewController.h"
#import "RetrievePartnersAccount.h"
#import "SendoutPartnersBill.h"

@class RadioButton;

@interface MLSendMoneyViewController : UIViewController<UITextFieldDelegate, MLReceiverTableViewControllerDelegate, NSURLConnectionDelegate, KpRatesDelegate, KpRatesDelegateOwn, GetReceiverDelegate, MBProgressHUDDelegate, PartnersTableViewControllerDelegate, GetPartnersDelegate, SendoutPartnersBillDelegate>

//@property (weak, nonatomic) id<GetKptnDelegate>delegate;

//outlet

@property (weak, nonatomic) IBOutlet RadioButton *radioButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_main;
@property (weak, nonatomic) IBOutlet UIView *view_main;
@property (weak, nonatomic) IBOutlet UIView *view_sender;
@property (weak, nonatomic) IBOutlet UIView *view_receiver;
@property (weak, nonatomic) IBOutlet UIView *view_charge;
@property (weak, nonatomic) IBOutlet UIView *view_total;
@property (weak, nonatomic) IBOutlet UILabel *chargeValue;
@property (weak, nonatomic) IBOutlet UILabel *totalValue;
@property (weak, nonatomic) IBOutlet UILabel *label_balance;
@property (weak, nonatomic) IBOutlet UITextField *tf_amount;

@property (weak, nonatomic) IBOutlet UIImageView *senderImage;
@property (weak, nonatomic) IBOutlet UILabel *senderName;
@property (weak, nonatomic) IBOutlet UILabel *senderAddress;

@property (weak, nonatomic) IBOutlet UIImageView *receiverImage;
@property (weak, nonatomic) IBOutlet UILabel *receiverName;
@property (weak, nonatomic) IBOutlet UILabel *receiverAddress;

@property (weak, nonatomic) IBOutlet UILabel *countReceiver;
@property (weak, nonatomic) IBOutlet UILabel *lblNoReceiver;
@property (weak, nonatomic) IBOutlet UIButton *btn_receiver;
@property (strong, nonatomic) NSString *chTotal;
@property (weak, nonatomic) IBOutlet UIView *view_partners;
@property (weak, nonatomic) IBOutlet UIView *view_accountno;
@property (weak, nonatomic) IBOutlet UIButton *ch_sendOwn;
@property (weak, nonatomic) IBOutlet UIButton *btnPartners;
@property (weak, nonatomic) IBOutlet UIButton *btnAccount;
@property (weak, nonatomic) IBOutlet UILabel *lbl_partners;
@property (weak, nonatomic) IBOutlet UILabel *lbl_account;

//action
- (IBAction)btn_receiver:(id)sender;
- (IBAction)onRadioButton:(RadioButton *)sender;
- (IBAction)ch_sendOwn:(id)sender;
- (IBAction)btnPartners:(id)sender;
- (IBAction)btnAccount:(id)sender;







@end
