//
//  MLPreviewViewController.m
//  SendMoney
//
//  Created by mm20 on 2/17/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import "MLPreviewViewController.h"
#import "MLSendMoneyViewController.h"
#import "MLUI.h"
#import <QuartzCore/QuartzCore.h>
#import "MLTermsConditionViewController.h"

@interface MLPreviewViewController (){
    MLUI *getUI;
    UIBarButtonItem *next;
}

@end

@implementation MLPreviewViewController

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
    // Do any additional setup after loading the view from its nib.

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    self.view_keyboard.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    self.preview_main.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    self.view_content.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"preview_bg"]];
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    getUI = [MLUI new];
    self.navigationItem.titleView = [getUI navTitle:@"Preview"];
    
    //next = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"next.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btn_pin)];
    
    
    
    UIBarButtonItem *home = [getUI navBarButtonPreview:self navLink:@selector(btn_back:) imageNamed:@"back.png"];
    
    [self.navigationItem setRightBarButtonItem:next];
    [self.navigationItem setLeftBarButtonItem:home];
    
    
    [self shadowView];
    
    _image_mine.layer.cornerRadius = 20;
    _image_mine.clipsToBounds = YES;
    _image_receiver.layer.cornerRadius = 20;
    _image_receiver.clipsToBounds = YES;
    _view_keyboard.hidden = YES;
    
    [self setText:_tf_pin1];
    
    
}

- (IBAction)btn_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shadowView{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.view_content.bounds];
    self.view_content.layer.masksToBounds = NO;
    self.view_content.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view_content.layer.shadowOffset = CGSizeMake(0.0f, 8.0f);
    self.view_content.layer.shadowOpacity = 0.12f;
    self.view_content.layer.shadowPath = shadowPath.CGPath;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btn_pin{
    
    MLTermsConditionViewController *tc = [[MLTermsConditionViewController alloc]initWithNibName:@"MLTermsConditionViewController" bundle:nil];
    
    NSString *pin = [NSString stringWithFormat:@"%@%@%@%@",_tf_pin1.text, _tf_pin2.text, _tf_pin3.text, _tf_pin4.text];
    if (![pin isEqualToString:@"1234"]) {
        [getUI displayAlert:@"Message" message:@"Pin doesn't match!"];
        [self reset];
    }else{
        [self.navigationController pushViewController:tc animated:YES];
    }
    
}
- (IBAction)swipeGesture:(UISwipeGestureRecognizer *)sender {
    
    if(sender.direction == UISwipeGestureRecognizerDirectionLeft){
        [self btn_pin];
    }
    if(sender.direction == UISwipeGestureRecognizerDirectionRight){
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
}

- (IBAction)tapPreview:(UITapGestureRecognizer *)sender {
    [self.preview_scroll setContentSize:CGSizeMake(320, 400)];
    self.view_pinInput.alpha = 1.0;
    self.view_keyboard.alpha = 1.0;
    self.view_content.alpha = 0.0;
    [self reset];
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _view_keyboard.hidden = NO;
        self.view_pinInput.alpha = 0.0;
        self.view_keyboard.alpha = 0.0;
        self.view_content.alpha = 1;
    }completion:^(BOOL finished) {
        
    }];
    
    [_view_content setAlpha:1];
    self.navigationItem.titleView = [getUI navTitle:@"Preview"];
    [self.navigationItem setRightBarButtonItem:nil];
}


- (IBAction)btn_pin:(id)sender {
    [self.preview_scroll setContentSize:CGSizeMake(320, 400)];
    self.view_pinInput.alpha = 0.0;
    self.view_keyboard.alpha = 0.0;
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _view_keyboard.hidden = NO;
        self.view_pinInput.alpha = 1.0;
        self.view_keyboard.alpha = 1.0;
    }completion:^(BOOL finished) {
        
    }];
    
    [_view_content setAlpha:0.1f];
    self.navigationItem.titleView = [getUI navTitle:@"Enter Your Pin"];
    next = [getUI navBarButtonPreview:self navLink:@selector(btn_pin) imageNamed:@"next.png"];
    [self.navigationItem setRightBarButtonItem:next];
    _view_pinInput.hidden = NO;
}

- (void)reset{
    _tf_pin1.text = @"";
    _tf_pin2.text = @"";
    _tf_pin3.text = @"";
    _tf_pin4.text = @"";
    
    _btnOne.enabled = YES;
    _btnTwo.enabled = YES;
    _btnThree.enabled = YES;
    _btnFour.enabled = YES;
    _btnFive.enabled = YES;
    _btnSix.enabled = YES;
    _btnSeven.enabled = YES;
    _btnEight.enabled = YES;
    _btnNine.enabled = YES;
    _btnZero.enabled = YES;
    
    [self setText:_tf_pin1];

}

- (IBAction)btnOne:(id)sender {
    [self getText].text = @"1";
    [self setText:[self nextField]];
}

- (IBAction)btnTwo:(id)sender {
    [self getText].text = @"2";
    [self setText:[self nextField]];
}

- (IBAction)btnThree:(id)sender {
    [self getText].text = @"3";
    [self setText:[self nextField]];
}

- (IBAction)btnFour:(id)sender {
    [self getText].text = @"4";
    [self setText:[self nextField]];
}

- (IBAction)btnFive:(id)sender {
    [self getText].text = @"5";
    [self setText:[self nextField]];
}

- (IBAction)btnSix:(id)sender {
    [self getText].text = @"6";
    [self setText:[self nextField]];
}

- (IBAction)btnSeven:(id)sender {
    [self getText].text = @"7";
    [self setText:[self nextField]];
}

- (IBAction)btnEight:(id)sender {
    [self getText].text = @"8";
    [self setText:[self nextField]];
}

- (IBAction)btnNine:(id)sender {
    [self getText].text = @"9";
    [self setText:[self nextField]];
}

- (IBAction)btnZero:(id)sender {
    [self getText].text = @"0";
    [self setText:[self nextField]];
}


- (IBAction)btnClear:(id)sender {
    [self reset];
}

- (UITextField *)nextField{
    UITextField *checkNext;
    if (![_tf_pin1.text isEqualToString:@""]) {
        checkNext = _tf_pin2;
    }
    
    if (![_tf_pin2.text isEqualToString:@""]) {
        checkNext = _tf_pin3;
    }
    
    if (![_tf_pin3.text isEqualToString:@""]) {
        checkNext = _tf_pin4;
    }
    
    if (![_tf_pin4.text isEqualToString:@""]) {
        _btnOne.enabled = NO;
        _btnTwo.enabled = NO;
        _btnThree.enabled = NO;
        _btnFour.enabled = NO;
        _btnFive.enabled = NO;
        _btnSix.enabled = NO;
        _btnSeven.enabled = NO;
        _btnEight.enabled = NO;
        _btnNine.enabled = NO;
        _btnZero.enabled = NO;
    }
    
    return checkNext;
}

@end
