//
//  MLSendMoneyViewController.m
//  SendMoney
//
//  Created by mm20 on 2/17/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import "MLSendMoneyViewController.h"
#import "MLPreviewViewController.h"
#import "MLUI.h"
#import "JsonHelper.h"

#define TRUSTED_HOST @"192.168.12.204"

@interface MLSendMoneyViewController (){
    UITapGestureRecognizer *tapRecognizer;
    double inputPrint, conv, bal, total, amountValue;
    NSString *string1, *string2, *newString;
    NSArray *checkdot;
    UIImage *right, *wrong;
    MLUI *getUI;
    UIBarButtonItem *next, *home;
    UIImage *image, *payment;
    SendoutMobile *sendout;
    NSMutableData *contentData;
    NSURLConnection *conn;
    KpRates *rates;
    GetReceiver *getReceiver;
    NSMutableArray *getValueRates;
    NSDictionary *getCharges;
}

@end

@implementation MLSendMoneyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.tabBarController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    getUI = [MLUI new];
    rates = [KpRates new];
    getReceiver = [GetReceiver new];
    
    self.tabBarController.navigationItem.title = @"Send Money";
    //self.tabBarController.navigationItem.titleView = [getUI navTitle:@"Send Money"];
    
    wrong = [UIImage imageNamed:@"wrong.png"];
    right = [UIImage imageNamed:@"right.png"];
    
    //create a bar button
    next = [getUI navBarButton:self navLink:@selector(btn_preview:) imageNamed:@"next.png"];
    home = [getUI navBarButton:self navLink:@selector(btn_back:) imageNamed:@"home.png"];
    
    [self.tabBarController.navigationItem setRightBarButtonItem:next];
    [self.tabBarController.navigationItem setLeftBarButtonItem:home];
    
    [self setUpReceivers];
    
    self.view_main.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    _label_balance.font = [UIFont boldSystemFontOfSize:24.0f];
    _chargeValue.font = [UIFont boldSystemFontOfSize:24.0f];
    _totalValue.font = [UIFont boldSystemFontOfSize:24.0f];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        image = [UIImage imageNamed:@"content_bg"];
        payment = [UIImage imageNamed:@"payment_bg"];
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        image = [UIImage imageNamed:@"content_bg_ipad"];
        payment = [UIImage imageNamed:@"payment_bg_ipad"];
    }
    
    
    
    
    self.view_sender.backgroundColor = [UIColor colorWithPatternImage:image];
    self.view_receiver.backgroundColor = [UIColor colorWithPatternImage:image];
    self.view_charge.backgroundColor = [UIColor colorWithPatternImage:payment];
    self.view_total.backgroundColor = [UIColor colorWithPatternImage:payment];
    
    [self swipe];
    [self keyboardNotification];

    _spinner.hidesWhenStopped = YES;
    

    sendout = [[SendoutMobile alloc]initWithWalletNo:@"14050000000135" senderFname:@"ALBERT" senderMname:@"" senderLname:@"GAUDICOS" receiverFname:@"Arthur" receiverMname:@"A" receiverLname:@"Tarrayo" receiverNo:@"690" principal:@"1.0" latitude:@"-0.3234234" longitude:@"3.234343" location:@"Bohol, Philippines" deviceId:@"2342343423"];
    
    sendout.delegate = self;
    rates.delegate = self;
    getReceiver.delegate = self;
    
    //[_spinner startAnimating];
    
    //[sendout postDataToUrl];
    [rates loadRates];
    //[getReceiver getReceiverWalletNo:@"14050000000135"];

}

- (void)didFinishLoading{
    [_spinner stopAnimating];
    NSLog(@"KPTN: %@", sendout.getKptn);
}

- (void)didFinishLoadingRates{
    getCharges = rates.getRates;
    [_spinner stopAnimating];
    
}


- (void)didFinishLoadingReceiver{
    [_spinner stopAnimating];
    NSLog(@"Receiver: %@", getReceiver.getReceiver);
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)keyboardNotification{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
}

- (void)keyboardWillShow:(NSNotification *) note{
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)keyboardWillHide:(NSNotification *) note{
    [self.view removeGestureRecognizer:tapRecognizer];
}

