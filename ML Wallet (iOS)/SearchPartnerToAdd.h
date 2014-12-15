//
//  SearchPartnerToAdd.h
//  ML Wallet
//
//  Created by mm20-18 on 12/11/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySearchDisplayController.h"

@interface SearchPartnerToAdd : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>


@property (strong, nonatomic) IBOutlet UITableView *partnersTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) MySearchDisplayController *searchDisplayController;

@property(nonatomic,retain)NSArray *allPartners;
@end
