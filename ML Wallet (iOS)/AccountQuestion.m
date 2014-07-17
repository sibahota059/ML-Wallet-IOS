//
//  AccountQuestion.m
//  Account
//
//  Created by mm20-18 on 2/27/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "AccountQuestion.h"
#import "ProfileOutline.h"
#import "ProfileHeader.h"
#import "ProfileLabel.h"
#import "ProfileTextField.h"
#import "ProfileButton.h"
#import "SelectQuestionDialog.h"

@interface AccountQuestion ()

@end

@implementation AccountQuestion

UIScrollView *scrollView;
UIView *disableBackground;
UIView *questionView;



NSArray *questions1, *questions2, *questions3;

UILabel *qLabel1, *qLabel2, *qLabel3, *qLabel4, *qLabel5;


UIImageView *standbyCredentialsImage;
UIView *credentialsOutlineView;

ProfileTextField *answerTF1, *answerTF2, *answerTF3;
ProfileTextField *userNameTF, *oldPasswordTF, *newPasswordTF, *confirmPasswordTF;
ProfileButton *button1, *button2, *button3;
ProfileLabel *questionLbl1, *questionLbl2, *questionLbl3;
ProfileOutline *credentialsOutline;

int commonQuestionX = 10;
int textFieldQuestionWidth = 280;
int textFieldQuestionHeight = 30;


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
    // Do any additional setup after loading the view from its nib.
    
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
    
    
    [self createQuestion];
    [self createCredentials];
    
    [self addNavigationBarButton];
    
   
    [self.view addSubview:scrollView];
    [self.view addSubview: disableBackground];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - CREATE UI DISPLAY

-(void) createQuestion{
    
    ProfileOutline *questionOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(10, 20, 300, 300)];
    
    ProfileHeader *questionHeader = [[ProfileHeader alloc] initWithValue:@" Secret Questions" x:5 y:-10 width:140];
    
    //QUESTION 1
    
    button1 = [[ProfileButton alloc] initWithString:@"?" x:10 y:30];
    [button1 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    
    questionLbl1 =[[ProfileLabel alloc] initWithStatus:@"Question 1" x:45 y:30 myColor:[UIColor blackColor] width:260];

    answerTF1 = [[ProfileTextField alloc] initWithFrame:CGRectMake(5, 70, 285, 30) word:@"answer 1"];

    
    
    //QUESTION 2
    
    button2 = [[ProfileButton alloc] initWithString:@"?" x:10 y:120];
    [button2 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];

    questionLbl2 = [[ProfileLabel alloc] initWithStatus:@"Question 2" x:45 y:120 myColor:[UIColor blackColor] width:260];
    
    answerTF2 = [[ProfileTextField alloc] initWithFrame:CGRectMake(5, 160, 285, 30) word:@"answer 2"];
    
    
    
    //QUESITON 3
    
    button3 = [[ProfileButton alloc] initWithString:@"?" x:10 y:210];
    [button3 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    
    questionLbl3 = [[ProfileLabel alloc] initWithStatus:@"Question 3" x:45 y:210 myColor:[UIColor blackColor] width:260];
    
    answerTF3 = [[ProfileTextField alloc] initWithFrame:CGRectMake(5, 250, 285, 30) word:@"answer 3"];
    
    
    //ADDING THE COMPONENTS
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
    


}

-(void) createCredentials{

    ProfileLabel *userNameLabel, *oldPasswordLabel, *newPasswordLabel, *confirmPasswordLabel;
    
    credentialsOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(10, 380, 300, 245)];
    
    
    [self createCredentialsHeader];
    
    UIView *credentialsMainView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 296, 241)];
    [credentialsMainView setBackgroundColor:[UIColor whiteColor]];
    
    
    //USERNAME
    
    userNameLabel = [[ProfileLabel alloc] initWithStatus:@"Username/Login ID" x:commonQuestionX y:5 myColor:[UIColor blackColor] width:170];
    userNameTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonQuestionX, 30, textFieldQuestionWidth, textFieldQuestionHeight) word:@"Username/Login ID"];
    
    
    //OLD PASSWORD
    
    oldPasswordLabel = [[ProfileLabel alloc] initWithStatus:@"Old Password" x:commonQuestionX y:60 myColor:[UIColor blackColor]];
    oldPasswordTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonQuestionX, 85, textFieldQuestionWidth, textFieldQuestionHeight) word:@"Old Password"];
    
    
    //NEW PASSWORD
    
    newPasswordLabel = [[ProfileLabel alloc] initWithStatus:@"New Password" x:commonQuestionX y:115 myColor:[UIColor blackColor]];
    newPasswordTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonQuestionX, 140, textFieldQuestionWidth, textFieldQuestionHeight) word:@"New Password"];
    
    
    //CONFIRM NEW PASSWORD
    
    confirmPasswordLabel = [[ProfileLabel alloc] initWithStatus:@"Confirm New Password" x:commonQuestionX y:170 myColor:[UIColor blackColor] width:170];
    confirmPasswordTF = [[ProfileTextField alloc] initWithFrame:CGRectMake(commonQuestionX, 195, textFieldQuestionWidth, textFieldQuestionHeight) word:@"Confirm New Password"];
    

    [credentialsOutline addSubview:userNameLabel];
    [credentialsOutline addSubview:userNameTF];
    
    [credentialsOutline addSubview:oldPasswordLabel];
    [credentialsOutline addSubview:oldPasswordTF];
    
    [credentialsOutline addSubview:newPasswordLabel];
    [credentialsOutline addSubview:newPasswordTF];
    
    
    [credentialsOutline addSubview:confirmPasswordLabel];
    [credentialsOutline addSubview:confirmPasswordTF];
   
    
    [credentialsOutline setHidden:YES];
    [scrollView addSubview:credentialsOutline];
}

