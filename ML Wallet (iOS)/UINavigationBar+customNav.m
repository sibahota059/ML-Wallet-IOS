//
//  UINavigationBar+customNav.m
//  SendMoney
//
//  Created by mm20 on 3/24/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import "UINavigationBar+customNav.h"

@implementation UINavigationBar (customNav)

- (CGSize)sizeThatFits:(CGSize)size{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGSize newSize;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        newSize = CGSizeMake(screenWidth, 100);
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        newSize = CGSizeMake(screenWidth, 130);
    }
    
    //CGFloat screenHeight = screenRect.size.height;
    
    
    return newSize;
}

@end
