//
//  ProfileButton.m
//  Account
//
//  Created by mm20-18 on 3/10/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "ProfileButton.h"

@implementation ProfileButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       
        // Initialization code
    }
    return self;
}



- (id)initWithString:(NSString *)word x:(int)x y:(int)y
{
    self = [super initWithFrame:CGRectMake(x, y, 30, 30)];
        if (self) {
            
        [self setTitle:word forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor redColor]];
        
        // Initialization code
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
