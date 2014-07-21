//
//  MLRatesTableViewController.h
//  SendMoney
//
//  Created by mm20 on 2/17/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KpRates.h"
#import "MBProgressHUD.h"

@interface MLRatesTableViewController : UITableViewController<KpRatesDelegate, MBProgressHUDDelegate>

@property (strong, nonatomic) NSDictionary *getRates;
@end
