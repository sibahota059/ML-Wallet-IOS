//
//  QuestionVerificationDialog.m
//  Account
//
//  Created by mm20-18 on 3/7/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "QuestionVerificationDialog.h"
#import "UpdateInformation.h"

@implementation QuestionVerificationDialog

@synthesize updateButton;
@synthesize dialog;


@synthesize question1;
@synthesize question2;
@synthesize question3;
@synthesize finalQuestion;
@synthesize finalAnswer;

@synthesize answer;


UIImageView *radioButtonImage1;
UIImageView *radioButtonImage2;
UIImageView *radioButtonImage3;

UILabel *selectedQuestion;
UIView *dialogBackground;
UIView *dimLight;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}



-(void) someMethod1:(id)sender{
    finalQuestion = question1;
    [self updateEditView:radioButtonImage1];
    
}

-(void) someMethod2:(id)sender{
    
    finalQuestion = question2;
    [self updateEditView:radioButtonImage2];
    
}

-(void) someMethod3:(id)sender{
    
    finalQuestion = question3;
    [self updateEditView:radioButtonImage3];
    
}

-(void)updateEditView:(UIImageView *) radioImage{
    
    
    if(radioImage == radioButtonImage1)
    {
        
        [radioButtonImage1 setImage:[UIImage imageNamed:@"radio_button_selected.png"]];
        [radioButtonImage2 setImage:[UIImage imageNamed:@"radio_button.png"]];
        [radioButtonImage3 setImage:[UIImage imageNamed:@"radio_button.png"]];
        selectedQuestion.text = question1;
        
    }
    else if(radioImage == radioButtonImage2)
    {
        
        [radioButtonImage1 setImage:[UIImage imageNamed:@"radio_button.png"]];
        [radioButtonImage2 setImage:[UIImage imageNamed:@"radio_button_selected.png"]];
        [radioButtonImage3 setImage:[UIImage imageNamed:@"radio_button.png"]];
        selectedQuestion.text = question2;
    }
    else
    {
        
        [radioButtonImage1 setImage:[UIImage imageNamed:@"radio_button.png"]];
        [radioButtonImage2 setImage:[UIImage imageNamed:@"radio_button.png"]];
        [radioButtonImage3 setImage:[UIImage imageNamed:@"radio_button_selected.png"]];
        selectedQuestion.text = question3;
    }
    
}


