//
//  SimpleTableCell.m
//  SimpleTable
//
//  Created by ml on 1/6/14.
//  Copyright (c) 2014 chonex. All rights reserved.
//

#import "ReceiverSimpleTableCell.h"

@implementation SimpleTableCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
- (void) setNameLabel:(UILabel *)nameLabel
{
    nameLabel.text = @"asda";
}*/

@end
