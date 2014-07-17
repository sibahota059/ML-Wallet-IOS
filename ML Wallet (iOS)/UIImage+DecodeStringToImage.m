//
//  UIImage+DecodeStringToImage.m
//  ML Wallet
//
//  Created by ml on 7/15/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "UIImage+DecodeStringToImage.h"

@implementation UIImage (DecodeStringToImage)

+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

@end
