//
//  MLhuillierWebViewController.h
//  ML Wallet
//
//  Created by ml on 7/26/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface MLhuillierWebViewController : UIViewController<UIWebViewDelegate,MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *mLhuillierWebView;

@end
