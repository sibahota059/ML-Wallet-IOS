//
//  SaveWalletData.m
//  ML Wallet
//
//  Created by ml on 7/19/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "SaveWalletData.h"

@implementation SaveWalletData

/*-(NSMutableDictionary *) initPath
{
    
    BOOL doesExist;
    NSError *error;
    NSMutableDictionary* plistDict;
    NSString *filePath= [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * path =[[NSString alloc] initWithString:[documentsDirectory stringByAppendingPathComponent:@"data.plist"]];
    
    doesExist= [fileManager fileExistsAtPath:path];
    
    if (doesExist) {
        plistDict=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    }
    else
    {
        
        doesExist= [fileManager copyItemAtPath:filePath  toPath:path error:&error];
        plistDict=[[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }
    return plistDict;

    [plistDict setObject:@"si" forKey:@"stato"];
    
    [plistDict writeToFile:path atomically: YES];
    
    
    if([super init])
    {
        self.path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    }
}
*/
#pragma mark SaveData
- (void) initSaveData:(NSString *)strValue forKey:(NSString *)forkey
{    
//    NSString *path = self.path;
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

    
    if ([forkey isEqualToString:@"balance"])
    {
//        path = self.path;
//        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        [plistDict setObject:[NSNumber numberWithDouble:[strValue doubleValue]] forKey:forkey];
        [plistDict writeToFile:path atomically:YES];
    }
    else
    {
//        path = self.path;
//        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        [plistDict setObject:[NSString stringWithString:strValue] forKey:forkey];
        [plistDict writeToFile:path atomically:YES];
    }
}

@end
