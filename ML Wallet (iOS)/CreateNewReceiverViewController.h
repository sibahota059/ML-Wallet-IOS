//
//  CreateNewReceiverViewController.h
//  ML Wallet
//
//  Created by ml on 2/21/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CreateNewReceiverViewController : UIViewController <MBProgressHUDDelegate, NSURLConnectionDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    MBProgressHUD *HUD;
}

@property (strong, nonatomic) NSMutableData *responseData;

@property (strong, nonatomic) IBOutlet UIImageView *rec_image;
@property (strong, nonatomic) IBOutlet UIScrollView *MyScrollview;

@property (strong, nonatomic) IBOutlet UIView *relationView;
@property (strong, nonatomic) IBOutlet UIButton *txtRelation;

- (IBAction)btnRelation:(id)sender;
- (IBAction)btnFamily:(id)sender;
- (IBAction)btnFriend:(id)sender;
- (IBAction)btnGetPhoto:(id)sender;


//TextFields
@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
@property (strong, nonatomic) IBOutlet UITextField *txtMiddleName;
@property (strong, nonatomic) IBOutlet UITextField *txtAddress;

//if Edit... Assign automatically
@property (assign, nonatomic) BOOL isEdit;
@property (assign, nonatomic) NSNumber *recNo;
@property (assign, nonatomic) NSString *fname;
@property (assign, nonatomic) NSString *lname;
@property (assign, nonatomic) NSString *mname;
@property (assign, nonatomic) NSString *addrs;
@property (assign, nonatomic) NSString *rlate;
@property (assign, nonatomic) UIImage  *image;
@end
