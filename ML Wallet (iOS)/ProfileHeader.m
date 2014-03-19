//
//  ProfileHeader.m
//  Account
//
//  Created by mm20-18 on 3/4/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "ProfileHeader.h"

@implementation ProfileHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initWithValue:(NSString *) word x:(int)x y:(int)y width:(int)width
{
    self = [super initWithFrame:CGRectMake(x, y, width, 20)];
    if(self)
    {
        [self setText:word];
        [self setTextColor:[UIColor redColor]];
        [self setBackgroundColor:[UIColor whiteColor]];
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
