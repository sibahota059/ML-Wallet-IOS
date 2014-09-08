//
//  EditQuestionsPad.m
//  ML Wallet
//
//  Created by mm20-18 on 8/5/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditQuestionsPad.h"
#import "ProfileButton.h"
#import "ProfileLabel.h"
#import "SelectQuestionDialogPad.h"
#import "NSDictionary+LoadWalletData.h"
#import "SaveWalletData.h"

@interface EditQuestionsPad ()

@end

@implementation EditQuestionsPad

EditSecretQuestionsWebService *editSecretQuestionWS;

UIScrollView *scrollView;
UIView *disableBackground;

MBProgressHUD *HUD;


NSArray *questions1, *questions2, *questions3;

ProfileButton *button1, *button2, *button3;
ProfileLabel *questionLbl1, *questionLbl2, *questionLbl3;
UITextField *firstAnswer, *secondAnswer, *thirdAnswer;

NSString *question1, *question2, *question3, *answer1, *answer2, *answer3;

NSString *finalQuestion1, *finalQuestion2, *finalQuestion3, *finalAnswer1, *finalAnswer2, *finalAnswer3;

SelectQuestionDialogPad *questionDialog;

NSString *QUESTIONPAD_VAL_ERROR = @"Validation Error";

NSString *wallet;

NSDictionary *loadData;

NSString *userInputFirstAnswer, *userInputSecondAnswer, *userInputThirdAnswer;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    questions1 = [[NSArray alloc] initWithObjects:@"What is your school in sixth grade?", @"What's your childhood nickname?", @"What's your mom's middle name?", @"What city was your first job?", @"What is your favorite movie?", nil];
    
    questions2 = [[NSArray alloc] initWithObjects:@"What is your favorite TV program?", @"What city were you born?", @"Where did your parent's meet?", @"What's your dad's middle name?", @"What is your favorite book?", nil];
    
    questions3 = [[NSArray alloc] initWithObjects:@"What was your dream job?", @"What is your pet's name?", @"What is your musical genre?", @"Where is your dream vacation?", @"Who was your childhood hero?", nil];
    editSecretQuestionWS = [EditSecretQuestionsWebService new];
    editSecretQuestionWS.delegate = self;
    
    //create object of MBProgressHUD class, set delegate, and add loader view
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;

    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 500)];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(768, 500)];
    
    
    loadData = [NSDictionary initRead_LoadWallet_Data];
    
    wallet = [loadData objectForKey:@"walletno"];

    question1 = [loadData objectForKey:@"secquestion1"];
    question2 = [loadData objectForKey:@"secquestion2"];
    question3  = [loadData objectForKey:@"secquestion3"];
    
    answer1 = [loadData objectForKey:@"secanswer1"];
    answer2 = [loadData objectForKey:@"secanswer2"];
    answer3 = [loadData objectForKey:@"secanswer3"];
    
    
    disableBackground = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    [disableBackground setBackgroundColor:[UIColor blackColor]];
    [disableBackground setHidden:YES];
    [disableBackground setAlpha:0.5f];
    
    [self addNavigationBarButton];
    [self createQuestion];
    [self createAnswer];
    
    [self.view addSubview:scrollView];
    [self.view addSubview: disableBackground];
    
    
}

