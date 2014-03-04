//
//  CreateNewReceiverViewController.h
//  ML Wallet
//
//  Created by ml on 2/21/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateNewReceiverViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *MyScrollview;


//TextFields
@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
@property (strong, nonatomic) IBOutlet UITextField *txtMiddleName;
@property (strong, nonatomic) IBOutlet UITextField *txtAddress;
@end
