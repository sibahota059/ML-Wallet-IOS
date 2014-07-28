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
    BOOL doesExist;
    NSError *error;
    NSMutableDictionary* plistDict;
    NSString *filePath= [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path =[[NSString alloc] initWithString:[documentsDirectory stringByAppendingPathComponent:@"data.plist"]];
    
    doesExist= [fileManager fileExistsAtPath:path];
    
    if (doesExist) {
        plistDict=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    }
    else
    {
        
        doesExist= [fileManager copyItemAtPath:filePath  toPath:path error:&error];
        plistDict=[[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }

//    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    //NSLog(@"VAlue%@", dic);
    
    return dic;
}

@end
