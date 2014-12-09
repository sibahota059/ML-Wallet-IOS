//
//  MLPreviewViewController.h
//  SendMoney
//
//  Created by mm20 on 2/17/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckPin.h"
#import "MBProgressHUD.h"

@interface MLPreviewViewController : UIViewController<CheckPinDelegate, MBProgressHUDDelegate>

@property (weak, nonatomic, getter = getText, setter = setText:) UITextField *setField;
@property (weak, nonatomic) IBOutlet UIView *preview_main;
@property (weak, nonatomic) IBOutlet UIView *view_content;
@property (weak, nonatomic) IBOutlet UIImageView *image_mine;
@property (weak, nonatomic) IBOutlet UIImageView *image_receiver;
@property (weak, nonatomic) IBOutlet UIView *view_keyboard;
@property (weak, nonatomic) IBOutlet UIScrollView *preview_scroll;
@property (weak, nonatomic) IBOutlet UIView *view_pinInput;
@property (weak, nonatomic) IBOutlet UIButton *btn_pin;
@property (weak, nonatomic) IBOutlet UITextField *tf_pin1;
@property (weak, nonatomic) IBOutlet UITextField *tf_pin2;
@property (weak, nonatomic) IBOutlet UITextField *tf_pin3;
@property (weak, nonatomic) IBOutlet UITextField *tf_pin4;
@property (weak, nonatomic) IBOutlet UIButton *btnOne;
@property (weak, nonatomic) IBOutlet UIButton *btnTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnThree;
@property (weak, nonatomic) IBOutlet UIButton *btnFour;
@property (weak, nonatomic) IBOutlet UIButton *btnFive;
@property (weak, nonatomic) IBOutlet UIButton *btnSix;
@property (weak, nonatomic) IBOutlet UIButton *btnSeven;
@property (weak, nonatomic) IBOutlet UIButton *btnEight;
@property (weak, nonatomic) IBOutlet UIButton *btnNine;
@property (weak, nonatomic) IBOutlet UIButton *btnZero;
@property (weak, nonatomic) IBOutlet UIButton *btnClear;
@property (weak, nonatomic) IBOutlet UILabel *lbl_sname;
@property (weak, nonatomic) IBOutlet UILabel *lbl_rname;
@property (weak, nonatomic) IBOutlet UILabel *lbl_amount;
@property (weak, nonatomic) IBOutlet UILabel *lbl_charge;
@property (weak, nonatomic) IBOutlet UILabel *lbl_total;

@property (strong, nonatomic) NSString *_walletNo;
@property (strong, nonatomic) NSString *_senderLname;
@property (strong, nonatomic) NSString *_senderFname;
@property (strong, nonatomic) NSString *_senderMname;
@property (strong, nonatomic) NSString *_receiverLname;
@property (strong, nonatomic) NSString *_receiverFname;
@property (strong, nonatomic) NSString *_receiverMname;
@property (strong, nonatomic) NSString *_senderImage;
@property (strong, nonatomic) NSString *_receiver_image;
@property (strong, nonatomic) NSString *_amount;
@property (strong, nonatomic) NSString *_charge;
@property (strong, nonatomic) NSString *_total;
@property (strong, nonatomic) NSString *_latitude;
@property (strong, nonatomic) NSString *_longitude;
@property (strong, nonatomic) NSString *_divice;
@property (strong, nonatomic) NSString *_location;
@property (strong, nonatomic) NSString *_receiverNo;
@property (strong, nonatomic) NSString *_transType;
@property (strong, nonatomic) NSString *_operatorId;
@property (strong, nonatomic) NSString *_bcode;
@property (strong, nonatomic) NSString *_zcode;
@property (strong, nonatomic) NSString *_kptn;
@property (strong, nonatomic) NSString *_partnersId;
@property (strong, nonatomic) NSString *_accountNo;
@property (strong, nonatomic) NSString *_customerCharge;
@property (strong, nonatomic) NSString *_partnersCharge;

- (IBAction)tapPreview:(UITapGestureRecognizer *)sender;
- (IBAction)btn_pin:(id)sender;
- (IBAction)btnOne:(id)sender;
- (IBAction)btnTwo:(id)sender;
- (IBAction)btnThree:(id)sender;
- (IBAction)btnFour:(id)sender;
- (IBAction)btnFive:(id)sender;
- (IBAction)btnSix:(id)sender;
- (IBAction)btnSeven:(id)sender;
- (IBAction)btnEight:(id)sender;
- (IBAction)btnNine:(id)sender;
- (IBAction)btnZero:(id)sender;
- (IBAction)btnClear:(id)sender;
@end
