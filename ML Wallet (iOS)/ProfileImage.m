//
//  ProfileImage.m
//  Account
//
//  Created by mm20-18 on 3/4/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "ProfileImage.h"

@implementation ProfileImage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id) initWithProfileImage:(UIImage *)image x:(int)x y:(int)y{


    self = [super initWithFrame:CGRectMake(x, y, 104, 104)];
    
    if(self)
    {
        UIImageView *profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 100, 100)];
        [profileImage setImage:image];
        
        
        [self setBackgroundColor:[UIColor redColor]];
        [self addSubview:profileImage];
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
