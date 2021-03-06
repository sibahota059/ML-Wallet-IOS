//
//  AppDelegate.m
//  ML Wallet (iOS)
//
//  Created by ml on 2/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import <GoogleMaps/GoogleMaps.h>
#import "TimerUIApplication.h"
#import "UIAlertView+alertMe.h"

#define UIColorFromR(rbValue) [UIColor colorWithRed:((float)((rbValue & 0xFF0000) >> 16))/255.0 green:((float)((rbValue & 0xFF00) >> 8))/255.0 blue:((float)(rbValue & 0xFF))/255.0 alpha:2.0]


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    
    [GMSServices provideAPIKey:@"AIzaSyDNYjJnFbOBJWmJMaXwLvX8Um4jk3p1F1A"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];    
    
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil navigationHidden:YES ];

    self.viewController = loginViewController;
    
    self.navigationController=[[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    CGFloat navTitleTextSize;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        navTitleTextSize = 16.0;
    }
    else {
        navTitleTextSize = 22.0;
    }
    
    //Shadow for title
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = UIColorFromR(0x323232);
    shadow.shadowOffset = CGSizeMake(0, 1);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, shadow, NSShadowAttributeName, [UIFont fontWithName:@"Arial" size:navTitleTextSize], NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = dic;
    
    
    //Background and Buttons
    [[UINavigationBar appearance] setTintColor:UIColorFromR(0x6B6B6B)]; //header_navi.png
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"header_bg2.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.window.rootViewController =self.navigationController;
    [self.window makeKeyAndVisible];
    
    //Timeout Code
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidTimeout:) name:kApplicationDidTimeoutNotification object:nil];

    return YES;
}

//Timeout Selector
-(void)applicationDidTimeout:(NSNotification *) notif
{
    if (self.isShowing) {
        return;
    } else {
    //goto Timeout
    NSLog (@"time exceeded!!");
    if (self.viewController.isViewLoaded && self.viewController.view.window)
    {} else {
        [UIAlertView myCostumeAlert:@"Timeout" alertMessage:@"You are redirected to login." delegate:nil cancelButton:@"Ok" otherButtons:nil];
        [self.navigationController removeFromParentViewController];
        [self.navigationController popToRootViewControllerAnimated:YES];
        self.navigationController.navigationBarHidden =YES;
    }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"GOing background");
    [self.navigationController.view endEditing:YES];
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
