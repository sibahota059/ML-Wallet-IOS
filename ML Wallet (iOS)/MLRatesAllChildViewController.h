//
//  MLRatesAllChildViewController.h
//  ML Wallet
//
//  Created by ml on 11/26/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KpRates.h"
#import "KpRatesOwn.h"
#import "MBProgressHUD.h"

@interface MLRatesAllChildViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, KpRatesDelegate, KpRatesDelegateOwn, MBProgressHUDDelegate>

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) IBOutlet UILabel *screenNumber;
@property (strong, nonatomic) NSDictionary *getRates;
@property (strong, nonatomic) NSString *indicator;
@property (weak, nonatomic) IBOutlet UITableView *rates_tableview;

@end
