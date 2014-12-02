//
//  PartnersTableViewController.h
//  ML Wallet
//
//  Created by ml on 11/28/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetReceiver.h"
#import "MBProgressHUD.h"

@class PartnersTableViewController;

@protocol PartnersTableViewControllerDelegate <NSObject>

- (void)didSelectPartners:(PartnersTableViewController *)controller andPartnersName:(NSString *)partnersName andDisplayType:(NSString *)displayType andPosition:(int)getPosition;

@end

@interface PartnersTableViewController : UITableViewController

@property (weak, nonatomic) id<PartnersTableViewControllerDelegate>delegate;
@property (strong, nonatomic) NSDictionary *passPartners;
@property (strong, nonatomic) NSString *displayType;
@property (strong, nonatomic) NSMutableArray *getPartners, *getAccount;

@end
