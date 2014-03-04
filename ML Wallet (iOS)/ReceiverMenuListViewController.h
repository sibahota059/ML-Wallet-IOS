//
//  ReceiverMenuListViewController.h
//  ML Wallet
//
//  Created by ml on 2/20/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiverMenuListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIAlertViewDelegate>

//@property (strong, nonatomic) IBOutlet UIScrollView *MainScroll;
@property (strong, nonatomic) IBOutlet UISearchBar *receiverSearchBar;
@property (strong, nonatomic) IBOutlet UITableView *receiverTableView;


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* allTableData;
@property (strong, nonatomic) NSMutableArray* filteredTableData;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, assign) bool isFiltered;

@end
