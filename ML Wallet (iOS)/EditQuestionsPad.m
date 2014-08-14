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

@interface EditQuestionsPad ()

@end

@implementation EditQuestionsPad

UIScrollView *scrollView;
UIView *disableBackground;


NSArray *questionsArray1, *questionsArray2, *questionsArray3;

ProfileButton *button1, *button2, *button3;
ProfileLabel *questionLbl1, *questionLbl2, *questionLbl3;
UITextField *firstAnswer, *secondAnswer, *thirdAnswer;

NSString *question1, *question2, *question3, *answer1, *answer2, *answer3;

SelectQuestionDialogPad *questionDialog;

NSString *QUESTIONPAD_VAL_ERROR = @"Validation Error";

NSDictionary *loadData;


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
    
    questionsArray1 = [[NSArray alloc] initWithObjects:@"What is your school in sixth grade?", @"What's your childhood nickname?", @"What's your mom's middle name?", @"What city was your first job?", @"What is your favorite movie?", nil];
    
    questionsArray2 = [[NSArray alloc] initWithObjects:@"What is your favorite TV program?", @"What city were you born?", @"Where did your parent's meet?", @"What's your dad's middle name?", @"What is your favorite book?", nil];
    
    questionsArray3 = [[NSArray alloc] initWithObjects:@"What was your dream job?", @"What is your pet's name?", @"What is your musical genre?", @"Where is your dream vacation?", @"Who was your childhood hero?", nil];
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 500)];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(768, 500)];
    
    
    loadData = [NSDictionary initRead_LoadWallet_Data];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UIView *firstAnswerOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 230, 434, 35)];
    [firstAnswerOutline setBackgroundColor:[UIColor redColor]];
    
    firstAnswer = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [firstAnswer setBackgroundColor:[UIColor whiteColor]];
    [firstAnswer setFont:[UIFont systemFontOfSize:19.0f]];
    [firstAnswer setPlaceholder:answer1];
    [firstAnswerOutline addSubview:firstAnswer];
    
    
    //QUESTION 2
    UIView *secondAnswerOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 325, 434, 35)];
    [secondAnswerOutline setBackgroundColor:[UIColor redColor]];
    
    secondAnswer = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [secondAnswer setBackgroundColor:[UIColor whiteColor]];
    [secondAnswer setFont:[UIFont systemFontOfSize:19.0f]];
    [secondAnswer setPlaceholder:answer2];
    [secondAnswerOutline addSubview:secondAnswer];
    
    
    //QUESITON 3
    UIView *thirdAnswerOutline = [[UIView alloc] initWithFrame:CGRectMake(167, 420, 434, 35)];
    [thirdAnswerOutline setBackgroundColor:[UIColor redColor]];
    
    thirdAnswer = [[UITextField alloc] initWithFrame:CGRectMake(2, 2, 430, 31)];
    [thirdAnswer setBackgroundColor:[UIColor whiteColor]];
    [thirdAnswer setFont:[UIFont systemFontOfSize:19.0f]];
    [thirdAnswer setPlaceholder:answer3];
    [thirdAnswerOutline addSubview:thirdAnswer];
    
    
    
    firstAnswer.delegate = self;
    secondAnswer.delegate = self;
    thirdAnswer.delegate = self;
    
    //ADDING THE COMPONENTS
    
    [scrollView addSubview: firstAnswerOutline];
    [scrollView addSubview:secondAnswerOutline];
    [scrollView addSubview:thirdAnswerOutline];
    
}














-(void)show:(id)sender{
    
    
    
    if(sender == button1)
    {
        questionDialog = [[SelectQuestionDialogPad alloc] initWithFrame:CGRectMake(0, 10, 768, 500) stringArray:questionsArray1];
        [disableBackground setHidden:NO];
        [self.view addSubview:questionDialog];
        [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion1:) forControlEvents:UIControlEventTouchUpInside];
        
        [questionDialog setHidden:NO];
        
        [self.view addSubview:questionDialog];
        

        
        
    }
    else if(sender == button2)
    {
        questionDialog = [[SelectQuestionDialogPad alloc] initWithFrame:CGRectMake(0, 10, 768, 500) stringArray:questionsArray2];
        [disableBackground setHidden:NO];
        [self.view addSubview:questionDialog];
        [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion2:) forControlEvents:UIControlEventTouchUpInside];
        
        [self fadeInAnimation:disableBackground];
        

    }
    else
    {
        questionDialog = [[SelectQuestionDialogPad alloc] initWithFrame:CGRectMake(0, 10, 768 , 500) stringArray:questionsArray3];
        [disableBackground setHidden:NO];
        [self.view addSubview:questionDialog];
        [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion3:) forControlEvents:UIControlEventTouchUpInside];
        
        [self fadeInAnimation:disableBackground];
        
    }
    
    
    
}




-(void) finishSelectingQuestion1:(id)sender{
    
    [disableBackground setHidden:YES];
    [questionLbl1 setText:[questionDialog getSelectedQuestion]];
    [questionDialog removeFromSuperview];
    [self fadeInAnimation:disableBackground];
    [self fadeInAnimation:questionDialog];
    
 
    
}

-(void) finishSelectingQuestion2:(id)sender{
    
    [disableBackground setHidden:YES];
    [questionLbl2 setText:[questionDialog getSelectedQuestion]];
    [questionDialog removeFromSuperview];
    
    
}

-(void) finishSelectingQuestion3:(id)sender{
    
    [disableBackground setHidden:YES];
    [questionLbl3 setText:[questionDialog getSelectedQuestion]];
    [questionDialog removeFromSuperview];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [firstAnswer resignFirstResponder];
    [secondAnswer resignFirstResponder];
    [thirdAnswer resignFirstResponder];
    
    return YES;
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
    //    [backButton setImage:[UIImage imageNamed:@"back_profile.png"] forState:UIControlStateNormal];
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


-(void)savePressed:(id)sender{
    
    UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:QUESTIONPAD_VAL_ERROR message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    
    NSString *userInputFirstAnswer = firstAnswer.text;
    NSString *userInputSecondAnswer = secondAnswer.text;
    NSString *userInputThirdAnswer = thirdAnswer.text;
    
    if([userInputFirstAnswer isEqualToString:@""] || [userInputSecondAnswer isEqualToString:@""] || [userInputThirdAnswer isEqualToString:@""])
    {
        [saveAlert setMessage:@"Input all fields."];
    }
    
    

    
    
    
    //TO DO
    [saveAlert setMessage:@"Success."];
}





- (BOOL)prefersStatusBarHidden{
    return YES;
}


    


@end
