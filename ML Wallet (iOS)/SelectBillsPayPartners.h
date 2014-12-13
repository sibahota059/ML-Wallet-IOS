//
//  SelectBillsPayPartners.h
//  ML Wallet
//
//  Created by mm20-18 on 12/9/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetAllPartnerWS.h"
#import "MBProgressHUD.h"
#import "MySearchDisplayController.h"

@interface SelectBillsPayPartners : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, GetAllPartnerWSDelegate, MBProgressHUDDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
{
    UISearchBar *partnersSearchBar;
    MySearchDisplayController *searchDisplayController;
}

@property (strong, nonatomic) IBOutlet UITableView *partnersTableView;
@end
