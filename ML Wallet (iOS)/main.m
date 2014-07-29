//
//  main.m
//  ML Wallet (iOS)
//
//  Created by ml on 2/17/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerUIApplication.h"

#import "AppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, NSStringFromClass([TimerUIApplication class]), NSStringFromClass([AppDelegate class]));
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
