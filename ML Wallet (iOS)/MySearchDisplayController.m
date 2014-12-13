//
//  MySearchDisplayController.m
//  ML Wallet
//
//  Created by mm20-18 on 12/12/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "MySearchDisplayController.h"

@implementation MySearchDisplayController

- (void)setActive:(BOOL)visible animated:(BOOL)animated
{
    [super setActive: visible animated: animated];
    
    [self.searchContentsController.navigationController setNavigationBarHidden: NO animated: NO];
    
    //move the dimming part down
    for (UIView *subview in self.searchContentsController.view.subviews) {
        //NSLog(@"%@", NSStringFromClass([subview class]));
        if ([subview isKindOfClass:NSClassFromString(@"UISearchDisplayControllerContainerView")])
        {
//            CGRect frame = subview.frame;
            CGRect frame = CGRectMake(20, 20, 280, 400);
            subview.frame = frame;
        }
    }
}




@end
