//
//  ProfileLabel.m
//  Account
//
//  Created by mm20-18 on 3/4/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "ProfileLabel.h"
#import "ProfileOutline.h"

@implementation ProfileLabel

int labelWidth = 100;
int labelHeight = 20;

int labelWidthValue = 280;
int labelHeightValue = 20;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initWithStatus:(NSString *) word_par x:(int)x y:(int)y{

    self = [super initWithFrame:CGRectMake(x, y, labelWidth, labelHeight)];
    if(self)
    {
        [self setText:word_par];
        [self setTextColor:[UIColor grayColor]];
        self.textAlignment = NSTextAlignmentLeft;
        [self setFont:[UIFont fontWithName:@"Helvetica" size:14]];
//        [self setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    return self;
    
}

-(id) initWithStatus:(NSString *) word_par x:(int)x y:(int)y myColor:(UIColor *)myColor{
    
    self = [super initWithFrame:CGRectMake(x, (y + 5), labelWidth, labelHeight)];
    if(self)
    {
        [self setText:word_par];
        [self setTextColor:myColor];
        self.textAlignment = NSTextAlignmentLeft;
        [self setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        //        [self setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    return self;
    
}

-(id) initWithStatus:(NSString *) word_par x:(int)x y:(int)y myColor:(UIColor *)myColor width:(int)width{
    
    self = [super initWithFrame:CGRectMake(x, (y + 5), width, labelHeight)];
    if(self)
    {
        [self setText:word_par];
        [self setTextColor:myColor];
        self.textAlignment = NSTextAlignmentLeft;
        [self setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        //        [self setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    return self;
    
}













-(id) initWithStatus:(NSString *) word_par x:(int)x y:(int)y width:(int) width{
    
    self = [super initWithFrame:CGRectMake(x, y, width, labelHeight)];
    if(self)
    {
        [self setText:word_par];
        [self setTextColor:[UIColor grayColor]];
        self.textAlignment = NSTextAlignmentLeft;
        [self setFont:[UIFont fontWithName:@"Helvetica" size:14]];
//             [self setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    return self;
    
}


-(id) initWithStatusValue:(NSString *) word_par x:(int)x y:(int)y{
    
    self = [super initWithFrame:CGRectMake(x, y, labelWidthValue, labelHeightValue)];
    if(self)
    {
        [self setText:word_par];
        [self setTextColor:[UIColor blackColor]];
        
//        [self setBackgroundColor:[UIColor redColor]];
        self.textAlignment = NSTextAlignmentCenter;
        [self setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    }
    
    return self;
    
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
