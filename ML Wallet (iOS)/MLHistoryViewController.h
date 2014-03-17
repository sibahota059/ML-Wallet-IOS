//
//  MLHistoryViewController.h
//  SendMoney
//
//  Created by mm20 on 3/3/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLHistoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblHistory;
@property (weak, nonatomic) IBOutlet UIView *view_header;
@property (weak, nonatomic) IBOutlet UIView *view_transform;
@property (weak, nonatomic) IBOutlet UIButton *btnExit;
@property (weak, nonatomic) IBOutlet UIView *viewHistoryHeader;

@property (weak, nonatomic) IBOutlet UIView *view_fade;
- (IBAction)btnClose:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelKptn;
@property (weak, nonatomic) IBOutlet UILabel *labelReceiverId;
@property (weak, nonatomic) IBOutlet UILabel *labelType;

@end