- (id)initWithFrame:(CGRect)frame addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents) events {

    dimLight = [[UIView alloc] initWithFrame:CGRectMake(0, -35, 320, 1500)];
    [dimLight setBackgroundColor:[UIColor blackColor]];
    [dimLight setOpaque:YES];
    [dimLight setAlpha:0.5f];

    // CGRectMake(20, 30, 280, 300)
    
    dialogBackground = [[UIView alloc] initWithFrame:CGRectMake(18, 28, 284, 304)];
    [dialogBackground setBackgroundColor:[UIColor whiteColor]];
    
    dialog = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 280, 300)];

    
    //HEADER
    
    //SELECTED QUESTION
    UIView *headerBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 32)];
    [headerBackground setBackgroundColor:[UIColor whiteColor]];

    
    UILabel *questionHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
    [questionHeader setText:@"Answer 1 question to proceed"];
    [questionHeader setTextColor:[UIColor whiteColor]];
    [questionHeader setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    questionHeader.textAlignment = NSTextAlignmentCenter;
    [questionHeader setBackgroundColor:[UIColor blackColor]];
    
    [headerBackground addSubview:questionHeader];
    

    //RADIOBUTTON AND QUESTION
    radioButtonImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 40, 30, 30)];
    [radioButtonImage1 setImage:[UIImage imageNamed:@"radio_button.png"]];
    
    UILabel *questionLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(110, 40, 100, 30)];
    [questionLabel1 setText:@"Question 1"];
    [questionLabel1 setTextColor:[UIColor whiteColor]];
    
    
    
    radioButtonImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 80, 30, 30)];
    [radioButtonImage2 setImage:[UIImage imageNamed:@"radio_button.png"]];
    
    UILabel *questionLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(110, 80, 100, 30)];
    [questionLabel2 setText:@"Question 2"];
    [questionLabel2 setTextColor:[UIColor whiteColor]];
    
    
    radioButtonImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 120, 30, 30)];
    [radioButtonImage3 setImage:[UIImage imageNamed:@"radio_button.png"]];
    
    UILabel *questionLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(110, 120, 100, 30)];
    [questionLabel3 setText:@"Question 3"];
    [questionLabel3 setTextColor:[UIColor whiteColor]];
    
    
    
    //SELECTED QUESTION
    UIView *selectionBackground = [[UIView alloc] initWithFrame:CGRectMake(5, 160, 270, 30)];
    [selectionBackground setBackgroundColor:[UIColor whiteColor]];
    
    selectedQuestion = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 268, 28)];
    [selectedQuestion setText:@"Place your answer below"];
    [selectedQuestion setTextColor:[UIColor redColor]];
    selectedQuestion.textAlignment = NSTextAlignmentCenter;
    [selectedQuestion setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [selectedQuestion setBackgroundColor:[UIColor blackColor]];
    
    [selectionBackground addSubview:selectedQuestion];
    
    
    
    
    
    //ANSWER
    answer = [[UITextField alloc] initWithFrame:CGRectMake(15, 200, 250, 30)];
    [answer setBackgroundColor:[UIColor whiteColor]];
    [answer setBorderStyle:UITextBorderStyleRoundedRect];
    [answer setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [answer setPlaceholder:@" Enter your answer..."];
    
    
    
    //CONFIRM BUTTON
    updateButton = [[UIButton alloc] initWithFrame:CGRectMake(80, 245, 120, 40)];
    
    [updateButton setBackgroundColor:[UIColor redColor]];
    [updateButton setTitle:@"Confirm" forState:UIControlStateNormal];
    [updateButton setTintColor:[UIColor whiteColor]];
    [updateButton addTarget:target action:selector forControlEvents:events];
    updateButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    
    
    UIControl *mask1 = [[UIControl alloc] initWithFrame:radioButtonImage1.frame];
    [mask1 addTarget:self action:@selector(someMethod1:) forControlEvents:UIControlEventTouchUpInside];
    
    UIControl *mask2 = [[UIControl alloc] initWithFrame:radioButtonImage2.frame];
    [mask2 addTarget:self action:@selector(someMethod2:) forControlEvents:UIControlEventTouchUpInside];
    
    UIControl *mask3 = [[UIControl alloc] initWithFrame:radioButtonImage3.frame];
    [mask3 addTarget:self action:@selector(someMethod3:) forControlEvents:UIControlEventTouchUpInside];
    
    [dialog setBackgroundColor:[UIColor blackColor]];
    [dialog addSubview:headerBackground];
    [dialog addSubview:mask1];
    [dialog addSubview:mask2];
    [dialog addSubview:mask3];
    
    [dialog addSubview:radioButtonImage1];
    [dialog addSubview:questionLabel1];
    [dialog addSubview:radioButtonImage2];
    [dialog addSubview:questionLabel2];
    [dialog addSubview:radioButtonImage3];
    [dialog addSubview:questionLabel3];
    
    [dialog addSubview:selectionBackground];
    [dialog addSubview:answer];
    [dialog addSubview:updateButton];

    answer.delegate = self;
    [dialogBackground addSubview:dialog];
    
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:dimLight];
        [self addSubview:dialogBackground];
        
        
    }
    return self;


}

