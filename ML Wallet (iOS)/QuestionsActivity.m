//
//  QuestionsActivity.m
//  Registration
//
//  Created by mm20-18 on 3/12/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "QuestionsActivity.h"
#import "AccountLogin.h"
#import "ProfileOutline.h"
#import "ProfileHeader.h"
#import "ProfileButton.h"
#import "ProfileLabel.h"
#import "ProfileTextField.h"
#import "SelectQuestionDialog.h"
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
#import "UITextfieldAnimate.h"
#import "UIAlertView+alertMe.h"
@interface QuestionsActivity ()

@end

@implementation QuestionsActivity
@synthesize quest_act_custIDfirstNumber;
@synthesize quest_act_custIDsecondNumber;
@synthesize quest_act_custIDthirdNumber;
@synthesize quest_act_custIDphoneNumber;

@synthesize quest_act_firstName;
@synthesize quest_act_middleName;
@synthesize quest_act_lastName;
@synthesize quest_act_country;
@synthesize quest_act_province;
@synthesize quest_act_address;
@synthesize quest_act_zipcode;
@synthesize quest_act_gender;
@synthesize quest_act_birthdate;
@synthesize quest_act_number;
@synthesize quest_act_email;
@synthesize quest_act_work;
@synthesize quest_act_nationality;

@synthesize quest_act_str_photo1;
@synthesize quest_act_str_photo2;
@synthesize quest_act_str_photo3;
@synthesize quest_act_str_photo4;
@synthesize quest_act_str_balance;
@synthesize quest_act_str_secanswer1;
@synthesize quest_act_str_secanswer2;
@synthesize quest_act_str_secanswer3;
@synthesize quest_act_str_secquestion1;
@synthesize quest_act_str_secquestion2;
@synthesize quest_act_str_secquestion3;
@synthesize quest_act_str_walletno;

@synthesize questionstextFieldStatus;
UIScrollView *scrollView;
UIView *disableBackground;


NSArray *questions1, *questions2, *questions3;

ProfileButton *button1, *button2, *button3;
//ProfileLabel *questionLbl1, *questionLbl2, *questionLbl3;
UIButton *question1, *question2, *question3;
ProfileTextField *answerTF1, *answerTF2, *answerTF3;
CGRect screenRect;
CGFloat screenWidth;
CGFloat screenHeight;
UITextfieldAnimate *textAnimate;
SelectQuestionDialog *questionDialog;
UIBarButtonItem *btnNextAccLog;


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
    
    questions1 = [[NSArray alloc] initWithObjects:@"What is your school in sixth grade?", @"What's your childhood nickname?", @"What's your mom's middle name?", @"What city was your first job?", @"What is your favorite movie?", nil];
    
    questions2 = [[NSArray alloc] initWithObjects:@"What is your favorite TV program?", @"What city were you born?", @"Where did your parent's meet?", @"What's your dad's middle name?", @"What is your favorite book?", nil];
    
    questions3 = [[NSArray alloc] initWithObjects:@"What was your dream job?", @"What is your pet's name?", @"What is your musical genre?", @"Where is your dream vacation?", @"Who was your childhood hero?", nil];
    
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(screenWidth, screenHeight)];
    
    
    /*
     AccountLogin *accountLogin = [[AccountLogin alloc] initWithNibName:@"AccountLogin" bundle:nil];
     [self setNextViewController:accountLogin myImage:[UIImage imageNamed:@"next.png"]];
     */
    
    disableBackground = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    [disableBackground setBackgroundColor:[UIColor blackColor]];
    [disableBackground setHidden:YES];
    [disableBackground setAlpha:0.5f];
    
    [self addNavigationBar];
    [self createQuestion];
    [self.view addSubview:scrollView];
    [self.view addSubview: disableBackground];
    //NSLog(@"Sa Questions Controller ==== Customer ID = %@ %@ %@ = Phone Number: %@ Birthdate = %@",quest_act_custIDfirstNumber,quest_act_custIDsecondNumber,quest_act_custIDthirdNumber,quest_act_custIDphoneNumber,quest_act_birthdate);
}
-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}


