//
//  ReceiverAvatarViewController.h
//  ML Wallet
//
//  Created by ml on 2/25/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReceiverObject.h"

@interface ReceiverAvatarViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *relationLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;


@property (strong, nonatomic) ReceiverObject* receiver;

@end
