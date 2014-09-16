//
//  SelectQuestionDialogPad.m
//  ML Wallet
//
//  Created by mm20-18 on 8/5/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "SelectQuestionDialogPad.h"

@implementation SelectQuestionDialogPad
@synthesize button;

@synthesize qButtonPad1;
@synthesize qButtonPad2;
@synthesize qButtonPad3;
@synthesize qButtonPad4;
@synthesize qButtonPad5;

UIImageView *qImage1, *qImage2, *qImage3, *qImage4, *qImage5;

NSString *winnerQuestion;
NSArray *questions;

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

        UIView *questionView = [[UIView alloc] initWithFrame:CGRectMake(244, 135, 280, 350)];
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
//        [qLabel1 setText:questions[0]];
        
        qButtonPad1 = [UIButton buttonWithType:UIButtonTypeCustom];
        qButtonPad1.frame = CGRectMake(40, 50, 230, 30);
        qButtonPad1.titleLabel.font = [UIFont fontWithName: @"Helvetica" size:14];
        qButtonPad1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [qButtonPad1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qButtonPad1 setTitle:questions[0] forState:UIControlStateNormal];
        [qButtonPad1 addTarget:self action:@selector(radioButtonSelected1:) forControlEvents:UIControlEventTouchUpInside];
        
        //QUESTION 2
        qImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 100, 30, 30)];
        [qImage2 setImage:[UIImage imageNamed:@"radio_button.png"]];
        
        UIControl *mask2 = [[UIControl alloc] initWithFrame:qImage2.frame];
        [mask2 addTarget:self action:@selector(radioButtonSelected2:) forControlEvents:UIControlEventTouchUpInside];
        
        qButtonPad2 = [UIButton buttonWithType:UIButtonTypeCustom];
        qButtonPad2.frame = CGRectMake(40, 100, 230, 30);
        qButtonPad2.titleLabel.font = [UIFont fontWithName: @"Helvetica" size:14];
        qButtonPad2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [qButtonPad2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qButtonPad2 setTitle:questions[1] forState:UIControlStateNormal];
        [qButtonPad2 addTarget:self action:@selector(radioButtonSelected2:) forControlEvents:UIControlEventTouchUpInside];
        
        //QUESTION 3
        qImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 150, 30, 30)];
        [qImage3 setImage:[UIImage imageNamed:@"radio_button.png"]];
        
        UIControl *mask3 = [[UIControl alloc] initWithFrame:qImage3.frame];
        [mask3 addTarget:self action:@selector(radioButtonSelected3:) forControlEvents:UIControlEventTouchUpInside];
        
        qButtonPad3 = [UIButton buttonWithType:UIButtonTypeCustom];
        qButtonPad3.frame = CGRectMake(40, 150, 230, 30);
        qButtonPad3.titleLabel.font = [UIFont fontWithName: @"Helvetica" size:14];
        qButtonPad3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [qButtonPad3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qButtonPad3 setTitle:questions[2] forState:UIControlStateNormal];
        [qButtonPad3 addTarget:self action:@selector(radioButtonSelected3:) forControlEvents:UIControlEventTouchUpInside];
        
        //QUESTION 4
        qImage4 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 200, 30, 30)];
        [qImage4 setImage:[UIImage imageNamed:@"radio_button.png"]];
        
        UIControl *mask4 = [[UIControl alloc] initWithFrame:qImage4.frame];
        [mask4 addTarget:self action:@selector(radioButtonSelected4:) forControlEvents:UIControlEventTouchUpInside];
        
        qButtonPad4 = [UIButton buttonWithType:UIButtonTypeCustom];
        qButtonPad4.frame = CGRectMake(40, 200, 230, 30);
        qButtonPad4.titleLabel.font = [UIFont fontWithName: @"Helvetica" size:14];
        qButtonPad4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [qButtonPad4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qButtonPad4 setTitle:questions[3] forState:UIControlStateNormal];
        [qButtonPad4 addTarget:self action:@selector(radioButtonSelected4:) forControlEvents:UIControlEventTouchUpInside];
        
        //QUESTION 5
        qImage5 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 250, 30, 30)];
        [qImage5 setImage:[UIImage imageNamed:@"radio_button.png"]];
        
        UIControl *mask5 = [[UIControl alloc] initWithFrame:qImage5.frame];
        [mask5 addTarget:self action:@selector(radioButtonSelected5:) forControlEvents:UIControlEventTouchUpInside];
        
        qButtonPad5 = [UIButton buttonWithType:UIButtonTypeCustom];
        qButtonPad5.frame = CGRectMake(40, 250, 230, 30);
        qButtonPad5.titleLabel.font = [UIFont fontWithName: @"Helvetica" size:14];
        qButtonPad5.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [qButtonPad5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qButtonPad5 setTitle:questions[4] forState:UIControlStateNormal];
        [qButtonPad5 addTarget:self action:@selector(radioButtonSelected5:) forControlEvents:UIControlEventTouchUpInside];
        
        button = [[UIButton alloc] initWithFrame:CGRectMake(80, 300, 100, 30)];
        [button setTitle:@"Ok" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor redColor]];
   
        [questionView addSubview:questionHeader];
        
        [questionView addSubview:qImage1];
        [questionView addSubview:qButtonPad1];
        [questionView addSubview:mask1];
        
        [questionView addSubview:qImage2];
        [questionView addSubview:qButtonPad2];
        [questionView addSubview:mask2];
        
        [questionView addSubview:qImage3];
        [questionView addSubview:qButtonPad3];
        [questionView addSubview:mask3];
        
        [questionView addSubview:qImage4];
        [questionView addSubview:qButtonPad4];
        [questionView addSubview:mask4];
        
        [questionView addSubview:qImage5];
        [questionView addSubview:qButtonPad5];
        [questionView addSubview:mask5];
        
        [questionView addSubview:button];
        
        
        

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
        winnerQuestion = [[qButtonPad1 titleLabel] text];
        
    }
    else if(image == qImage2)
    {
        [qImage2 setImage:[UIImage imageNamed:@"radio_button_selected.png"]];
        winnerQuestion = [[qButtonPad2 titleLabel] text];
    }
    else if(image == qImage3)
    {
        [qImage3 setImage:[UIImage imageNamed:@"radio_button_selected.png"]];
        winnerQuestion = [[qButtonPad3 titleLabel] text];
    }
    else if(image == qImage4)
    {
        [qImage4 setImage:[UIImage imageNamed:@"radio_button_selected.png"]];
        winnerQuestion = [[qButtonPad4 titleLabel] text];
    }
    else if (image == qImage5)
    {
        [qImage5 setImage:[UIImage imageNamed:@"radio_button_selected.png"]];
        winnerQuestion = [[qButtonPad5 titleLabel] text];
    }
    
}

-(NSString *) getSelectedQuestion{
    
       return winnerQuestion;
}



@end
