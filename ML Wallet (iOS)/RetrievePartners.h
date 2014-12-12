//
//  RetrievePartners.h
//  ML Wallet
//
//  Created by mm20-18 on 11/24/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface RetrievePartners : UIViewController <UITableViewDelegate, UITableViewDataSource, MBProgressHUDDelegate>
{
    NSDictionary *partners;
    NSMutableArray *accountNoList;
}
@property(nonatomic,retain)NSDictionary *partners;
@property(nonatomic,retain)NSMutableArray *accountNoList;

@end
