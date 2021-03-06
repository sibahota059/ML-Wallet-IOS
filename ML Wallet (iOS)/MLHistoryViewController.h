//
//  MLHistoryViewController.h
//  SendMoney
//
//  Created by mm20 on 3/3/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadHistory.h"
#import "MBProgressHUD.h"
#import "CheckPin.h"
#import "SoCancel.h"
#import "PrintTransaction.h"

@interface MLHistoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, LoadHistoryDelegate, MBProgressHUDDelegate, CheckPinDelegate, SoCancelDelegate, PrintTransactionDelegate>

@property (weak, nonatomic, getter = getTextField, setter = setTextField:) UITextField *setField;
@property (weak, nonatomic) IBOutlet UITableView *tblHistory;
@property (weak, nonatomic) IBOutlet UIView *view_header;
@property (weak, nonatomic) IBOutlet UIView *view_transform;
@property (weak, nonatomic) IBOutlet UIButton *btnExit;
@property (weak, nonatomic) IBOutlet UIView *viewHistoryHeader;

@property (weak, nonatomic) IBOutlet UIView *view_fade;
- (IBAction)btnClose:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelKptn;
@property (weak, nonatomic) IBOutlet UILabel *labelReceiverId;
@property (weak, nonatomic) IBOutlet UILabel *labelType;
@property (weak, nonatomic) IBOutlet UIImageView *img_status;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;
@property (weak, nonatomic) IBOutlet UIView *view_keyboard;
@property (weak, nonatomic) IBOutlet UIView *view_pinInput;
@property (weak, nonatomic) IBOutlet UIView *view_inputted;
- (IBAction)btn_cancel:(id)sender;
- (IBAction)didTapSurface:(UITapGestureRecognizer *)sender;

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