-(void) createCredentialsHeader{
    
    standbyCredentialsImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 340, 30, 30)];
    [standbyCredentialsImage setImage:[UIImage imageNamed:@"black_credentials.png"]];
    
    UILabel *credentialsLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 340, 240, 30)];
    [credentialsLabel setTextColor:[UIColor redColor]];
    [credentialsLabel setText:@"Edit my user credentials"];
    
    
    UIControl *checkCredentialsControl = [[UIControl alloc] initWithFrame:standbyCredentialsImage.frame];
    
    [checkCredentialsControl addTarget:self action:@selector(changeCredentials:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [scrollView addSubview:checkCredentialsControl];
    [scrollView addSubview: standbyCredentialsImage];
    [scrollView addSubview:credentialsLabel];

}



#pragma mark - OTHER FUNCTIONS

-(void)show:(id)sender{
    
    
    
    if(sender == button1)
    {
        questionDialog = [[SelectQuestionDialog alloc] initWithFrame:CGRectMake(0, 0, 320, 500) stringArray:questions1];
        [disableBackground setHidden:NO];
        [self.view addSubview:questionDialog];
        [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion1:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    else if(sender == button2)
    {
        questionDialog = [[SelectQuestionDialog alloc] initWithFrame:CGRectMake(0, 0, 320, 500) stringArray:questions2];
        [disableBackground setHidden:NO];
        [self.view addSubview:questionDialog];
        [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion2:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        questionDialog = [[SelectQuestionDialog alloc] initWithFrame:CGRectMake(0, 0, 320, 500) stringArray:questions3];
        [disableBackground setHidden:NO];
        [self.view addSubview:questionDialog];
        [questionDialog.button addTarget:self action:@selector(finishSelectingQuestion3:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
}

-(void) changeCredentials:(id)sender
{
    if(standbyCredentialsImage.image == [UIImage imageNamed:@"black_credentials.png"])
    {
        [standbyCredentialsImage setImage:[UIImage imageNamed:@"black_check_credentials.png"]];
        [credentialsOutline setHidden:NO];
        [scrollView setContentSize:CGSizeMake(320, 720)];

    }
    
    else
    {
        [standbyCredentialsImage setImage:[UIImage imageNamed:@"black_credentials.png"]];
        [credentialsOutline setHidden:YES];
        [scrollView setContentSize:CGSizeMake(320, 300)];
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








#pragma mark - Create - Navigation

-(void) addNavigationBarButton {
    
    //LEFT NAVIGATION BUTTON
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [backButton setImage:[UIImage imageNamed:@"back_profile.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    
    UIBarButtonItem *backNavButton = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [backNavButton setStyle:UIBarButtonItemStyleBordered];
    
    
    
    
    
    
    //    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextPressed:)];
    
    
    //RIGHT NAVIGATION BUTTON
    UIView *goView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *goButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [goButton setImage:[UIImage imageNamed:@"submit_profile.png"] forState:UIControlStateNormal];
//    [goButton addTarget:self action:@selector(nextPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [goView addSubview:goButton];
    
    UIBarButtonItem *goNavButton = [[UIBarButtonItem alloc] initWithCustomView:goView];
    [goNavButton setStyle:UIBarButtonItemStyleBordered];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationItem setRightBarButtonItem:goNavButton];
    [self.navigationItem setLeftBarButtonItem:backNavButton];
    
}

-(void)backPressed:(id)sender{
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}



- (BOOL)prefersStatusBarHidden{
    return YES;
}



@end
