//
//  ResetPassViewController.h
//  ML Wallet
//
//  Created by ml on 7/25/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ResetPassViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    NSMutableArray *searchWhereOptions;
    UIActionSheet *actionSheet;
    IBOutlet UILabel *searchWhere;
    NSInteger selectedOption;
}
@property (strong, nonatomic) IBOutlet UITextField *lblUsername;
@property (strong, nonatomic) IBOutlet UITextField *lblEmail;
@property (strong, nonatomic) IBOutlet UITextField *lblSecQuestion;
@property (strong, nonatomic) IBOutlet UITextField *lblAnswer;

- (IBAction)showSearchWhereOptions:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *lblViewIpad;
@property (strong, nonatomic) IBOutlet UITextField *SecQuestion;

@property (strong, nonatomic) NSMutableData *responseData;
@end
