//
//  JsonHelper.h
//  ML Wallet
//
//  Created by mm20 on 6/11/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonHelper : NSObject

+(NSDictionary *)loadJSONDataFromURL:(NSString *)urlString;

@end
