//
//  UIImage+DecodeStringToImage.h
//  ML Wallet
//
//  Created by ml on 7/15/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DecodeStringToImage)

+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;

@end
