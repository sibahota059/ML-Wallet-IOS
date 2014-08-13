//
//  EditInformationPadCell.m
//  ML Wallet
//
//  Created by mm20-18 on 8/4/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditInformationPadCell.h"

@implementation EditInformationPadCell

@synthesize optionLabel = _optionLabel;




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
