//
//  SelectQuestionDialog.m
//  Account
//
//  Created by mm20-18 on 3/10/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "SelectQuestionDialog.h"

@implementation SelectQuestionDialog
@synthesize button;

UIImageView *qImage1, *qImage2, *qImage3, *qImage4, *qImage5;
UILabel *qLabel1, *qLabel2, *qLabel3, *qLabel4, *qLabel5;
UIButton *qButton1, *qButton2, *qButton3, *qButton4, *qButton5;
NSArray *questions;
NSString *winnerQuestion;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame stringArray:(NSArray *)stringArray
{
    winnerQuestion = [[NSString alloc] init];
    questions = stringArray;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        
        UIView *questionView = [[UIView alloc] initWithFrame:CGRectMake(20, 40, 280, 350)];
        [questionView setBackgroundColor:[UIColor whiteColor]];
        
        
        UILabel *questionHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 40)];
        [questionHeader setBackgroundColor:[UIColor blackColor]];
        [questionHeader setTextColor:[UIColor whiteColor]];
        [questionHeader setText:@" Choose a question"];
        
        //QUESTION 1
        qImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 50, 30, 30)];
        [qImage1 setImage:[UIImage imageNamed:@"radio_button.png"]];
        
        UIControl *mask1 = [[UIControl alloc] initWithFrame:qImage1.frame];
        [mask1 addTarget:self action:@selector(radioButtonSelected1:) forControlEvents:UIControlEventTouchUpInside];
        
//        qLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 50, 220, 30)];
//        [qLabel1 setFont:[UIFont fontWithName:@"Helvetica" size:14]];
//        [qLabel1 setText:questions[0]]; button type UIButtonTypeRoundedRect
        
        qButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        qButton1.frame = CGRectMake(40, 50, 300, 30);
        //question1.titleLabel.font = [UIFont systemFontOfSize:24.0f]; UIFont
        qButton1.titleLabel.font = [UIFont fontWithName: @"Helvetica" size:14];
        qButton1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [qButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qButton1 setTitle:questions[0] forState:UIControlStateNormal];
        [qButton1 addTarget:self action:@selector(radioButtonSelected1:) forControlEvents:UIControlEventTouchUpInside];
        
        //QUESTION 2
        qImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 100, 30, 30)];
        [qImage2 setImage:[UIImage imageNamed:@"radio_button.png"]];
        
        UIControl *mask2 = [[UIControl alloc] initWithFrame:qImage2.frame];
        [mask2 addTarget:self action:@selector(radioButtonSelected2:) forControlEvents:UIControlEventTouchUpInside];
        
        
//        qLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 220, 30)];
//        [qLabel2 setFont:[UIFont fontWithName:@"Helvetica" size:14]];
//        [qLabel2 setText:questions[1]];

        qButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        qButton2.frame = CGRectMake(40, 100, 300, 30);
        //question1.titleLabel.font = [UIFont systemFontOfSize:24.0f];
        qButton2.titleLabel.font = [UIFont fontWithName: @"Helvetica" size:14];
        qButton2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [qButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qButton2 setTitle:questions[1] forState:UIControlStateNormal];
        [qButton2 addTarget:self action:@selector(radioButtonSelected2:) forControlEvents:UIControlEventTouchUpInside];
        
        //QUESTION 3
        qImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 150, 30, 30)];
        [qImage3 setImage:[UIImage imageNamed:@"radio_button.png"]];
        
        UIControl *mask3 = [[UIControl alloc] initWithFrame:qImage3.frame];
        [mask3 addTarget:self action:@selector(radioButtonSelected3:) forControlEvents:UIControlEventTouchUpInside];
        
//        qLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(40, 150, 220, 30)];
//        [qLabel3 setFont:[UIFont fontWithName:@"Helvetica" size:14]];
//        [qLabel3 setText:questions[2]];

        qButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
        qButton3.frame = CGRectMake(40, 150, 300, 30);
        qButton3.titleLabel.font = [UIFont fontWithName: @"Helvetica" size:14];
        qButton3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [qButton3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qButton3 setTitle:questions[2] forState:UIControlStateNormal];
        [qButton3 addTarget:self action:@selector(radioButtonSelected3:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //QUESTION 4
        qImage4 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 200, 30, 30)];
        [qImage4 setImage:[UIImage imageNamed:@"radio_button.png"]];
        
        UIControl *mask4 = [[UIControl alloc] initWithFrame:qImage4.frame];
        [mask4 addTarget:self action:@selector(radioButtonSelected4:) forControlEvents:UIControlEventTouchUpInside];
        
