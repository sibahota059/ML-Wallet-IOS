//
//  ProfileOutline.m
//  Account
//
//  Created by mm20-18 on 3/4/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "ProfileOutline.h"

@implementation ProfileOutline

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, (frame.size.width - 4), (frame.size.height - 4))];
        [innerView setBackgroundColor:[UIColor whiteColor]];
        
        [self setBackgroundColor:[UIColor redColor]];
        [self addSubview:innerView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, (frame.size.width - 2), (frame.size.height - 2))];
        [innerView setBackgroundColor:[UIColor whiteColor]];
        
        [self setBackgroundColor:color];
        [self addSubview:innerView];
    }
    return self;
}





- (id)initWithFrame:(CGRect)frame color:(UIColor *)color word:(NSString *)word
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (frame.size.width - 2), (frame.size.height - 2))];
    [label setText:word];
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, (frame.size.width - 2), (frame.size.height - 1))];
        [innerView setBackgroundColor:[UIColor whiteColor]];
        [innerView addSubview:label];
        
        [self setBackgroundColor:color];
        [self addSubview:innerView];
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
