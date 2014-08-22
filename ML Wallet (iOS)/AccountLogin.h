//
//  AccountLogin.h
//  Registration
//
//  Created by mm20-18 on 3/12/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "MLViewController.h"
#import "MBProgressHUD.h"
@interface AccountLogin : UIViewController <UITextFieldDelegate,MBProgressHUDDelegate,UIAlertViewDelegate,NSURLConnectionDelegate>
{
    NSString *act_log_custIDfirstNumber;
    NSString *act_log_custIDsecondNumber;
    NSString *act_log_custIDthirdNumber;
    NSString *act_log_custIDphoneNumber;
    
    NSString *act_log_firstName;
    NSString *act_log_middleName;
    NSString *act_log_lastName;
    NSString *act_log_country;
    NSString *act_log_province;
    NSString *act_log_address;
    NSString *act_log_zipcode;
    NSString *act_log_gender;
    NSString *act_log_birthdate;
    NSString *act_log_number;
    NSString *act_log_email;
    NSString *act_log_work;
    NSString *act_log_nationality;
    
    NSString *act_log_str_photo1;
    NSString *act_log_str_photo2;
    NSString *act_log_str_photo3;
    NSString *act_log_str_photo4;
    NSString *act_log_str_balance;
    NSString *act_log_str_secanswer1;
    NSString *act_log_str_secanswer2;
    NSString *act_log_str_secanswer3;
    NSString *act_log_str_secquestion1;
    NSString *act_log_str_secquestion2;
    NSString *act_log_str_secquestion3;
    NSString *act_log_str_walletno;
    
}
@property (nonatomic, retain) NSString *act_log_custIDfirstNumber;
@property (nonatomic, retain) NSString *act_log_custIDsecondNumber;
@property (nonatomic, retain) NSString *act_log_custIDthirdNumber;
@property (nonatomic, retain) NSString *act_log_custIDphoneNumber;

@property (nonatomic, retain) NSString *act_log_firstName;
@property (nonatomic, retain) NSString *act_log_middleName;
@property (nonatomic, retain) NSString *act_log_lastName;
@property (nonatomic, retain) NSString *act_log_country;
@property (nonatomic, retain) NSString *act_log_province;
@property (nonatomic, retain) NSString *act_log_address;
@property (nonatomic, retain) NSString *act_log_zipcode;
@property (nonatomic, retain) NSString *act_log_gender;
@property (nonatomic, retain) NSString *act_log_birthdate;
@property (nonatomic, retain) NSString *act_log_number;
@property (nonatomic, retain) NSString *act_log_email;
@property (nonatomic, retain) NSString *act_log_work;
@property (nonatomic, retain) NSString *act_log_nationality;

@property (nonatomic, retain) NSString *act_log_str_photo1;
@property (nonatomic, retain) NSString *act_log_str_photo2;
@property (nonatomic, retain) NSString *act_log_str_photo3;
@property (nonatomic, retain) NSString *act_log_str_photo4;
@property (nonatomic, retain) NSString *act_log_str_balance;
@property (nonatomic, retain) NSString *act_log_str_secanswer1;
@property (nonatomic, retain) NSString *act_log_str_secanswer2;
@property (nonatomic, retain) NSString *act_log_str_secanswer3;
@property (nonatomic, retain) NSString *act_log_str_secquestion1;
@property (nonatomic, retain) NSString *act_log_str_secquestion2;
@property (nonatomic, retain) NSString *act_log_str_secquestion3;
@property (nonatomic, retain) NSString *act_log_str_walletno;

@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSMutableData *responseData;
@property (assign, nonatomic) NSUInteger idd;
@end
