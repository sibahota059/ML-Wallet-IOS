//
//  MLRatesSwipeViewController.m
//  ML Wallet
//
//  Created by ml on 11/26/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "MLRatesSwipeViewController.h"
#import "MLRatesAllChildViewController.h"
#import "MLUI.h"
#import "MenuViewController.h"

@interface MLRatesSwipeViewController ()

@end

@implementation MLRatesSwipeViewController{
    UIBarButtonItem *home;
    MLUI *getUI;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    getUI = [MLUI new];
    //customize the icon for back button and call the btn_back method
    home = [getUI navBarButtonRateAll:self navLink:@selector(btn_back:) imageNamed:@"home.png"];
    
    
    
    if ([_indicator isEqualToString:@"login"] || [_indicator isEqualToString:@"menu"])
    {
        
        self.navigationItem.title = @"MLKP RATES";
        [self.navigationItem setLeftBarButtonItem:home];
        self.navigationItem.rightBarButtonItem = nil;
        
    }else{
        
        self.tabBarController.navigationItem.title = @"MLKP RATES";
        [self.tabBarController.navigationItem setLeftBarButtonItem:home];
        self.tabBarController.navigationItem.rightBarButtonItem = nil;
        
    }
    
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    MLRatesAllChildViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
}

#pragma mark - Back Button
- (IBAction)btn_back:(id)sender {
    
    NSLog(@"%@", _indicator);
    if ([_indicator isEqualToString:@"login"])
    {
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        self.navigationController.navigationBarHidden = YES;
        MenuViewController *smv = (MenuViewController *)[self.navigationController.viewControllers objectAtIndex:1];
        [self.navigationController popToViewController:smv animated:YES];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (MLRatesAllChildViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    MLRatesAllChildViewController *childViewController = [[MLRatesAllChildViewController alloc] initWithNibName:@"MLRatesAllChildViewController" bundle:nil];
    childViewController.index = index;
    
    return childViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    
    NSUInteger index = [(MLRatesAllChildViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(MLRatesAllChildViewController *)viewController index];
    
    index++;
    
    if (index == 2) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

@end
