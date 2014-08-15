//
//  EnterCustomerID.m
//  Registration
//
//  Created by mm20-18 on 3/11/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "EnterCustomerID.h"
#import "ProfileOutline.h"
#import "ProfileHeader.h"
#import "ProfileLabel.h"
#import "ProfileTextField.h"
#import "RegistrationInformation.h"
#import "LoginViewController.h"
#import "UITextfieldAnimate.h"
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
#import "UITextfieldAnimate.h"
#import "UIAlertView+alertMe.h"
#import "ServiceConnection.h"
@interface EnterCustomerID ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation EnterCustomerID
{
    MBProgressHUD *HUD;
}
@synthesize customer;
CGRect screenRect;
CGFloat screenWidth;
CGFloat screenHeight;
ProfileTextField *firstNumberTF, *secondNumberTF, *thirdNumberTF, *phoneNumberTF;
UIScrollView *scrollView;
UITextfieldAnimate *textAnimate;
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
    
    
    self.navigationController.navigationBarHidden = NO;
    
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, 500)];
    
    [self addNavigationBar];
    [self createCustomerID];
    [self.view addSubview:scrollView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)gotoHome
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) createCustomerID{
    ProfileHeader *personalHeader = [[ProfileHeader alloc] initWithValue:@" Enter all fields" x:5 y:-10 width:120];
    UIView* simpleView = [[UIView alloc] initWithFrame:CGRectMake(10,screenHeight*.05,screenWidth,screenHeight)];
    
    ProfileLabel *customerID;
    
    if ( IDIOM == IPAD ) {
        NSLog(@"IPAD NI");
        customerID = [[ProfileLabel alloc] initWithStatus:@"Enter your CustomerID" x:10 y:20 myColor:[UIColor grayColor] width:140];
        float personalHeader_Co = ((screenWidth - 170)/2)-170;
        [personalHeader setFrame:CGRectMake(personalHeader_Co, -10, 170, 30)];
        float customerID_Co = ((screenWidth - 170)/2)-150;
        [customerID setFrame:CGRectMake(customerID_Co, 20, 170, 30)];
        firstNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(204, 50, 120, 30) word:@""];
        firstNumberTF.layer.cornerRadius=8.0f;
        firstNumberTF.layer.masksToBounds=YES;
        firstNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        firstNumberTF.layer.borderWidth= 1.0f;
        float firstNumberTF_Co = ((screenWidth - 120)/2)-140;
        [firstNumberTF setFrame:CGRectMake(firstNumberTF_Co, 50, 120, 30)];
        
        secondNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(204, 50, 120, 30) word:@""];
        secondNumberTF.layer.cornerRadius=8.0f;
        secondNumberTF.layer.masksToBounds=YES;
        secondNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        secondNumberTF.layer.borderWidth= 1.0f;
        float secondNumberTF_Co = (screenWidth - 120)/2;
        [secondNumberTF setFrame:CGRectMake(secondNumberTF_Co, 50, 120, 30)];
        
        thirdNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(204, 50, 120, 30) word:@""];
        
        thirdNumberTF.layer.cornerRadius=8.0f;
        thirdNumberTF.layer.masksToBounds=YES;
        thirdNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        thirdNumberTF.layer.borderWidth= 1.0f;
        float thirdNumberTF_Co = ((screenWidth - 120)/2)+140;
        [thirdNumberTF setFrame:CGRectMake(thirdNumberTF_Co, 50, 120, 30)];
        NSLog(@"%f",thirdNumberTF_Co);
        
        ProfileLabel *phoneNumber = [[ProfileLabel alloc] initWithStatus:@"Enter your Phone Number" x:10 y:100 myColor:[UIColor grayColor] width:170];
        float phoneNumber_Co = ((screenWidth - 170)/2)-150;
        [phoneNumber setFrame:CGRectMake(phoneNumber_Co, 100, 170, 30)];
        phoneNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(12, 130, 400, 30) word:self.customer.firstName];
        phoneNumberTF.layer.cornerRadius=8.0f;
        phoneNumberTF.layer.masksToBounds=YES;
        phoneNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        phoneNumberTF.layer.borderWidth= 1.0f;
        float phoneNumberTF_Co = (screenWidth - 400)/2;
        [phoneNumberTF setFrame:CGRectMake(phoneNumberTF_Co, 130, 400, 30)];
        
        firstNumberTF.delegate = self;
        secondNumberTF.delegate = self;
        thirdNumberTF.delegate = self;
        phoneNumberTF.delegate = self;
        
        
        
        
        [simpleView addSubview:personalHeader];
        [simpleView addSubview:customerID];
        [simpleView addSubview:firstNumberTF];
        [simpleView addSubview:secondNumberTF];
        [simpleView addSubview:thirdNumberTF];
        [simpleView addSubview:phoneNumber];
        [simpleView addSubview:phoneNumberTF];
        [scrollView addSubview:simpleView];
    }
    else {
        NSLog(@"IPHONE NI");
        customerID = [[ProfileLabel alloc] initWithStatus:@"Enter your CustomerID" x:10 y:20 myColor:[UIColor grayColor] width:140];
        firstNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(12, 50, 84, 30) word:@""];
        firstNumberTF.layer.cornerRadius=8.0f;
        firstNumberTF.layer.masksToBounds=YES;
        firstNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        firstNumberTF.layer.borderWidth= 1.0f;
        
        secondNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(108, 50, 84, 30) word:@""];
        
        secondNumberTF.layer.cornerRadius=8.0f;
        secondNumberTF.layer.masksToBounds=YES;
        secondNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        secondNumberTF.layer.borderWidth= 1.0f;
        
        thirdNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(204, 50, 84, 30) word:@""];
        
        thirdNumberTF.layer.cornerRadius=8.0f;
        thirdNumberTF.layer.masksToBounds=YES;
        thirdNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        thirdNumberTF.layer.borderWidth= 1.0f;
        
        
        
        ProfileLabel *phoneNumber = [[ProfileLabel alloc] initWithStatus:@"Enter your Phone Number" x:10 y:100 myColor:[UIColor grayColor] width:170];
        
        phoneNumberTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(12, 130, 275, 30) word:self.customer.firstName];
        phoneNumberTF.layer.cornerRadius=8.0f;
        phoneNumberTF.layer.masksToBounds=YES;
        phoneNumberTF.layer.borderColor=[[UIColor redColor]CGColor];
        phoneNumberTF.layer.borderWidth= 1.0f;
        
        
        firstNumberTF.delegate = self;
        secondNumberTF.delegate = self;
        thirdNumberTF.delegate = self;
        phoneNumberTF.delegate = self;
        
        [simpleView addSubview:personalHeader];
        [simpleView addSubview:customerID];
        [simpleView addSubview:firstNumberTF];
        [simpleView addSubview:secondNumberTF];
        [simpleView addSubview:thirdNumberTF];
        [simpleView addSubview:phoneNumber];
        [simpleView addSubview:phoneNumberTF];
        [scrollView addSubview:simpleView];
    }
    
    
    
    
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y);
    [scrollView setContentOffset:scrollPoint animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [scrollView setContentOffset:CGPointZero animated:YES];
}

