//
//  SaveWalletData.m
//  ML Wallet
//
//  Created by ml on 7/19/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "SaveWalletData.h"

@implementation SaveWalletData

-(void) initPath
{
    if([super init])
    {
        self.path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    }
}

#pragma mark SaveData
- (void) initSaveData:(NSString *)strValue forKey:(NSString *)forkey
{    
    NSString *path = self.path;
    if (path == nil)
    {
        [self initPath];
    }
    
    path = self.path;    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    [data setObject:[NSString stringWithString:strValue] forKey:forkey];
    [data writeToFile:path atomically:YES];
    
}

@end
