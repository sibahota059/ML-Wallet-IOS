//
//  MLReceiverTableViewController.h
//  SendMoney
//
//  Created by mm20 on 2/19/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetReceiver.h"
#import "MBProgressHUD.h"

@class MLReceiverTableViewController;

@protocol MLReceiverTableViewControllerDelegate <NSObject>

- (void)didSelectReceiver:(MLReceiverTableViewController *)controller receiverFname:(NSString *)rfname receiverMname:(NSString *)rmname receiverLname:(NSString *)rlname receiverImage:(NSString *)rimage receiverAddress:(NSString *)raddress receiverRelation:(NSString *)rrelation rcount:(int)count;

@end

@interface MLReceiverTableViewController : UITableViewController<GetReceiverDelegate, MBProgressHUDDelegate>

@property (weak, nonatomic) id<MLReceiverTableViewControllerDelegate>delegate;

@end
