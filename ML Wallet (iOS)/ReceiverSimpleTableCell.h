//
//  SimpleTableCell.h
//  SimpleTable
//
//  Created by ml on 1/6/14.
//  Copyright (c) 2014 chonex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiverSimpleTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *prepTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
/*
@property (nonatomic,strong) UIImageView *thumbnailImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *prepTimeLabel;
 */
@end