-(void) addNavigationBar{
    self.title = @"Customer ID";
    UIBarButtonItem *btnHome = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home.png"]
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(gotoHome)];
    
    self.navigationItem.leftBarButtonItem = btnHome;
    
    
    
    //next navigation button
    UIBarButtonItem *btnNext = [[UIBarButtonItem alloc] initWithTitle:
                                @"Next"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(gotoNextView)];
    self.navigationItem.rightBarButtonItem = btnNext;
    
    //Set Background
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        
        if ([UIScreen mainScreen].bounds.size.height == 568) //4 inch
        {
            [scrollView setContentSize:CGSizeMake(320, 568)];
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground1.png"]]];
        }
        else //4 inc below
        {
            [scrollView setContentSize:CGSizeMake(320, 400)];
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground2.png"]]];
        }
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground4.png"]]];
    }
    
    
}
-(void) gotoNextView{
    if(firstNumberTF.text.length>=1&&secondNumberTF.text.length>=1&&phoneNumberTF.text.length>=1)
    {
        NSLog(@"Next ni Bai!");
        if([firstNumberTF resignFirstResponder]==YES||
           [secondNumberTF resignFirstResponder]==YES||
           [thirdNumberTF resignFirstResponder]==YES||
           [phoneNumberTF resignFirstResponder]==YES){
            NSLog(@"Keyboard Visible");
            [scrollView setContentOffset:CGPointZero animated:YES];
        }
        else{
            NSLog(@"Keyboard not Visible");
        }
        [self customerIDService];
    }
    else{
        NSLog(@"Empty man Bai!!");
        [UIAlertView myCostumeAlert:@"Error!" alertMessage:@"Fill All Fields." delegate:nil cancelButton:@"Ok" otherButtons:nil];
        
        
    }
}

