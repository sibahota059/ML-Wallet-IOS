//
//  ResetPassViewController.m
//  ML Wallet
//
//  Created by ml on 7/25/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "ResetPassViewController.h"
#import "UITextfieldAnimate.h"
#import "ServiceConnection.h"
#import "UIAlertView+alertMe.h"
#import "MBProgressHUD.h"

@interface ResetPassViewController ()

@end

@implementation ResetPassViewController
{
    UITextfieldAnimate *textAnimate;
}

@synthesize responseData;

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
    self.navigationController.navigationBarHidden = NO;
    self.title= @"Forgot Password";
    //WaitScreen
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
    
    //Define
    searchWhereOptions = [[NSMutableArray alloc] init];
    [searchWhereOptions addObject:@"What is your school in sixth grade?"];
    [searchWhereOptions addObject:@"What's your childhood nickname?"];
    [searchWhereOptions addObject:@"What's your mom's middle name?"];
    [searchWhereOptions addObject:@"What city was your first job?"];
    [searchWhereOptions addObject:@"What is your favorite movie?"];
    [searchWhereOptions addObject:@"What is your favorite TV program?"];
    [searchWhereOptions addObject:@"What city were you born?"];
    [searchWhereOptions addObject:@"Where did your parent's meet?"];
    [searchWhereOptions addObject:@"Whats your dad's middle name?"];
    
    // default list option to select
    selectedOption = 0;
    
    //Set Background
    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self define];
    
    //Add Navigator Button
    UIBarButtonItem *buttonForgotPass = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"next.png"]
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(ForgotPass)];
    

    self.navigationItem.rightBarButtonItem = buttonForgotPass;
}

- (void)ForgotPass
{
    NSString *username = self.lblUsername.text;
    NSString *emailadd = self.lblEmail.text;
    NSString *question = self.lblSecQuestion.text;
    NSString *seanswer = self.lblAnswer.text;
    NSString *msg = @"";
    
    if ([username isEqualToString:@""]) {
        msg = @"Type username";
    } else if ([emailadd isEqualToString:@""]) {
        msg = @"Type email address";
    } else if ([question isEqualToString:@""]) {
        msg = @"Select a question";
    } else if ([seanswer isEqualToString:@""]) {
        msg = @"Type your secret answer";
    }
    if (![msg isEqualToString:@""]) {
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:msg delegate:nil cancelButton:@"Ok" otherButtons:nil];
        return;
    }

    responseData = [NSMutableData new];
    
    //Show Animated
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES navigatorItem:self.navigationItem];

    [self SendReq_ForgotPass];
}

#pragma mark - Define
- (void)define
{
    self.lblAnswer.delegate         = self;
    self.lblEmail.delegate          = self;
    self.lblSecQuestion.delegate    = self;
    self.lblUsername.delegate       = self;
    textAnimate = [UITextfieldAnimate new];
}

#pragma mark  - UITextFieldDelegate
- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    [textAnimate animateTextField:textField up:YES SelfView:self.view];
}
- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [textAnimate animateTextField:textField up:NO SelfView:self.view];
    [self.view endEditing:YES];

    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.lblUsername) {
        [self.lblEmail becomeFirstResponder];
        [self.lblUsername resignFirstResponder];
    } else if (textField == self.lblEmail) {
        [self.lblEmail resignFirstResponder];
        [self.lblAnswer becomeFirstResponder];
    } else if (textField == self.lblAnswer) {
        [self.lblAnswer resignFirstResponder];
    } else {
        [self.view endEditing:YES];
    }
    return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void) viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark -Data Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [searchWhereOptions count];
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *retval = (id)view;
    if (!retval) {
        retval= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width - 120, [pickerView rowSizeForComponent:component].height)];
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        retval.font = [UIFont systemFontOfSize:12];
    }
    else
    {
        retval.font = [UIFont systemFontOfSize:22];
    }
    
    retval.text = [searchWhereOptions objectAtIndex:row];
    return retval;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [searchWhereOptions objectAtIndex:row];
    
}

// this method runs whenever the user changes the selected list option

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // update label text to show selected option
    
    searchWhere.text = [searchWhereOptions objectAtIndex:row];
    
    // keep track of selected option (for next time we open the picker)
    
    selectedOption = row;
    
    NSLog(@"Select : %@", [searchWhereOptions objectAtIndex:row]);
    
}