- (void)didTapAnywhere: (UITapGestureRecognizer *) recognizer{
    [_tf_amount resignFirstResponder];
}

- (void)swipe{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(right)];
    
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
}

- (void)right{
    self.tabBarController.selectedIndex = 1;
    [self.navigationController.tabBarController.navigationController popViewControllerAnimated:YES];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)deregisterFromKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    self.tabBarController.navigationItem.title = @"Send Money";
    [self.tabBarController.navigationItem setRightBarButtonItem:next];
    [self.tabBarController.navigationItem setLeftBarButtonItem:home];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self deregisterFromKeyboardNotifications];
    [super viewWillDisappear:animated];
}

- (void)keyboardWasShown:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGPoint viewOrigin = self.view_main.frame.origin;
    CGFloat viewHeight = self.view_main.frame.size.height;
    CGRect visibleRect = self.view.frame;
    visibleRect.size.height -= keyboardSize.height;
    
    if(CGRectContainsPoint(visibleRect, viewOrigin)){
        CGPoint scrollPoint = CGPointMake(0.0, viewOrigin.y - visibleRect.size.height + viewHeight-40);
        [self.scroll_main setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)notifcation{
    [self.scroll_main setContentOffset:CGPointZero animated:YES];
}

- (IBAction)btn_preview:(id)sender {
    MLPreviewViewController *preview = [[MLPreviewViewController alloc] initWithNibName:@"MLPreviewViewController" bundle:nil];
    preview.str = @"GGGG";
    preview.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:preview animated:YES];
}

- (IBAction)btn_back:(id)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btn_receiver:(id)sender {
    MLReceiverTableViewController *view_receiver = [[MLReceiverTableViewController alloc]initWithNibName:@"MLReceiverTableViewController" bundle:nil];
    
    view_receiver.delegate = self;
    view_receiver.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view_receiver animated:YES];
}

- (void)didSelectReceiver:(MLReceiverTableViewController *)controller receiverFname:(NSString *)rfname receiverMname:(NSString *)rmname receiverLname:(NSString *)rlname receiverImage:(NSString *)rimage receiverAddress:(NSString *)raddress receiverRelation:(NSString *)rrelation rcount:(int)count{
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];

    NSData *data = [[NSData alloc] initWithBase64EncodedString:rimage options: NSDataBase64DecodingIgnoreUnknownCharacters];
    
    if ([UIImage imageWithData:data] == nil) {
        _receiverImage.image = [UIImage imageNamed:@"noImage.png"];
    }else{
        _receiverImage.image = [UIImage imageWithData:data];
    }
    

    _receiverName.text = [NSString stringWithFormat:@"%@, %@ %@", rlname, rfname, rmname];
    _receiverAddress.text = raddress;
    _countReceiver.text =[NSString stringWithFormat:@"You have %d receivers.", count];

    [self setUpReceivers];
}

