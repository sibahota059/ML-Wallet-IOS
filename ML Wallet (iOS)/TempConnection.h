//
//  TempConnection.h
//  ML Wallet
//
//  Created by ml on 7/23/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TempConnection : NSObject

- (NSString *)getHttp;
- (NSString *)getUrl;
- (NSString *)getPort;
- (NSString *)getPath;
- (NSString *)getPdfPath;

@end