-(void) createQuestion{
    if ( IDIOM == IPAD ) {
        /* do something specifically for iPad. */
        NSLog(@"IPAD");
        UIView* simpleView = [[UIView alloc] initWithFrame:CGRectMake(0,10,screenWidth,screenHeight)];
        ProfileHeader *questionHeader = [[ProfileHeader alloc] initWithValue:@" Secret Questions" x:40 y:5 width:300];
        questionHeader.font = [UIFont systemFontOfSize:24.0f];
        //QUESTION 1 question1
        
        button1 = [[ProfileButton alloc] initWithString:@"?" x:screenWidth/6 y:50];
        [button1 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        [button1 setFrame:CGRectMake(screenWidth/6,50, 40, 40)];
//        questionLbl1 =[[ProfileLabel alloc] initWithStatus:@"Question 1" x:screenWidth/4.8 y:50 myColor:[UIColor blackColor] width:260];
//        
//        questionLbl1.font = [UIFont systemFontOfSize:24.0f];
//        [questionLbl1 setFrame:CGRectMake(screenWidth/4.5,50, 500, 40)];
        
        question1 = [UIButton buttonWithType:UIButtonTypeCustom];
        question1.frame = CGRectMake(screenWidth/4.5,50, 500, 40);
        question1.titleLabel.font = [UIFont systemFontOfSize:24.0f];
        question1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [question1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [question1 setTitle:@"Question 1" forState:UIControlStateNormal];
        [question1 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        answerTF1 = [[ProfileTextField alloc] initWithFrame:CGRectMake(screenWidth/4, 100, screenWidth/2, 40) word:@"answer 1"];
        answerTF1.layer.cornerRadius=8.0f;
        answerTF1.layer.masksToBounds=YES;
        answerTF1.layer.borderColor=[[UIColor redColor]CGColor];
        answerTF1.layer.borderWidth= 1.0f;
        answerTF1.font = [UIFont systemFontOfSize:24.0f];
        float answerTF1_Co = (screenWidth - (screenWidth/1.5))-((screenWidth/1.5)/4);
        [answerTF1 setFrame:CGRectMake(answerTF1_Co,100, screenWidth/1.5, 40)];
        answerTF1.delegate = self;
        
        //QUESTION 2
        
        button2 = [[ProfileButton alloc] initWithString:@"?" x:screenWidth/6 y:150];
        [button2 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        [button2 setFrame:CGRectMake(screenWidth/6,150, 40, 40)];
        
//        questionLbl2 = [[ProfileLabel alloc] initWithStatus:@"Question 2" x:screenWidth/4.8 y:150 myColor:[UIColor blackColor] width:260];
//        questionLbl2.font = [UIFont systemFontOfSize:24.0f];
//        [questionLbl2 setFrame:CGRectMake(screenWidth/4.5,150, 500, 40)];
        
        question2 = [UIButton buttonWithType:UIButtonTypeCustom];
        question2.frame = CGRectMake(screenWidth/4.5,150, 500, 40);
        question2.titleLabel.font = [UIFont systemFontOfSize:24.0f];
        question2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [question2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [question2 setTitle:@"Question 2" forState:UIControlStateNormal];
        [question2 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        
        answerTF2 = [[ProfileTextField alloc] initWithFrame:CGRectMake(screenWidth/4,200, screenWidth/2, 40) word:@"answer 2"];
        answerTF2.layer.cornerRadius=8.0f;
        answerTF2.layer.masksToBounds=YES;
        answerTF2.layer.borderColor=[[UIColor redColor]CGColor];
        answerTF2.layer.borderWidth= 1.0f;
        answerTF2.font = [UIFont systemFontOfSize:24.0f];
        float answerTF2_Co = (screenWidth - (screenWidth/1.5))-((screenWidth/1.5)/4);
        [answerTF2 setFrame:CGRectMake(answerTF2_Co,200, screenWidth/1.5, 40)];
        answerTF2.delegate = self;
        
        //QUESITON 3
        
        button3 = [[ProfileButton alloc] initWithString:@"?" x:screenWidth/6 y:250];
        [button3 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        [button3 setFrame:CGRectMake(screenWidth/6,250, 40, 40)];
        
//        questionLbl3 = [[ProfileLabel alloc] initWithStatus:@"Question 3" x:screenWidth/4.8 y:250 myColor:[UIColor blackColor] width:260];
//        questionLbl3.font = [UIFont systemFontOfSize:24.0f];
//        [questionLbl3 setFrame:CGRectMake(screenWidth/4.5,250, 500, 40)];
        
        question3 = [UIButton buttonWithType:UIButtonTypeCustom];
        question3.frame = CGRectMake(screenWidth/4.5,250, 500, 40);
        question3.titleLabel.font = [UIFont systemFontOfSize:24.0f];
        question3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [question3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [question3 setTitle:@"Question 3" forState:UIControlStateNormal];
        [question3 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        
        
        answerTF3 = [[ProfileTextField alloc] initWithFrame:CGRectMake(screenWidth/4, 300, screenWidth/2, 40) word:@"answer 3"];
        
        answerTF3.layer.cornerRadius=8.0f;
        answerTF3.layer.masksToBounds=YES;
        answerTF3.layer.borderColor=[[UIColor redColor]CGColor];
        answerTF3.layer.borderWidth= 1.0f;
        answerTF3.font = [UIFont systemFontOfSize:24.0f];
        float answerTF3_Co = (screenWidth - (screenWidth/1.5))-((screenWidth/1.5)/4);
        [answerTF3 setFrame:CGRectMake(answerTF3_Co,300, screenWidth/1.5, 40)];
        answerTF3.delegate = self;
        
        
       // NSLog(@"%f-------%f",screenWidth,screenHeight);
        
        
        
        [simpleView addSubview:questionHeader];
        [simpleView addSubview:button1];
        [simpleView addSubview:question1];
        [simpleView addSubview: answerTF1];
        
        [simpleView addSubview:button2];
        [simpleView addSubview:question2];
        [simpleView addSubview:answerTF2];
        
        [simpleView addSubview:button3];
        [simpleView addSubview:question3];
        [simpleView addSubview:answerTF3];
        [scrollView addSubview:simpleView];
    } else {
        /* do something specifically for iPhone or iPod touch. */
        NSLog(@"IPHONE");
        UIView* simpleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,screenWidth,screenHeight)];
        ProfileHeader *questionHeader = [[ProfileHeader alloc] initWithValue:@" Secret Questions" x:5 y:5 width:140];
        
        //QUESTION 1
//        questionLbl1 =[[ProfileLabel alloc] initWithStatus:@"Question 1" x:45 y:30 myColor:[UIColor blackColor] width:260];
//        [questionLbl1 setFrame:CGRectMake(questionLbl1_Co, 30, 260, 30)];
        
        //float questionLbl1_Co = ((self.view.frame.size.width)/2)-110;
        question1 = [UIButton buttonWithType:UIButtonTypeCustom];
        question1.frame = CGRectMake(45, 30, 260, 30);
        question1.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        question1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [question1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [question1 setTitle:@"Question 1" forState:UIControlStateNormal];
        [question1 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        answerTF1 = [[ProfileTextField alloc] initWithFrame:CGRectMake(0, 0, 285, 30) word:@"answer 1"];
        answerTF1.layer.cornerRadius=8.0f;
        answerTF1.layer.masksToBounds=YES;
        answerTF1.layer.borderColor=[[UIColor redColor]CGColor];
        answerTF1.layer.borderWidth= 1.0f;
        float answerTF1_Co = (self.view.frame.size.width - 285)/2;
        [answerTF1 setFrame:CGRectMake(answerTF1_Co, 70, 285, 30)];
        
        button1 = [[ProfileButton alloc] initWithString:@"?" x:10 y:30];
        [button1 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        float button1_Co = ((self.view.frame.size.width - 10)/2)-143.5;
        [button1 setFrame:CGRectMake(button1_Co, 30, 30, 30)];
        
        
        
        
        //QUESTION 2
        
        button2 = [[ProfileButton alloc] initWithString:@"?" x:10 y:120];
        [button2 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        float button2_Co = ((self.view.frame.size.width - 10)/2)-143.5;
        [button2 setFrame:CGRectMake(button2_Co, 120, 30, 30)];
        
      //  questionLbl2 = [[ProfileLabel alloc] initWithStatus:@"Question 2" x:45 y:120 myColor:[UIColor blackColor] width:260];
        
        question2 = [UIButton buttonWithType:UIButtonTypeCustom];
        question2.frame = CGRectMake(45, 120, 260, 30);
        question2.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        question2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [question2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [question2 setTitle:@"Question 2" forState:UIControlStateNormal];
        [question2 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        
        answerTF2 = [[ProfileTextField alloc] initWithFrame:CGRectMake(15, 160, 285, 30) word:@"answer 2"];
        answerTF2.layer.cornerRadius=8.0f;
        answerTF2.layer.masksToBounds=YES;
        answerTF2.layer.borderColor=[[UIColor redColor]CGColor];
        answerTF2.layer.borderWidth= 1.0f;
        float answerTF2_CO = (self.view.frame.size.width - 285)/2;
        [answerTF2 setFrame:CGRectMake(answerTF2_CO, 160, 285, 30)];
        
        //QUESITON 3
        
        button3 = [[ProfileButton alloc] initWithString:@"?" x:10 y:210];
        [button3 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        float button3_Co = ((self.view.frame.size.width - 10)/2)-143.5;
        [button3 setFrame:CGRectMake(button3_Co, 210, 30, 30)];
        
        
        //questionLbl3 = [[ProfileLabel alloc] initWithStatus:@"Question 3" x:45 y:210 myColor:[UIColor blackColor] width:260];
        
        
        question3 = [UIButton buttonWithType:UIButtonTypeCustom];
        question3.frame = CGRectMake(45, 210, 260, 30);
        question3.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        question3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [question3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [question3 setTitle:@"Question 3" forState:UIControlStateNormal];
        [question3 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        
        answerTF3 = [[ProfileTextField alloc] initWithFrame:CGRectMake(15, 250, 285, 30) word:@"answer 3"];
        
        answerTF3.layer.cornerRadius=8.0f;
        answerTF3.layer.masksToBounds=YES;
        answerTF3.layer.borderColor=[[UIColor redColor]CGColor];
        answerTF3.layer.borderWidth= 1.0f;
        
        float answerTF3_CO = (self.view.frame.size.width - 285)/2;
        [answerTF3 setFrame:CGRectMake(answerTF3_CO, 250, 285, 30)];
        
        
        
        answerTF1.delegate = self;
        answerTF2.delegate = self;
        answerTF3.delegate = self;
        
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
       // NSLog(@"%f-------%f",screenWidth,screenHeight);
        
        
        
        [simpleView addSubview:questionHeader];
        [simpleView addSubview:button1];
        [simpleView addSubview:question1];
        [simpleView addSubview: answerTF1];
        
        [simpleView addSubview:button2];
        [simpleView addSubview:question2];
        [simpleView addSubview:answerTF2];
        
        [simpleView addSubview:button3];
        [simpleView addSubview:question3];
        [simpleView addSubview:answerTF3];
        [scrollView addSubview:simpleView];
    }
    
    
    
    
    
    
}


-(void)show:(id)sender{
    [self.view endEditing:YES];
    if ( IDIOM == IPAD ) {
        
        [self disableNavigationItems];
        float dialogCO = (self.view.frame.size.width - 320)/2;
        float dialogY = (self.view.frame.size.height - 500)/2;
        if(sender == button1||sender == question1)
        {
            
            questionDialog = [[SelectQuestionDialog alloc] initWithFrame:CGRectMake(dialogCO, dialogY, 320, 500) stringArray:questions1];
            
            [disableBackground setHidden:NO];
            [self.view addSubview:questionDialog];
            [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion1:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        else if(sender == button2||sender == question2)
        {
            
            questionDialog = [[SelectQuestionDialog alloc] initWithFrame:CGRectMake(dialogCO, dialogY, 320, 500) stringArray:questions2];
            [disableBackground setHidden:NO];
            [self.view addSubview:questionDialog];
            [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion2:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        else
        {
            
            questionDialog = [[SelectQuestionDialog alloc] initWithFrame:CGRectMake(dialogCO, dialogY, 320, 500) stringArray:questions3];
            [disableBackground setHidden:NO];
            [self.view addSubview:questionDialog];
            [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion3:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        
    }
    else{
        [self disableNavigationItems];
        if(sender == button1||sender == question1)
        {
            questionDialog = [[SelectQuestionDialog alloc] initWithFrame:CGRectMake(0, -30, 320, 500) stringArray:questions1];
            [disableBackground setHidden:NO];
            [self.view addSubview:questionDialog];
            [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion1:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        else if(sender == button2||sender == question2)
        {
            questionDialog = [[SelectQuestionDialog alloc] initWithFrame:CGRectMake(0, -30, 320, 500) stringArray:questions2];
            [disableBackground setHidden:NO];
            [self.view addSubview:questionDialog];
            [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion2:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        else
        {
            questionDialog = [[SelectQuestionDialog alloc] initWithFrame:CGRectMake(0, -30, 320, 500) stringArray:questions3];
            [disableBackground setHidden:NO];
            [self.view addSubview:questionDialog];
            [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion3:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        
        
    }
    
    
    
    
}

-(void) finishSelectingQuestion3:(id)sender{
    
    [disableBackground setHidden:YES];
//    [questionLbl3 setText:[questionDialog getSelectedQuestion]];
    [question3 setTitle:[questionDialog getSelectedQuestion] forState:UIControlStateNormal];
    [self enableNavigationItems];
    [questionDialog removeFromSuperview];
    
}

-(void)disableNavigationItems{
    NSLog(@"Disable Buttons");
//    btnNextAccLog.enabled = NO;
//    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    
}
-(void)enableNavigationItems{
    NSLog(@"Enable Buttons");
//    btnNextAccLog.enabled = YES;
//    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
//      if ( IDIOM != IPAD ) {
//    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y);
//    [scrollView setContentOffset:scrollPoint animated:YES];
//      }
    answerTF1.autocorrectionType = FALSE;
    answerTF2.autocorrectionType = FALSE;
    answerTF3.autocorrectionType = FALSE;
    answerTF1.autocapitalizationType = UITextAutocapitalizationTypeNone;
    answerTF2.autocapitalizationType = UITextAutocapitalizationTypeNone;
    answerTF3.autocapitalizationType = UITextAutocapitalizationTypeNone;
    if ( IDIOM != IPAD ) {
        
    if([answerTF2 isFirstResponder]){
        [self animateTextField:textField up:YES num:-100];
        self.questionstextFieldStatus = 1;
    }
    else if([answerTF3 isFirstResponder]){
        [self animateTextField:textField up:YES num:-150];
        self.questionstextFieldStatus = 2;
    }
        
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if ( IDIOM != IPAD ) {
//    [scrollView setContentOffset:CGPointZero animated:YES];
//    }
     if ( IDIOM != IPAD ) {
         
    if(self.questionstextFieldStatus==1){
        [self animateTextField:textField up:NO num:-100];
        self.questionstextFieldStatus=0;
    }
    else if(self.questionstextFieldStatus==2){
        [self animateTextField:textField up:NO num:-150];
        self.questionstextFieldStatus=0;
    }
         
     }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [answerTF1 resignFirstResponder];
    [answerTF2 resignFirstResponder];
    [answerTF3 resignFirstResponder];
    
    return NO;
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up num:(int)num
{
    const float movementDuration = 0.3f;
    
    int movement = (up ? num : -num);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(void) finishSelectingQuestion1:(id)sender{
    
    [disableBackground setHidden:YES];
    //[questionLbl1 setText:[questionDialog getSelectedQuestion]];
    //[question1 setEnabled:NO];
    [question1 setTitle:[questionDialog getSelectedQuestion] forState:UIControlStateNormal];
    [questionDialog removeFromSuperview];
    [self enableNavigationItems];
    
}

-(void) finishSelectingQuestion2:(id)sender{
    
    [disableBackground setHidden:YES];
//    [questionLbl2 setText:[questionDialog getSelectedQuestion]];
    [question2 setTitle:[questionDialog getSelectedQuestion] forState:UIControlStateNormal];
    [questionDialog removeFromSuperview];
    [self enableNavigationItems];
}



-(void) addNavigationBar{
    self.title = @"Security Questions";
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                                         initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    //next navigation button
    btnNextAccLog = [[UIBarButtonItem alloc] initWithTitle:
                                      @"Next"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:@selector(gotoNextView)];
    self.navigationItem.rightBarButtonItem = btnNextAccLog;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}


-(void) backPressed{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//goto Next view method
-(void) gotoNextView{
    if([answerTF1 resignFirstResponder]==YES||[answerTF2 resignFirstResponder]==YES||
       [answerTF3 resignFirstResponder]==YES){
        NSLog(@"Keyboard Visible");
        [scrollView setContentOffset:CGPointZero animated:YES];
    }
    else{
        NSLog(@"Keyboard not Visible");
    }
    
    NSString *str_sec_Answer1 = answerTF1.text;
    NSString *str_sec_Answer2 = answerTF2.text;
    NSString *str_sec_Answer3 = answerTF3.text;
    if(answerTF1.text.length==0||answerTF2.text.length==0||answerTF3.text.length==0||[[question1 titleLabel] text].length==0||[[question2 titleLabel] text].length==0||[[question3 titleLabel] text].length==0||[[question1 titleLabel] text].length<=3||[[question2 titleLabel] text].length<=3||[[question3 titleLabel] text].length<=3){
        NSLog(@"Error ni Bai!");
        
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Fill All Fields." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
    
    
    else if(str_sec_Answer1.length<=3&&str_sec_Answer1.length>=1){
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Your answer in Question 1 must have 4 letter's or more." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
    else if([[[question1 titleLabel] text] isEqualToString:@"Question 1"]||[[question1 titleLabel] text].length<=3||[[[question1 titleLabel] text] isEqualToString:@"Please select a question."]){
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"The first question is invalid. \n Select another question." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
    else if([[[question2 titleLabel] text] isEqualToString:@"Question 2"]||[[question2 titleLabel] text].length<=3||[[[question2 titleLabel] text] isEqualToString:@"Please select a question."]){
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"The second question is invalid. \n Select another question." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
    else if([[[question3 titleLabel] text] isEqualToString:@"Question 3"]||[[question3 titleLabel] text].length<=3||[[[question3 titleLabel] text] isEqualToString:@"Please select a question."]){
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"The third question is invalid. \n Select another question." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
    else if(str_sec_Answer2.length<=3&&str_sec_Answer2.length>=1){
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Your answer in Question 2 must have 4 letter's or more." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
    else if(str_sec_Answer3.length<=3&&str_sec_Answer3.length>=1){
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Your answer in Question 3 must have 4 letter's or more." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
    else if([str_sec_Answer1 isEqualToString:str_sec_Answer2]||[str_sec_Answer1 isEqualToString:str_sec_Answer3]||[str_sec_Answer2 isEqualToString:str_sec_Answer1]||[str_sec_Answer2 isEqualToString:str_sec_Answer3]||[str_sec_Answer3 isEqualToString:str_sec_Answer1]||[str_sec_Answer3 isEqualToString:str_sec_Answer2]){
        [UIAlertView myCostumeAlert:@"Validation Error" alertMessage:@"Answer's must not be the same." delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }
    
    else if(answerTF1.text.length>=4&&answerTF2.text.length>=4&&answerTF3.text.length>=4&&[[question1 titleLabel] text].length>=4&&[[question2 titleLabel] text].length>=4&&[[question3 titleLabel] text].length>=4&&![[[question1 titleLabel] text] isEqualToString:@"Question 1"]&&![[[question2 titleLabel] text] isEqualToString:@"Question 2"]&&![[[question3 titleLabel] text] isEqualToString:@"Question 3"])
    {
        NSLog(@"Next ni Bai!");
        AccountLogin *accLog = [[AccountLogin alloc] initWithNibName:@"AccountLogin" bundle:nil];
        
        accLog.act_log_custIDfirstNumber = quest_act_custIDfirstNumber;
        accLog.act_log_custIDsecondNumber = quest_act_custIDsecondNumber;
        accLog.act_log_custIDthirdNumber = quest_act_custIDthirdNumber;
        accLog.act_log_custIDphoneNumber = quest_act_custIDphoneNumber;
        
        accLog.act_log_firstName = quest_act_firstName;
        accLog.act_log_middleName = quest_act_middleName;
        accLog.act_log_lastName = quest_act_lastName;
        accLog.act_log_country = quest_act_country;
        accLog.act_log_province = quest_act_province;
        accLog.act_log_address = quest_act_address;
        accLog.act_log_zipcode = quest_act_zipcode;
        accLog.act_log_gender = quest_act_gender;
        accLog.act_log_birthdate = quest_act_birthdate;
        accLog.act_log_number = quest_act_number;
        accLog.act_log_email = quest_act_email;
        accLog.act_log_work = quest_act_work;
        accLog.act_log_nationality = quest_act_nationality;
        
        
        accLog.act_log_str_photo1 = quest_act_str_photo1;
        accLog.act_log_str_photo2 = quest_act_str_photo2;
        accLog.act_log_str_photo3 = quest_act_str_photo3;
        accLog.act_log_str_photo4 = quest_act_str_photo4;
        accLog.act_log_str_balance = quest_act_str_balance;
        accLog.act_log_str_secanswer1 = answerTF1.text;
        accLog.act_log_str_secanswer2 = answerTF2.text;
        accLog.act_log_str_secanswer3 = answerTF3.text;
        accLog.act_log_str_secquestion1 = [[question1 titleLabel] text];
        accLog.act_log_str_secquestion2 = [[question2 titleLabel] text];
        accLog.act_log_str_secquestion3 = [[question3 titleLabel] text];
        accLog.act_log_str_walletno = quest_act_str_walletno;
        
        accLog.act_log_str_photo1 = quest_act_str_photo1;
        accLog.act_log_str_photo2 = quest_act_str_photo2;
        accLog.act_log_str_photo3 = quest_act_str_photo3;
        accLog.act_log_str_photo4 = quest_act_str_photo4;
      //  NSLog(@"Ang Wallet Number ----- %@",quest_act_str_walletno);
       // NSLog(@"first question %@ , second question %@ , third question %@",[[question1 titleLabel] text],[[question2 titleLabel] text],[[question3 titleLabel] text]);
        [self.navigationController pushViewController:accLog animated:YES];
        
    }
    
    
    
    
}



- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end