-(void) backPressed{
    
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [firstNumberTF resignFirstResponder];
    [secondNumberTF resignFirstResponder];
    [thirdNumberTF resignFirstResponder];
    [phoneNumberTF resignFirstResponder];
    if (textField == firstNumberTF)
    {
        [secondNumberTF becomeFirstResponder];
    }
    else if (textField == secondNumberTF)
    {
        [thirdNumberTF becomeFirstResponder];
    }
    
    
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // This allows numeric text only, but also backspace for deletes
    if (string.length > 0 && ![[NSScanner scannerWithString:string] scanInt:NULL])
        return NO;
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    NSUInteger textLength=0;
    
    // This 'tabs' to next field when entering digits
    if (newLength >= 5&&textField == firstNumberTF)
    {
        [self performSelector:@selector(setNextResponder:) withObject:secondNumberTF afterDelay:0.0];
        
        textLength = 5;
    }
    
    else if(newLength >= 5&&textField == secondNumberTF){
        [self performSelector:@selector(setNextResponder:) withObject:thirdNumberTF afterDelay:0.0];
        textLength = 5;
        
    }
    else if(newLength >= 4&&textField == thirdNumberTF){
        [self performSelector:@selector(setNextResponder:) withObject:phoneNumberTF afterDelay:0.0];
        textLength = 25;
        
    }
    
    //this goes to previous field as you backspace through them, so you don't have to tap into them individually
    else if (oldLength > 0 && newLength == 0) {
        if (textField == phoneNumberTF)
        {
            [self performSelector:@selector(setNextResponder:) withObject:thirdNumberTF afterDelay:0.1];
        }
        else if (textField == thirdNumberTF)
        {
            [self performSelector:@selector(setNextResponder:) withObject:secondNumberTF afterDelay:0.1];
        }
        else if (textField == secondNumberTF)
        {
            [self performSelector:@selector(setNextResponder:) withObject:firstNumberTF afterDelay:0.1];
        }
    }
    
    return newLength <= 20;
}

- (void)setNextResponder:(UITextField *)nextResponder
{
    [nextResponder becomeFirstResponder];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(void) customerIDService{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    //Get Branch Coordinate
    self.responseData = [NSMutableData data];
    ServiceConnection *str = [ServiceConnection new];
    //#define URLCustomerIDService @"SearchCustId/?custid={%@}&mobileno={%@}"
    NSString *custID = [NSString stringWithFormat:@"SearchCustId/?custid=%@%@%@&mobileno=%@", firstNumberTF.text,secondNumberTF.text,thirdNumberTF.text,phoneNumberTF.text];
    NSString *url = [NSString stringWithFormat:@"%@%@", [str NSGetCustomerIDService],custID];
    
    NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSLog(@"URL - %@", url);              // Checking the url
    
    NSMutableURLRequest *theRequest= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl]
                                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:10.0];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
    [theConnection start];
    
}




