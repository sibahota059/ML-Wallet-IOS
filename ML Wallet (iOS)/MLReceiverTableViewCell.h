//
//  MLReceiverTableViewCell.h
//  SendMoney
//
//  Created by mm20 on 2/19/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLReceiverTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *receiverImage;
@property (weak, nonatomic) IBOutlet UILabel *receiverName;
@property (weak, nonatomic) IBOutlet UILabel *receiverAddress;
@property (weak, nonatomic) IBOutlet UILabel *receiverRelation;

@end