//        qLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(40, 200, 220, 30)];
//        [qLabel4 setFont:[UIFont fontWithName:@"Helvetica" size:14]];
//        [qLabel4 setText:questions[3]];

        qButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
        qButton4.frame = CGRectMake(40, 200, 300, 30);
        qButton4.titleLabel.font = [UIFont fontWithName: @"Helvetica" size:14];
        qButton4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [qButton4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qButton4 setTitle:questions[3] forState:UIControlStateNormal];
        [qButton4 addTarget:self action:@selector(radioButtonSelected4:) forControlEvents:UIControlEventTouchUpInside];
        
        //QUESTION 5
        qImage5 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 250, 30, 30)];
        [qImage5 setImage:[UIImage imageNamed:@"radio_button.png"]];
        
        UIControl *mask5 = [[UIControl alloc] initWithFrame:qImage5.frame];
        [mask5 addTarget:self action:@selector(radioButtonSelected5:) forControlEvents:UIControlEventTouchUpInside];
        
        
//        qLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(40, 250, 220, 30)];
//        [qLabel5 setFont:[UIFont fontWithName:@"Helvetica" size:14]];
//        [qLabel5 setText:questions[4]];

        qButton5 = [UIButton buttonWithType:UIButtonTypeCustom];
        qButton5.frame = CGRectMake(40, 250, 300, 30);
        qButton5.titleLabel.font = [UIFont fontWithName: @"Helvetica" size:14];
        qButton5.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [qButton5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qButton5 setTitle:questions[4] forState:UIControlStateNormal];
        [qButton5 addTarget:self action:@selector(radioButtonSelected5:) forControlEvents:UIControlEventTouchUpInside];
        
        
        button = [[UIButton alloc] initWithFrame:CGRectMake(80, 300, 100, 30)];
        [button setTitle:@"Ok" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor redColor]];
       
        
        [questionView addSubview:questionHeader];
        
        
        [questionView addSubview:qImage1];
        [questionView addSubview:qButton1];
        [questionView addSubview:mask1];
        
        [questionView addSubview:qImage2];
        [questionView addSubview:qButton2];
        [questionView addSubview:mask2];
        
        [questionView addSubview:qImage3];
        [questionView addSubview:qButton3];
        [questionView addSubview:mask3];
        
        [questionView addSubview:qImage4];
        [questionView addSubview:qButton4];
        [questionView addSubview:mask4];
        
        [questionView addSubview:qImage5];
        [questionView addSubview:qButton5];
        
        [questionView addSubview:button];
        [questionView addSubview:mask5];
        
        [self addSubview:questionView];
        
    }
    
    
    return self;
}



-(void) radioButtonSelected1:(id)sender{
    
    [self questionSelected:qImage1];
    
}

-(void) radioButtonSelected2:(id)sender{
    [self questionSelected:qImage2];
}

-(void) radioButtonSelected3:(id)sender{
    [self questionSelected:qImage3];
}

-(void) radioButtonSelected4:(id)sender{
    [self questionSelected:qImage4];
}

-(void) radioButtonSelected5:(id)sender{
    [self questionSelected:qImage5];
}





-(void) questionSelected:(UIImageView *)image{
    
    
    [qImage1 setImage:[UIImage imageNamed:@"radio_button.png"]];
    [qImage2 setImage:[UIImage imageNamed:@"radio_button.png"]];
    [qImage3 setImage:[UIImage imageNamed:@"radio_button.png"]];
    [qImage4 setImage:[UIImage imageNamed:@"radio_button.png"]];
    [qImage5 setImage:[UIImage imageNamed:@"radio_button.png"]];
    
    
    if (image == qImage1)
    {
        [qImage1 setImage:[UIImage imageNamed:@"radio_button_selected.png"]];
        winnerQuestion = [[qButton1 titleLabel] text];
        
    }
    else if(image == qImage2)
    {
        [qImage2 setImage:[UIImage imageNamed:@"radio_button_selected.png"]];
        winnerQuestion = [[qButton2 titleLabel] text];
    }
    else if(image == qImage3)
    {
        [qImage3 setImage:[UIImage imageNamed:@"radio_button_selected.png"]];
        winnerQuestion = [[qButton3 titleLabel] text];
    }
    else if(image == qImage4)
    {
        [qImage4 setImage:[UIImage imageNamed:@"radio_button_selected.png"]];
        winnerQuestion = [[qButton4 titleLabel] text];
    }
    else if (image == qImage5)
    {
        [qImage5 setImage:[UIImage imageNamed:@"radio_button_selected.png"]];
        winnerQuestion = [[qButton5 titleLabel] text];
    }

}

-(NSString *) getSelectedQuestion{
    
    if([winnerQuestion isEqualToString:@""]){
    winnerQuestion = @"Please select a question.";
    }
    return winnerQuestion;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