- (IBAction)showSearchWhereOptions:(id)sender {
    
    [self.view endEditing:YES];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
    // create action sheet
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Secret Question" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    // create frame for picker view
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    // create picker view
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    // set selected option to what was previously selected
    [pickerView selectRow:selectedOption inComponent:0 animated:NO];
    // add picker view to action sheet
    [actionSheet addSubview:pickerView];
    
    // create close button to hide action sheet
    UISegmentedControl *select = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Select"]];
    select.momentary = YES;
    select.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    select.tintColor = [UIColor blackColor];
    
    // link close button to our dismissActionSheet method
    [select addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:select];
    
    // show action sheet
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [actionSheet setBounds:CGRectMake(0, 5.0f, 400, 485)];
    }
    else
    {
        self.lblViewIpad.hidden = NO;
        
        //Create Select button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self
                   action:@selector(dismissActionSheet)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"Select" forState:UIControlStateNormal];
        button.frame = CGRectMake(580, 90, 50.0f, 30.0f);
        button.tintColor = [UIColor whiteColor];
        button.backgroundColor = [UIColor redColor];
        [self.lblViewIpad addSubview:button];
    }
}
- (void) dismissActionSheet {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        // hide action sheet
        self.SecQuestion.text = [searchWhereOptions objectAtIndex:selectedOption];
        [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    }
    else
    {
        self.SecQuestion.text = [searchWhereOptions objectAtIndex:selectedOption];
        self.lblViewIpad.hidden = YES;
    }
    [self.view endEditing:YES];
}

#pragma mark - Hide UIPicker
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.lblViewIpad.hidden = YES;
    }
}

#pragma mark -NSURLConnection
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIAlertView myCostumeAlert:@"Connection Error" alertMessage:[error localizedDescription] delegate:nil cancelButton:@"Ok" otherButtons:nil];

    [HUD hide:YES];
    [HUD show:NO];
}
#pragma -ByPass Certificate
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
        NSArray *result = [res valueForKey:@"ForgotPasswordResult"];
        
        NSNumber *respCode = [result valueForKey:@"respcode"];
        NSString *respMesg = [result valueForKey:@"respmessage"];
        
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@", respMesg, @"You may check your email"];
        
        //Hide Loader
        [HUD hide:YES];
        [HUD show:NO];
        
        NSLog(@"Result %@", result);
        
        if ([respCode isEqualToNumber:[NSNumber numberWithInt:1]]) //success
        {
            [UIAlertView myCostumeAlert:@"Successful" alertMessage:str delegate:nil cancelButton:@"Ok" otherButtons:nil];
            
            self.lblAnswer.text = @"";
            self.lblEmail.text  = @"";
            self.lblSecQuestion.text = @"";
            self.lblUsername.text = @"";
        }
        else
        {
            
            if ([respMesg isEqualToString:@"Failed in resetting customer password."])
            {
                respMesg = [NSString stringWithFormat:@"%@\n%@", respMesg, @"Make sure all fields must be same from your account info."];
            }
            [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:respMesg delegate:nil cancelButton:@"Ok" otherButtons:nil];
        }
    }
}

- (void) SendReq_ForgotPass
{
    //GetAll Data
    NSString *username = self.lblUsername.text;
    NSString *emailadd = self.lblEmail.text;
    NSString *question = self.lblSecQuestion.text;
    NSString *seanswer = self.lblAnswer.text;
    
    
    //string username, string emailadd, string secquestion, string secanswer);
    NSString *post = [NSString stringWithFormat:@"{\"username\" : \"%@\",\"emailadd\" : \"%@\",\"secquestion\" : \"%@\",\"secanswer\" : \"%@\"}",
                      username,
                      emailadd,
                      question,
                      seanswer];
    
    NSString *srvcURL = [[[ServiceConnection alloc] NSgetURLService]
                         stringByAppendingString:@"ForgotPassword"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:srvcURL]];
    NSData *requestData = [NSData dataWithBytes:[post UTF8String] length:[post length]];
    
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:requestData];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

@end