-(void)setAmount:(double)input{
    
    NSArray *ratess = [getCharges objectForKey:@"getChargeValuesResult"];
    getValueRates = [ratess valueForKey:@"<chargeList>k__BackingField"];
    
    
    for (NSDictionary *items in getValueRates) {
        
        NSString *minAmount  = [items valueForKey:@"minAmount"];
        NSString *maxAmount  = [items valueForKey:@"maxAmount"];
        NSString *ch  = [items valueForKey:@"chargeValue"];
        int charge = [ch integerValue];
        int min = [minAmount integerValue];
        int max = [maxAmount integerValue];

        if (input >= min && input <= max) {
            string1 = [NSString stringWithFormat:@"%@", ch];
            inputPrint = input + charge;
            [self display:inputPrint charge:string1];
            break;
        }else{
            string1 = @"0.00";
            inputPrint = 0.00;
            [self display:inputPrint charge:string1];
            _tf_amount.rightView = [[UIImageView alloc] initWithImage:nil];
            
        }
        
    }
    
//    if (input >= 0.01 && input <= 100.00) {
//        string1 = @"7.00";
//        inputPrint = input + 7.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 100.01 && input <= 200.00) {
//        string1 = @"13.00";
//        inputPrint = input + 13.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 200.02 && input <= 300.00) {
//        string1 = @"18.00";
//        inputPrint = input + 18.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 300.01 && input <= 400.00) {
//        string1 = @"25.00";
//        inputPrint = input + 25.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 400.01 && input <= 500.00) {
//        string1 = @"30.00";
//        inputPrint = input + 30.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 500.01 && input <= 600.00) {
//        string1 = @"35.00";
//        inputPrint = input + 35.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 600.01 && input <= 800.00) {
//        string1 = @"40.00";
//        inputPrint = input + 40.00;
//        [self display:inputPrint charge:string1];;
//    }else if(input >= 800.01 && input <= 900.00) {
//        string1 = @"45.00";
//        inputPrint = input + 45.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 900.01 && input <= 1000.00) {
//        string1 = @"50.00";
//        inputPrint = input + 50.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 1000.01 && input <= 1500.00) {
//        string1 = @"80.00";
//        inputPrint = input + 80.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 1500.01 && input <= 2000.00) {
//        string1 = @"100.00";
//        inputPrint = input + 100.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 2000.01 && input <= 2500.00) {
//        string1 = @"130.00";
//        inputPrint = input + 130.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 2500.01 && input <= 3000.00) {
//        string1 = @"150.00";
//        inputPrint = input + 150.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 3000.01 && input <= 4000.00) {
//        string1 = @"180.00";
//        inputPrint = input + 180.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 4000.01 && input <= 9500.00) {
//        string1 = @"220.00";
//        inputPrint = input + 220.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 9500.01 && input <= 14000.00) {
//        string1 = @"240.00";
//        inputPrint = input + 240.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 14000.01 && input <= 30000.00) {
//        string1 = @"300.00";
//        inputPrint = input + 300.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 30000.01 && input <= 40000.00) {
//        string1 = @"350.00";
//        inputPrint = input + 350.00;
//        [self display:inputPrint charge:string1];
//    }else if(input >= 40000.01 && input <= 50000.00) {
//        string1 = @"400.00";
//        inputPrint = input + 400.00;
//        [self display:inputPrint charge:string1];
//    }else{
//        string1 = @"0.00";
//        inputPrint = 0.00;
//        [self display:inputPrint charge:string1];
//        _tf_amount.rightView = [[UIImageView alloc] initWithImage:nil];
//        
//    }
    
    checkdot = [newString componentsSeparatedByString:@"."];
    conv = [string1 doubleValue];
    total = conv + input;
    bal = [@"2888.00" doubleValue];
    if (total > bal) {
        [getUI displayAlert:@"Validation Error" message:@"Insuficient Balance!"];
        _tf_amount.rightView = [[UIImageView alloc] initWithImage:wrong];
    }
    
    if([checkdot count] >=3){
        _tf_amount.rightView = [[UIImageView alloc] initWithImage:wrong];
        [getUI displayAlert:@"Validation Error" message:@"Invalid Amount!"];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    newString = [_tf_amount.text stringByReplacingCharactersInRange:range withString:string];
    [_tf_amount setRightViewMode:UITextFieldViewModeAlways];
    
    amountValue = [newString doubleValue];
    [self setAmount:amountValue];
    
    return YES;
}

- (void)display:(double) input charge:(NSString *) charge{
    string2 = [NSString stringWithFormat:@"%0.2f", inputPrint];
    _tf_amount.rightView = [[UIImageView alloc] initWithImage:right];
    [self setValue:charge total:string2];
}

- (void)setValue:(NSString *)charge total:(NSString *)gettotal{
    [_chargeValue setText:charge];
    [_totalValue setText:gettotal];
}

- (void)setUpReceivers{
    
    if([_receiverName.text isEqualToString:@""]){
        _receiverName.hidden = YES;
        _receiverAddress.hidden = YES;
        [_btn_receiver setTitle:@"Select" forState:UIControlStateNormal];
    }else{
        _lblNoReceiver.hidden = YES;
        _receiverName.hidden = NO;
        _receiverAddress.hidden = NO;
        [_btn_receiver setTitle:@"Change" forState:UIControlStateNormal];
    }
    
}


@end
