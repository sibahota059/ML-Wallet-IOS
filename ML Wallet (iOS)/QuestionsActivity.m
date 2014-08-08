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
@interface QuestionsActivity ()

@end

@implementation QuestionsActivity

UIScrollView *scrollView;
UIView *disableBackground;


NSArray *questions1, *questions2, *questions3;

ProfileButton *button1, *button2, *button3;
ProfileLabel *questionLbl1, *questionLbl2, *questionLbl3;
ProfileTextField *answerTF1, *answerTF2, *answerTF3;
CGRect screenRect;
CGFloat screenWidth;
CGFloat screenHeight;
UITextfieldAnimate *textAnimate;
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
    
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(screenWidth, screenHeight)];
    
    AccountLogin *accountLogin = [[AccountLogin alloc] initWithNibName:@"AccountLogin" bundle:nil];
    [self setNextViewController:accountLogin myImage:[UIImage imageNamed:@"next.png"]];
    
    
    disableBackground = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    [disableBackground setBackgroundColor:[UIColor blackColor]];
    [disableBackground setHidden:YES];
    [disableBackground setAlpha:0.5f];
    
    [self createQuestion];
    self.title = @"Security Questions";
    [self.view addSubview:scrollView];
    [self.view addSubview: disableBackground];
    
}
-(void)viewDidAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) createQuestion{
    if ( IDIOM == IPAD ) {
        /* do something specifically for iPad. */
        NSLog(@"IPAD");
        UIView* simpleView = [[UIView alloc] initWithFrame:CGRectMake(0,screenHeight*.05,screenWidth,screenHeight)];
        ProfileHeader *questionHeader = [[ProfileHeader alloc] initWithValue:@" Secret Questions" x:5 y:5 width:140];
        
        //QUESTION 1
        
        button1 = [[ProfileButton alloc] initWithString:@"?" x:screenWidth/3.9 y:30];
        [button1 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        questionLbl1 =[[ProfileLabel alloc] initWithStatus:@"Question 1" x:screenWidth/3 y:30 myColor:[UIColor blackColor] width:260];
        answerTF1 = [[ProfileTextField alloc] initWithFrame:CGRectMake(screenWidth/4, 70, screenWidth/2, 30) word:@"answer 1"];
        answerTF1.layer.cornerRadius=8.0f;
        answerTF1.layer.masksToBounds=YES;
        answerTF1.layer.borderColor=[[UIColor redColor]CGColor];
        answerTF1.layer.borderWidth= 1.0f;
        
        //QUESTION 2
        
        button2 = [[ProfileButton alloc] initWithString:@"?" x:screenWidth/3.9 y:120];
        [button2 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        questionLbl2 = [[ProfileLabel alloc] initWithStatus:@"Question 2" x:screenWidth/3 y:120 myColor:[UIColor blackColor] width:260];
        answerTF2 = [[ProfileTextField alloc] initWithFrame:CGRectMake(screenWidth/4,160, screenWidth/2, 30) word:@"answer 2"];
        answerTF2.layer.cornerRadius=8.0f;
        answerTF2.layer.masksToBounds=YES;
        answerTF2.layer.borderColor=[[UIColor redColor]CGColor];
        answerTF2.layer.borderWidth= 1.0f;
        
        
        //QUESITON 3
        
        button3 = [[ProfileButton alloc] initWithString:@"?" x:screenWidth/3.9 y:210];
        [button3 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        questionLbl3 = [[ProfileLabel alloc] initWithStatus:@"Question 3" x:screenWidth/3 y:210 myColor:[UIColor blackColor] width:260];
        answerTF3 = [[ProfileTextField alloc] initWithFrame:CGRectMake(screenWidth/4, 250, screenWidth/2, 30) word:@"answer 3"];
        
        answerTF3.layer.cornerRadius=8.0f;
        answerTF3.layer.masksToBounds=YES;
        answerTF3.layer.borderColor=[[UIColor redColor]CGColor];
        answerTF3.layer.borderWidth= 1.0f;
        
        
        
        
        answerTF1.delegate = self;
        answerTF2.delegate = self;
        answerTF3.delegate = self;
        
        
        NSLog(@"%f-------%f",screenWidth,screenHeight);
        
        
        
        [simpleView addSubview:questionHeader];
        [simpleView addSubview:button1];
        [simpleView addSubview:questionLbl1];
        [simpleView addSubview: answerTF1];
        
        [simpleView addSubview:button2];
        [simpleView addSubview:questionLbl2];
        [simpleView addSubview:answerTF2];
        
        [simpleView addSubview:button3];
        [simpleView addSubview:questionLbl3];
        [simpleView addSubview:answerTF3];
        [scrollView addSubview:simpleView];
    } else {
        /* do something specifically for iPhone or iPod touch. */
        NSLog(@"IPHONE");
        UIView* simpleView = [[UIView alloc] initWithFrame:CGRectMake(0,-10,screenWidth,screenHeight)];
     //   ProfileHeader *questionHeader = [[ProfileHeader alloc] initWithValue:@" Secret Questions" x:5 y:5 width:140];
        
        //QUESTION 1
        questionLbl1 =[[ProfileLabel alloc] initWithStatus:@"Question 1" x:45 y:30 myColor:[UIColor blackColor] width:260];
        float questionLbl1_Co = ((self.view.frame.size.width)/2)-110;
        [questionLbl1 setFrame:CGRectMake(questionLbl1_Co, 30, 260, 30)];
        
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
        questionLbl2 = [[ProfileLabel alloc] initWithStatus:@"Question 2" x:45 y:120 myColor:[UIColor blackColor] width:260];
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
        questionLbl3 = [[ProfileLabel alloc] initWithStatus:@"Question 3" x:45 y:210 myColor:[UIColor blackColor] width:260];
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
        
        
        
        
        //ADDING THE COMPONENTS
        /*
         [questionOutline addSubview:questionHeader];
         [questionOutline addSubview:button1];
         [questionOutline addSubview:questionLbl1];
         [questionOutline addSubview: answerTF1];
         
         [questionOutline addSubview:button2];
         [questionOutline addSubview:questionLbl2];
         [questionOutline addSubview:answerTF2];
         
         [questionOutline addSubview:button3];
         [questionOutline addSubview:questionLbl3];
         [questionOutline addSubview:answerTF3];
         [scrollView addSubview:questionOutline];
         */
        
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        NSLog(@"%f-------%f",screenWidth,screenHeight);
        
        
        
   //    [simpleView addSubview:questionHeader];
        [simpleView addSubview:button1];
        [simpleView addSubview:questionLbl1];
        [simpleView addSubview: answerTF1];
        
        [simpleView addSubview:button2];
        [simpleView addSubview:questionLbl2];
        [simpleView addSubview:answerTF2];
        
        [simpleView addSubview:button3];
        [simpleView addSubview:questionLbl3];
        [simpleView addSubview:answerTF3];
        [scrollView addSubview:simpleView];
    }
    
    
    
    
    
    
}


-(void)show:(id)sender{
    if ( IDIOM == IPAD ) {
        float dialogCO = (self.view.frame.size.width - 320)/2;
        if(sender == button1)
        {
            questionDialog = [[SelectQuestionDialog alloc] initWithFrame:CGRectMake(dialogCO, -30, 320, 500) stringArray:questions1];
            [disableBackground setHidden:NO];
            [self.view addSubview:questionDialog];
            [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion1:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        else if(sender == button2)
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
    else{
    
        if(sender == button1)
        {
            questionDialog = [[SelectQuestionDialog alloc] initWithFrame:CGRectMake(0, -30, 320, 500) stringArray:questions1];
            [disableBackground setHidden:NO];
            [self.view addSubview:questionDialog];
            [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion1:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        else if(sender == button2)
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
/*
- (void)textFieldDidBeginEditing:(UITextField *)textField {
 
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y);
    [scrollView setContentOffset:scrollPoint animated:YES];
 
    [textAnimate animateTextField:textField up:YES SelfView:self.view];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
   // [scrollView setContentOffset:CGPointZero animated:YES];
    [textAnimate animateTextField:textField up:NO SelfView:self.view];
    [self.view endEditing:YES];
}
*/
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y);
    [scrollView setContentOffset:scrollPoint animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [scrollView setContentOffset:CGPointZero animated:YES];
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
    
    return NO;
}




- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end
