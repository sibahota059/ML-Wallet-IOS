//
//  MLViewController.h
//  Registration
//
//  Created by mm20-18 on 3/11/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLViewController : UIViewController

@property (strong, nonatomic) UIBarButtonItem *nextNavButton;
@property (strong, nonatomic) MLViewController *nextViewController;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  viewController:(MLViewController *) viewController;

-(void) setNextViewController:(MLViewController *)nextViewControllerParameter myImage:(UIImage *)myImage;

@end
