//
//  MLPreviewViewController.h
//  SendMoney
//
//  Created by mm20 on 2/17/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLPreviewViewController : UIViewController
@property (weak, nonatomic, getter = getText, setter = setText:) UITextField *setField;
@property (weak, nonatomic) IBOutlet UIView *preview_main;
@property (weak, nonatomic) IBOutlet UIView *view_content;
- (IBAction)swipeGesture:(UISwipeGestureRecognizer *)sender;
- (IBAction)tapPreview:(UITapGestureRecognizer *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *image_mine;
@property (weak, nonatomic) IBOutlet UIImageView *image_receiver;
- (IBAction)btn_pin:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view_keyboard;
@property (weak, nonatomic) IBOutlet UIScrollView *preview_scroll;
@property (weak, nonatomic) IBOutlet UIView *view_pinInput;

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
