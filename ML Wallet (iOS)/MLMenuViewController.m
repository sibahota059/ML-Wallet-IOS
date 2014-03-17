//
//  MLMenuViewController.m
//  SendMoney
//
//  Created by mm20 on 3/1/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import "MLMenuViewController.h"
#import "MLSendMoneyViewController.h"
#import "MLRatesTableViewController.h"
#import "MLUI.h"
#import "MLHistoryViewController.h"

@interface MLMenuViewController (){
    
    MLUI *getUI;
    
}

@end

@implementation MLMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    getUI = [MLUI new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSendMoney:(id)sender {
    
    UIViewController *viewController1 = [[MLSendMoneyViewController alloc] initWithNibName:@"MLSendMoneyViewController" bundle:nil];
    UITableViewController *viewController2 = [[MLRatesTableViewController alloc] initWithNibName:@"MLRatesTableViewController" bundle:nil];
    
    [getUI navigationAppearance];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, viewController2];
    
    //object to customize tabBar
    [getUI customTabBar:self.tabBarController];
    
    
    [[self navigationController] pushViewController:self.tabBarController animated:YES];
   
}

- (IBAction)btnTransaction:(id)sender {
    MLHistoryViewController *htr = [[MLHistoryViewController alloc] initWithNibName:@"MLHistoryViewController" bundle:nil];
    
    [self.navigationController pushViewController:htr animated:YES];
}
@end
