//
//  DimLightDialogBackground.m
//  ML Wallet
//
//  Created by mm20-18 on 12/13/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "DimLightDialogBackground.h"

@implementation DimLightDialogBackground

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(0, 0, [ [ UIScreen mainScreen ] bounds ].size.width, [ [ UIScreen mainScreen ] bounds ].size.height)];
        [self setBackgroundColor:[UIColor blackColor]];
        [self setAlpha:0.6f];    }
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
