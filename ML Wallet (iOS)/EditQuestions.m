//
//  EditQuestions.m
//  ML Wallet
//
//  Created by mm20-18 on 8/1/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditQuestions.h"
#import "ProfileButton.h"
#import "ProfileLabel.h"
#import "ProfileTextField.h"
#import "SelectQuestionDialog.h"

@interface EditQuestions ()

@end

@implementation EditQuestions

UIScrollView *scrollView;
UIView *disableBackground;


NSArray *questions1, *questions2, *questions3;

ProfileButton *button1, *button2, *button3;
ProfileLabel *questionLbl1, *questionLbl2, *questionLbl3;
ProfileTextField *answerTF1, *answerTF2, *answerTF3;


SelectQuestionDialog *questionDialog;


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
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, 300)];
    

    
    
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
    
    button1 = [[ProfileButton alloc] initWithString:@"?" x:10 y:30];
    [button1 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    
    questionLbl1 =[[ProfileLabel alloc] initWithStatus:@"Question 1" x:45 y:30 myColor:[UIColor blackColor] width:260];
   

    
    //QUESTION 2
    
    button2 = [[ProfileButton alloc] initWithString:@"?" x:10 y:120];
    [button2 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    questionLbl2 = [[ProfileLabel alloc] initWithStatus:@"Question 2" x:45 y:120 myColor:[UIColor blackColor] width:260];

    //QUESITON 3
    
    button3 = [[ProfileButton alloc] initWithString:@"?" x:10 y:210];
    [button3 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    questionLbl3 = [[ProfileLabel alloc] initWithStatus:@"Question 3" x:45 y:210 myColor:[UIColor blackColor] width:260];

    
    
    answerTF1.delegate = self;
    answerTF2.delegate = self;
    answerTF3.delegate = self;
    
    
    
    
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
    answerTF1 = [[ProfileTextField alloc] initWithFrame:CGRectMake(5, 70, 285, 30) word:@"answer 1"];
    
    
    //QUESTION 2
    answerTF2 = [[ProfileTextField alloc] initWithFrame:CGRectMake(5, 160, 285, 30) word:@"answer 2"];

    
    //QUESITON 3
    answerTF3 = [[ProfileTextField alloc] initWithFrame:CGRectMake(5, 250, 285, 30) word:@"answer 3"];

    
    answerTF1.delegate = self;
    answerTF2.delegate = self;
    answerTF3.delegate = self;

    //ADDING THE COMPONENTS

    [scrollView addSubview: answerTF1];
    [scrollView addSubview:answerTF2];
    [scrollView addSubview:answerTF3];

}














-(void)show:(id)sender{
    
    
    
    if(sender == button1)
    {
        questionDialog = [[SelectQuestionDialog alloc] initWithFrame:CGRectMake(0, 50, 320, 500) stringArray:questions1];
        [disableBackground setHidden:NO];
        [self.view addSubview:questionDialog];
        [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion1:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    else if(sender == button2)
    {
        questionDialog = [[SelectQuestionDialog alloc] initWithFrame:CGRectMake(0, 50, 320, 500) stringArray:questions2];
        [disableBackground setHidden:NO];
        [self.view addSubview:questionDialog];
        [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion2:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        questionDialog = [[SelectQuestionDialog alloc] initWithFrame:CGRectMake(0, 50, 320, 500) stringArray:questions3];
        [disableBackground setHidden:NO];
        [self.view addSubview:questionDialog];
        [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion3:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
}




-(void) finishSelectingQuestion1:(id)sender{
    
    [disableBackground setHidden:YES];
    [questionLbl1 setText:[questionDialog getSelectedQuestion]];
    [questionDialog removeFromSuperview];
    
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
    
    //    [UIView animateWithDuration:0.5
    //                          delay:0.0
    //                        options:UIViewAnimationOptionCurveEaseIn
    //                     animations:^{self.view.frame = CGRectMake(0, 20, 320, 1000); }
    //                     completion:^(BOOL finished){}];
    
    
    
    [answerTF1 resignFirstResponder];
    [answerTF2 resignFirstResponder];
    [answerTF3 resignFirstResponder];
    
    return YES;
}


















-(void) addNavigationBarButton {
    
    
    self.title =@"Secret Questions";
    //LEFT NAVIGATION BUTTON
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [backButton setImage:[UIImage imageNamed:@"back_profile.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    
    UIBarButtonItem *backNavButton = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [backNavButton setStyle:UIBarButtonItemStyleBordered];
    
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationItem setLeftBarButtonItem:backNavButton];
    
}


-(void)backPressed:(id)sender{
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}


- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
