//
//  MLTermsConditionViewController.h
//  SendMoney
//
//  Created by mm20 on 2/26/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendoutMobile.h"
#import "MBProgressHUD.h"
#import "SendEmail.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "SavePartnersBill.h"

@protocol MLTermsConditionViewControllerDelegate <NSObject>

- (void)didSuccessTransaction:(NSString *)log;

@end

@interface MLTermsConditionViewController : UIViewController<SendoutMobileDelegate, MBProgressHUDDelegate, SendKptnDelegate, MFMessageComposeViewControllerDelegate, SavePartnersDelegate>

@property (weak, nonatomic) id<MLTermsConditionViewControllerDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITextView *tv_termsCondition;
@property (weak, nonatomic) IBOutlet UIView *view_tc;
@property (weak, nonatomic) IBOutlet UIView *view_success;
@property (weak, nonatomic) IBOutlet UIView *view_successOption;

@property (strong, nonatomic) NSString *_walletNo;
@property (strong, nonatomic) NSString *_senderLname;
@property (strong, nonatomic) NSString *_senderFname;
@property (strong, nonatomic) NSString *_senderMname;
@property (strong, nonatomic) NSString *_receiverLname;
@property (strong, nonatomic) NSString *_receiverFname;
@property (strong, nonatomic) NSString *_receiverMname;
@property (strong, nonatomic) NSString *_senderImage;
@property (strong, nonatomic) NSString *_latitude;
@property (strong, nonatomic) NSString *_longitude;
@property (strong, nonatomic) NSString *_divice;
@property (strong, nonatomic) NSString *_location;
@property (strong, nonatomic) NSString *_receiverNo;
@property (strong, nonatomic) NSString *_operatorId;
@property (strong, nonatomic) NSString *_bcode;
@property (strong, nonatomic) NSString *_zcode;
@property (strong, nonatomic) NSString *_kptn;
@property (strong, nonatomic) NSString *_partnersId;
@property (strong, nonatomic) NSString *_accountNo;
@property (strong, nonatomic) NSString *_transType;
@property (strong, nonatomic) NSString *_amount;
@property (strong, nonatomic) NSString *_customerCharge;
@property (strong, nonatomic) NSString *_partnersCharge;

- (IBAction)btnDecline:(id)sender;
- (IBAction)btnAgree:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDecline;
@property (weak, nonatomic) IBOutlet UIButton *btnAgree;
@property (weak, nonatomic) IBOutlet UIView *view_dialogHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbl_kptn;
- (IBAction)btnClose:(id)sender;
- (IBAction)btnSms:(id)sender;
- (IBAction)btnEmail:(id)sender;
- (IBAction)btnContinue:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewConfirm;
- (IBAction)btnOnother:(id)sender;
- (IBAction)btnDone:(id)sender;

@property (strong, nonatomic) UITabBarController *tabBarController;
@end
