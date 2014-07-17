//
//  CreateNewReceiverViewController.h
//  ML Wallet
//
//  Created by ml on 2/21/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CreateNewReceiverViewController : UIViewController <MBProgressHUDDelegate, NSURLConnectionDelegate>
{
    MBProgressHUD *HUD;
}

@property (strong, nonatomic) NSMutableData *responseData;

@property (strong, nonatomic) IBOutlet UIScrollView *MyScrollview;

@property (strong, nonatomic) IBOutlet UIView *relationView;
@property (strong, nonatomic) IBOutlet UIButton *txtRelation;

- (IBAction)btnRelation:(id)sender;
- (IBAction)btnFamily:(id)sender;
- (IBAction)btnFriend:(id)sender;


//TextFields
@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
@property (strong, nonatomic) IBOutlet UITextField *txtMiddleName;
@property (strong, nonatomic) IBOutlet UITextField *txtAddress;
@end
