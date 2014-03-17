//
//  MLHistoryTableViewCell.h
//  SendMoney
//
//  Created by mm20 on 3/12/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelType;
@property (weak, nonatomic) IBOutlet UILabel *labelAmount;
@property (weak, nonatomic) IBOutlet UILabel *labelBalance;

@end
