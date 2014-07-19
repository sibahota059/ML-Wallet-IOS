//
//  NSDictionary+LoadWalletData.m
//  ML Wallet
//
//  Created by ml on 7/19/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "NSDictionary+LoadWalletData.h"

@implementation NSDictionary (LoadWalletData)

#pragma mark Read Data
+ (NSDictionary *) initRead_LoadWallet_Data
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"VAlue%@", dic);
    
    return dic;
}

@end
