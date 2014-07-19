//
//  TopupViewController.h
//  ML Wallet
//
//  Created by ml on 2/28/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface TopupViewController : UIViewController <NSURLConnectionDelegate, MBProgressHUDDelegate, UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
}

@property (retain, nonatomic) NSMutableData *responseData;
@property (assign, nonatomic) NSUInteger idd;
@property (retain, nonatomic) NSString *strKPTN;

@property (strong, nonatomic) IBOutlet UITextField *txtKPTN;
- (IBAction)btnSubmit:(id)sender;

@end
