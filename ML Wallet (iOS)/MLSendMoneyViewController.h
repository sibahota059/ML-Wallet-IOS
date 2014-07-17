//
//  MLSendMoneyViewController.h
//  SendMoney
//
//  Created by mm20 on 2/17/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLReceiverTableViewController.h"

@interface MLSendMoneyViewController : UIViewController<UITextFieldDelegate, MLReceiverTableViewControllerDelegate>

//outlet
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

//action
- (IBAction)btn_receiver:(id)sender;

@end
