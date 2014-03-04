//
//  AppDelegate.m
//  ML Wallet (iOS)
//
//  Created by ml on 2/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

#define UIColorFromR(rbValue) [UIColor colorWithRed:((float)((rbValue & 0xFF0000) >> 16))/255.0 green:((float)((rbValue & 0xFF00) >> 8))/255.0 blue:((float)(rbValue & 0xFF))/255.0 alpha:2.0]

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    self.navigationController=[[UINavigationController alloc] initWithRootViewController:self.viewController];

    //Shadow for title
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = UIColorFromR(0x323232);
    shadow.shadowOffset = CGSizeMake(0, 1);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:UIColorFromR(0xe5e5e5), NSForegroundColorAttributeName, shadow, NSShadowAttributeName, [UIFont fontWithName:@"Helvetica-Bold" size:16.0], NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = dic;
    
    
    //Background and Buttons
    [[UINavigationBar appearance] setTintColor:UIColorFromR(0xFFFFFF)];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"header_navi.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.window.rootViewController =self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