#pragma mark - NSURLConnection Delegate
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError : %@",error);
    [HUD hide:YES];
    [HUD show:NO];
    
    
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    if (myError == nil) {
        
        NSDictionary *jsonResult = [res objectForKey:@"SearchCustIdMobileResult"];
        NSString *strResponseCode = [jsonResult objectForKey:@"respcode"];
        NSString *strResponseMessage = [jsonResult objectForKey:@"respmessage"];
        NSString *strbdate = [jsonResult objectForKey:@"bdate"];
        NSString *strcountry = [jsonResult objectForKey:@"country"];
        NSString *stremailadd = [jsonResult objectForKey:@"emailadd"];
        NSString *strfname = [jsonResult objectForKey:@"fname"];
        NSString *strgender = [jsonResult objectForKey:@"gender"];
        NSString *strlname = [jsonResult objectForKey:@"lname"];
        NSString *strmname = [jsonResult objectForKey:@"mname"];
        NSString *strmobileno = [jsonResult objectForKey:@"mobileno"];
        NSString *strnationality = [jsonResult objectForKey:@"nationality"];
        NSString *strnatureOfWork = [jsonResult objectForKey:@"natureOfWork"];
        NSString *strpermanentAdd = [jsonResult objectForKey:@"permanentAdd"];
        NSString *strprovinceCity = [jsonResult objectForKey:@"provinceCity"];
        NSString *strzipcode = [jsonResult objectForKey:@"zipcode"];
        NSString *strphoto1 = [jsonResult objectForKey:@"photo1"];
        NSString *strphoto2 = [jsonResult objectForKey:@"photo2"];
        NSString *strphoto3 = [jsonResult objectForKey:@"photo3"];
        NSString *strphoto4 = [jsonResult objectForKey:@"photo4"];
        NSString *strbalance = [jsonResult objectForKey:@"balance"];
        NSString *strsecanswer1 = [jsonResult objectForKey:@"secanswer1"];
        NSString *strsecanswer2 = [jsonResult objectForKey:@"secanswer2"];
        NSString *strsecanswer3 = [jsonResult objectForKey:@"secanswer3"];
        NSString *strsecquestion1 = [jsonResult objectForKey:@"secquestion1"];
        NSString *strsecquestion2 = [jsonResult objectForKey:@"secquestion2"];
        NSString *strsecquestion3 = [jsonResult objectForKey:@"secquestion3"];
        NSString *strwalletno = [jsonResult objectForKey:@"walletno"];
        NSLog(@"Response Code : %@",strResponseCode);
        NSLog(@"Response Message : %@",strResponseMessage);
        
        NSLog(@"Ang response ni!! = %@",jsonResult);
        
        
        // if string is null do something
        if([strzipcode isKindOfClass:[NSNull class]]){
            strzipcode = @"";
        }
        if([strpermanentAdd isKindOfClass:[NSNull class]]){
            strpermanentAdd = @"";
        }
        if([strbdate isKindOfClass:[NSNull class]]){
            strbdate = @"";
        }
        if([strcountry isKindOfClass:[NSNull class]]){
            strcountry = @"";
        }
        if([stremailadd isKindOfClass:[NSNull class]]){
            stremailadd = @"";
        }
        if([strfname isKindOfClass:[NSNull class]]){
            strfname = @"";
        }
        if([strgender isKindOfClass:[NSNull class]]){
            strgender = @"";
        }
        if([strlname isKindOfClass:[NSNull class]]){
            strlname = @"";
        }
        if([strmname isKindOfClass:[NSNull class]]){
            strmname = @"";
        }
        if([strnationality isKindOfClass:[NSNull class]]){
            strnationality = @"";
        }
        if([strmobileno isKindOfClass:[NSNull class]]){
            strmobileno = @"";
        }
        if([strprovinceCity isKindOfClass:[NSNull class]]){
            strprovinceCity = @"";
        }
        if([strnatureOfWork isKindOfClass:[NSNull class]]){
            strnatureOfWork = @"";
        }
        if([strphoto1 isKindOfClass:[NSNull class]]){
            strphoto1 = @"";
        }
        if([strphoto2 isKindOfClass:[NSNull class]]){
            strphoto2 = @"";
        }
        if([strphoto3 isKindOfClass:[NSNull class]]){
            strphoto3 = @"";
        }
        if([strphoto4 isKindOfClass:[NSNull class]]){
            strphoto4 = @"";
        }
        
        
        
        if([strResponseMessage isEqualToString:@"CustID not found."]){
            
            [UIAlertView myCostumeAlert:@"Connection Error" alertMessage:@"Customer ID not found." delegate:nil cancelButton:@"Ok" otherButtons:nil];
            

            
        }
        
        else if(![strResponseMessage isEqualToString:@"CustID not found."]){
            
            RegistrationInformation *regInfo = [[RegistrationInformation alloc] initWithNibName:@"RegistrationInformation" bundle:nil];
            regInfo.reg_info_custIDfirstNumber = firstNumberTF.text;
            regInfo.reg_info_custIDsecondNumber = secondNumberTF.text;
            regInfo.reg_info_custIDthirdNumber = thirdNumberTF.text;
            regInfo.reg_info_custIDphoneNumber = phoneNumberTF.text;
            
            regInfo.reg_info_str_address = strpermanentAdd;
            regInfo.reg_info_str_birthdate = strbdate;
            regInfo.reg_info_str_country = strcountry;
            regInfo.reg_info_str_email = stremailadd;
            regInfo.reg_info_str_firstName = strfname;
            regInfo.reg_info_str_gender = strgender;
            regInfo.reg_info_str_lastName = strlname;
            regInfo.reg_info_str_middleName = strmname;
            regInfo.reg_info_str_nationality = strnationality;
            regInfo.reg_info_str_number = strmobileno;
            regInfo.reg_info_str_province = strprovinceCity;
            regInfo.reg_info_str_work = strnatureOfWork;
            regInfo.reg_info_str_zipcode = strzipcode;
            
            regInfo.reg_info_str_photo1 = strphoto1;
            regInfo.reg_info_str_photo2 = strphoto2;
            regInfo.reg_info_str_photo3 = strphoto3;
            regInfo.reg_info_str_photo4 = strphoto4;
            regInfo.reg_info_str_balance = strbalance;
            regInfo.reg_info_str_secanswer1 = strsecanswer1;
            regInfo.reg_info_str_secanswer2 = strsecanswer2;
            regInfo.reg_info_str_secanswer3 = strsecanswer3;
            regInfo.reg_info_str_secquestion1 = strsecquestion1;
            regInfo.reg_info_str_secquestion2 = strsecquestion2;
            regInfo.reg_info_str_secquestion3 = strsecquestion3;
            regInfo.reg_info_str_walletno = strwalletno;
            
            [self.navigationController pushViewController:regInfo animated:YES];
            
            
        }
        
        [HUD hide:YES];
        [HUD show:NO];
    }//end if
    
    else {
        NSLog(@"Error : %@",myError.localizedDescription);
        [UIAlertView myCostumeAlert:@"Connection Error" alertMessage:[myError localizedDescription] delegate:nil cancelButton:@"Ok" otherButtons:nil];
        [HUD hide:YES];
        [HUD show:NO];
    }//end else
    
    
    
    
    
}//end connectionDidFinishLoading




@end