- (id)initWithFrame:(CGRect)frame addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents) events addQuestion1:(NSString *)question1_par addQuestion2:(NSString *)question2_par addQuestion3:(NSString *)question3_par{
    
    //    dimLight = [[UIView alloc] initWithFrame:CGRectMake(0, 35, 768, 1500)];
    dimLight = [[UIView alloc] initWithFrame:frame];
    [dimLight setBackgroundColor:[UIColor blackColor]];
    [dimLight setOpaque:YES];
    [dimLight setAlpha:0.5f];
    
    // CGRectMake(20, 30, 280, 300)
    
    //location of dialog onCreate
    dialogBackground = [[UIView alloc] initWithFrame:CGRectMake(18, 28, 284, 304)];
    [dialogBackground setBackgroundColor:[UIColor whiteColor]];
    
    dialog = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 280, 300)];
    
    
    
    question1 = question1_par;
    question2 = question2_par;
    question3 = question3_par;
    
    //HEADER
    
    //SELECTED QUESTION
    UIView *headerBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 32)];
    [headerBackground setBackgroundColor:[UIColor whiteColor]];
    
    
    UILabel *questionHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
    [questionHeader setText:@"Answer 1 question to proceed"];
    [questionHeader setTextColor:[UIColor whiteColor]];
    [questionHeader setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    questionHeader.textAlignment = NSTextAlignmentCenter;
    [questionHeader setBackgroundColor:[UIColor blackColor]];
    
    [headerBackground addSubview:questionHeader];
    
    
    //RADIOBUTTON AND QUESTION
    radioButtonImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 40, 30, 30)];
    [radioButtonImage1 setImage:[UIImage imageNamed:@"radio_button.png"]];
    
    UILabel *questionLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(110, 40, 100, 30)];
    [questionLabel1 setText:@"Question 1"];
    [questionLabel1 setTextColor:[UIColor whiteColor]];
    
    
    
    radioButtonImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 80, 30, 30)];
    [radioButtonImage2 setImage:[UIImage imageNamed:@"radio_button.png"]];
    
    UILabel *questionLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(110, 80, 100, 30)];
    [questionLabel2 setText:@"Question 2"];
    [questionLabel2 setTextColor:[UIColor whiteColor]];
    
    
    radioButtonImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 120, 30, 30)];
    [radioButtonImage3 setImage:[UIImage imageNamed:@"radio_button.png"]];
    
    UILabel *questionLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(110, 120, 100, 30)];
    [questionLabel3 setText:@"Question 3"];
    [questionLabel3 setTextColor:[UIColor whiteColor]];
    
    
    
    //SELECTED QUESTION
    UIView *selectionBackground = [[UIView alloc] initWithFrame:CGRectMake(5, 160, 270, 30)];
    [selectionBackground setBackgroundColor:[UIColor whiteColor]];
    
    selectedQuestion = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 268, 28)];
    [selectedQuestion setText:@"Place your answer below"];
    [selectedQuestion setTextColor:[UIColor redColor]];
    selectedQuestion.textAlignment = NSTextAlignmentCenter;
    [selectedQuestion setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [selectedQuestion setBackgroundColor:[UIColor blackColor]];
    
    [selectionBackground addSubview:selectedQuestion];
    
    
    
    
    
    //ANSWER
    answer = [[UITextField alloc] initWithFrame:CGRectMake(15, 200, 250, 30)];
    [answer setBackgroundColor:[UIColor whiteColor]];
    [answer setBorderStyle:UITextBorderStyleRoundedRect];
    [answer setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [answer setPlaceholder:@" Enter your answer..."];
    
    
    
    //CONFIRM BUTTON
    updateButton = [[UIButton alloc] initWithFrame:CGRectMake(80, 245, 120, 40)];
    
    [updateButton setBackgroundColor:[UIColor redColor]];
    [updateButton setTitle:@"Confirm" forState:UIControlStateNormal];
    [updateButton setTintColor:[UIColor whiteColor]];
    [updateButton addTarget:target action:selector forControlEvents:events];
    updateButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    
    
    UIControl *mask1 = [[UIControl alloc] initWithFrame:radioButtonImage1.frame];
    [mask1 addTarget:self action:@selector(someMethod1:) forControlEvents:UIControlEventTouchUpInside];
    
    UIControl *mask2 = [[UIControl alloc] initWithFrame:radioButtonImage2.frame];
    [mask2 addTarget:self action:@selector(someMethod2:) forControlEvents:UIControlEventTouchUpInside];
    
    UIControl *mask3 = [[UIControl alloc] initWithFrame:radioButtonImage3.frame];
    [mask3 addTarget:self action:@selector(someMethod3:) forControlEvents:UIControlEventTouchUpInside];
    
    [dialog setBackgroundColor:[UIColor blackColor]];
    [dialog addSubview:headerBackground];
    [dialog addSubview:mask1];
    [dialog addSubview:mask2];
    [dialog addSubview:mask3];
    
    [dialog addSubview:radioButtonImage1];
    [dialog addSubview:questionLabel1];
    [dialog addSubview:radioButtonImage2];
    [dialog addSubview:questionLabel2];
    [dialog addSubview:radioButtonImage3];
    [dialog addSubview:questionLabel3];
    
    [dialog addSubview:selectionBackground];
    [dialog addSubview:answer];
    [dialog addSubview:updateButton];
    
    answer.delegate = self;
    [dialogBackground addSubview:dialog];
    
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:dimLight];
        [self addSubview:dialogBackground];
        
        
    }
    return self;
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{dialogBackground.frame = CGRectMake(18, -148, 284, 304); }
                     completion:^(BOOL finished){}];
    
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{dialog.frame = CGRectMake(20, -146, 280, 300); }
                     completion:^(BOOL finished){}];
    
    
    
    
    [self addSubview:dialog];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{dialogBackground.frame = CGRectMake(18, 28, 284, 304); }
                     completion:^(BOOL finished){}];
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{dialog.frame = CGRectMake(20, 30, 280, 300); }
                     completion:^(BOOL finished){}];
    
    
    [textField resignFirstResponder];
    
    return YES;

}




@end
