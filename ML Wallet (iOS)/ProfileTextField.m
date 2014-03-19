//
//  ProfileTextField.m
//  Account
//
//  Created by mm20-18 on 3/8/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "ProfileTextField.h"

@implementation ProfileTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame word:(NSString *)word
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setPlaceholder:word];
        [self setBorderStyle:UITextBorderStyleRoundedRect];
        
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame word:(NSString *)word viewController:(id )viewController
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setPlaceholder:word];
        [self setBorderStyle:UITextBorderStyleRoundedRect];
        self.delegate = viewController;

    }
    return self;
}


// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return  YES;
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