-(void) createQuestion{
    
    
    
    //QUESTION 1
    
    button1 = [[ProfileButton alloc] initWithString:@"?" x:167 y:190];
    [button1 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    
    questionLbl1 =[[ProfileLabel alloc] initWithStatus:@"Question 1" x:205 y:190 myColor:[UIColor blackColor] width:260];
    [questionLbl1 setText:question1];
    
    
    
    //QUESTION 2
    
    button2 = [[ProfileButton alloc] initWithString:@"?" x:167 y:285];
    [button2 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    questionLbl2 = [[ProfileLabel alloc] initWithStatus:@"Question 2" x:205 y:285 myColor:[UIColor blackColor] width:260];
     [questionLbl2 setText:question2];
    
    
    //QUESITON 3
    
    button3 = [[ProfileButton alloc] initWithString:@"?" x:167 y:380];
    [button3 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    questionLbl3 = [[ProfileLabel alloc] initWithStatus:@"Question 3" x:205 y:380 myColor:[UIColor blackColor] width:260];
    
     [questionLbl3 setText:question3];
    
    
    
    
    
    
    
    
    //ADDING THE COMPONENTS
    
    [scrollView addSubview:button1];
    [scrollView addSubview:questionLbl1];
    
    [scrollView addSubview:button2];
    [scrollView addSubview:questionLbl2];
    
    [scrollView addSubview:button3];
    [scrollView addSubview:questionLbl3];
    
    
    
    
}



-(void) createAnswer{
    
    
    
    //QUESTION 1
    UIView *leftMarginQuestion1= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    firstAnswer = [[UITextField alloc] initWithFrame:CGRectMake(169, 232, 434, 35)];
    firstAnswer.layer.cornerRadius = 8.0f;
    firstAnswer.layer.masksToBounds = YES;
    firstAnswer.layer.borderColor=[[UIColor redColor]CGColor];
    firstAnswer.layer.borderWidth = 1.0f;
    firstAnswer.leftView = leftMarginQuestion1;
    firstAnswer.leftViewMode = UITextFieldViewModeAlways;
    
    [firstAnswer setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [firstAnswer setBackgroundColor:[UIColor whiteColor]];
    [firstAnswer setText:answer1];
    
    
    //QUESTION 2
    UIView *leftMarginQuestion2= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    secondAnswer = [[UITextField alloc] initWithFrame:CGRectMake(169, 327, 434, 35)];
    secondAnswer.layer.cornerRadius = 8.0f;
    secondAnswer.layer.masksToBounds = YES;
    secondAnswer.layer.borderColor=[[UIColor redColor]CGColor];
    secondAnswer.layer.borderWidth = 1.0f;
    secondAnswer.leftView = leftMarginQuestion2;
    secondAnswer.leftViewMode = UITextFieldViewModeAlways;
    
    [secondAnswer setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [secondAnswer setBackgroundColor:[UIColor whiteColor]];
    [secondAnswer setText:answer2];
    
    
    //QUESITON 3
    UIView *leftMarginQuestion3= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    thirdAnswer = [[UITextField alloc] initWithFrame:CGRectMake(169, 422, 434, 35)];
    thirdAnswer.layer.cornerRadius = 8.0f;
    thirdAnswer.layer.masksToBounds = YES;
    thirdAnswer.layer.borderColor=[[UIColor redColor]CGColor];
    thirdAnswer.layer.borderWidth = 1.0f;
    thirdAnswer.leftView = leftMarginQuestion3;
    thirdAnswer.leftViewMode = UITextFieldViewModeAlways;
    
    [thirdAnswer setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [thirdAnswer setBackgroundColor:[UIColor whiteColor]];
    [thirdAnswer setText:answer3];
    
    
    
    firstAnswer.delegate = self;
    secondAnswer.delegate = self;
    thirdAnswer.delegate = self;
    
    //ADDING THE COMPONENTS
    
    [scrollView addSubview: firstAnswer];
    [scrollView addSubview:secondAnswer];
    [scrollView addSubview:thirdAnswer];
    
}




-(void)show:(id)sender{

    if(sender == button1)
    {
        questionDialog = [[SelectQuestionDialogPad alloc] initWithFrame:CGRectMake(0, 10, 320, 500) stringArray:questions1];
        [disableBackground setHidden:NO];
        [self.view addSubview:questionDialog];
        [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion1:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    else if(sender == button2)
    {
        questionDialog = [[SelectQuestionDialogPad alloc] initWithFrame:CGRectMake(0, 10, 320, 500) stringArray:questions2];
        [disableBackground setHidden:NO];
        [self.view addSubview:questionDialog];
        [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion2:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        questionDialog = [[SelectQuestionDialogPad alloc] initWithFrame:CGRectMake(0, 10, 320, 500) stringArray:questions3];
        [disableBackground setHidden:NO];
        [self.view addSubview:questionDialog];
        [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion3:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
}

-(void) finishSelectingQuestion1:(id)sender{
    
    NSString *selectedQuestion = [questionDialog getSelectedQuestion];
    if([selectedQuestion isEqualToString:@""])
    {
        UIAlertView *pleaseSelect = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please select 1 question." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [pleaseSelect show];
    }
    else
    {
        [disableBackground setHidden:YES];
        [questionLbl1 setText:selectedQuestion];
        [questionDialog removeFromSuperview];
    }
    
}

-(void) finishSelectingQuestion2:(id)sender{
    
    NSString *selectedQuestion = [questionDialog getSelectedQuestion];
    if([selectedQuestion isEqualToString:@""])
    {
        UIAlertView *pleaseSelect = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please select 1 question." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [pleaseSelect show];
    }
    else
    {
        [disableBackground setHidden:YES];
        [questionLbl2 setText:[questionDialog getSelectedQuestion]];
        [questionDialog removeFromSuperview];
    }
    
}

-(void) finishSelectingQuestion3:(id)sender{
    
    NSString *selectedQuestion = [questionDialog getSelectedQuestion];
    if([selectedQuestion isEqualToString:@""])
    {
        UIAlertView *pleaseSelect = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please select 1 question." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [pleaseSelect show];
    }
    else
    {
        [disableBackground setHidden:YES];
        [questionLbl3 setText:[questionDialog getSelectedQuestion]];
        [questionDialog removeFromSuperview];
    }
    
}

-(void)fadeInAnimation:(UIView *) aView{
    CATransition *transition = [CATransition animation];
    transition.type = kCAAnimationRotateAuto;
    transition.duration = 0.5f;
    transition.delegate = self;
    [aView.layer addAnimation:transition forKey:nil];
    
}

-(void) addNavigationBarButton {
    
    self.title =@"Secret Questions";
    //LEFT NAVIGATION BUTTON
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    
    UIBarButtonItem *backNavButton = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [backNavButton setStyle:UIBarButtonItemStyleBordered];
    
    //RIGHT NAVIGATION BUTTON
    UIView *saveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [saveButton setImage:[UIImage imageNamed:@"my_save.png"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(savePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [saveView addSubview:saveButton];
    
    UIBarButtonItem *saveNavButton = [[UIBarButtonItem alloc] initWithCustomView:saveView];
    [saveNavButton setStyle:UIBarButtonItemStyleBordered];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationItem setLeftBarButtonItem:backNavButton];
    [self.navigationItem setRightBarButtonItem:saveNavButton];
    
}

-(void)backPressed:(id)sender{
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}

-(void) getAnswer{
    
    
    userInputFirstAnswer = firstAnswer.text;
    userInputSecondAnswer = secondAnswer.text;
    userInputThirdAnswer = thirdAnswer.text;
    
    
    if([userInputFirstAnswer isEqualToString:@""])
    {
        finalQuestion1 = questionLbl1.text;
        finalAnswer1 = answer1;
    }
    else
    {
        finalQuestion1 = questionLbl1.text;
        finalAnswer1 = userInputFirstAnswer;
        
    }
    
    
    if([userInputSecondAnswer isEqualToString:@""])
    {
        finalQuestion2 = questionLbl2.text;
        finalAnswer2 = answer2;
    }
    else
    {
        finalQuestion2 = questionLbl2.text;
        finalAnswer2 = userInputSecondAnswer;
        
    }
    
    
    if([userInputThirdAnswer isEqualToString:@""])
    {
        finalQuestion3 = questionLbl3.text;
        finalAnswer3 = answer3;
    }
    else
    {
        finalQuestion3 = questionLbl3.text;
        finalAnswer3 = userInputThirdAnswer;
        
    }
    
}

-(void)savePressed:(id)sender{
    
    UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [self getAnswer];
    if([answer1 isEqualToString:@""] || [answer2 isEqualToString:@""] || [answer3 isEqualToString:@""])
    {
        [saveAlert setMessage:@"Input all fields."];
        [saveAlert show];
    }
    else if (finalAnswer1.length < 4)
    {
        [saveAlert setMessage:@"All your answers must have 4 letters or more."];
        [saveAlert show];
    }
    else if([finalAnswer1 isEqualToString:finalAnswer2] || [finalAnswer2 isEqualToString:finalAnswer3] || [finalAnswer3 isEqualToString:finalAnswer1])
    {
        [saveAlert setMessage:@"All your answers must not be the same."];
        [saveAlert show];
        
    }
    else
    {
        
        [editSecretQuestionWS wallet:wallet secQuestion1:finalQuestion1 secQuestion2:finalQuestion2 secQuestion3:finalQuestion3 secAns1:finalAnswer1 secAns2:finalAnswer2 secAns3:finalAnswer3];
        [self displayProgressBar];
    }
    
    
    
}


-(void) saveToPaylist{
    
    SaveWalletData *saveData = [SaveWalletData new];
    
    [saveData initSaveData:finalAnswer1 forKey:@"secanswer1"];
    [saveData initSaveData:finalAnswer2 forKey:@"secanswer2"];
    [saveData initSaveData:finalAnswer3 forKey:@"secanswer3"];
    [saveData initSaveData:finalQuestion1 forKey:@"secquestion1"];
    [saveData initSaveData:finalQuestion2 forKey:@"secquestion2"];
    [saveData initSaveData:finalQuestion3 forKey:@"secquestion3"];
    
    
}


- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)didFinishEditingQuestions:(NSString *)indicator andError:(NSString *)getError{
    
    UIAlertView *resultAlertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    
    if ([indicator isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@", editSecretQuestionWS.respcode]isEqualToString:@"1"]){
        
        [resultAlertView setMessage:editSecretQuestionWS.respmessage];
        [self saveToPaylist];
        [self dismissProgressBar];
    }
    else if ([[NSString stringWithFormat:@"%@", editSecretQuestionWS.respcode] isEqualToString:@"0"])
        
    {
        [resultAlertView setMessage:editSecretQuestionWS.respmessage];
        
    }
    else if ([indicator isEqualToString:@"error"])
    {
        [resultAlertView setMessage:@"Error in editing your Secret Questions."];
    }else{
        
        [resultAlertView setMessage:@"Service is temporarily unavailable. Please try again or contact us at (032) 232-1036 or 0947-999-1948" ];
    }
    
    [resultAlertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [firstAnswer resignFirstResponder];
    [secondAnswer resignFirstResponder];
    [thirdAnswer resignFirstResponder];
    
    return YES;
}

- (void)displayProgressBar{
    
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    
}

- (void)dismissProgressBar{
    
    [HUD hide:YES];
    [HUD show:NO];
    
}

@end
