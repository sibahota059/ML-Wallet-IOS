//
//  RegistrationInformation.h
//  Registration
//
//  Created by mm20-18 on 3/11/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "MLViewController.h"

@interface RegistrationInformation : UIViewController <UITextFieldDelegate>
{
    NSString *reg_info_custIDfirstNumber;
    NSString *reg_info_custIDsecondNumber;
    NSString *reg_info_custIDthirdNumber;
    NSString *reg_info_custIDphoneNumber;
    
    
    NSString *reg_info_str_firstName;
    NSString *reg_info_str_middleName;
    NSString *reg_info_str_lastName;
    NSString *reg_info_str_country;
    NSString *reg_info_str_province;
    NSString *reg_info_str_address;
    NSString *reg_info_str_zipcode;
    NSString *reg_info_str_gender;
    NSString *reg_info_str_birthdate;
    NSString *reg_info_str_number;
    NSString *reg_info_str_email;
    NSString *reg_info_str_work;
    NSString *reg_info_str_nationality;
    
    NSString *reg_info_str_photo1;
    NSString *reg_info_str_photo2;
    NSString *reg_info_str_photo3;
    NSString *reg_info_str_photo4;
    NSString *reg_info_str_balance;
    NSString *reg_info_str_secanswer1;
    NSString *reg_info_str_secanswer2;
    NSString *reg_info_str_secanswer3;
    NSString *reg_info_str_secquestion1;
    NSString *reg_info_str_secquestion2;
    NSString *reg_info_str_secquestion3;
    NSString *reg_info_str_walletno;
}

@property (nonatomic, retain) NSString *reg_info_custIDfirstNumber;
@property (nonatomic, retain) NSString *reg_info_custIDsecondNumber;
@property (nonatomic, retain) NSString *reg_info_custIDthirdNumber;
@property (nonatomic, retain) NSString *reg_info_custIDphoneNumber;


@property (nonatomic, retain) NSString *reg_info_str_firstName;
@property (nonatomic, retain) NSString *reg_info_str_middleName;
@property (nonatomic, retain) NSString *reg_info_str_lastName;
@property (nonatomic, retain) NSString *reg_info_str_country;
@property (nonatomic, retain) NSString *reg_info_str_province;
@property (nonatomic, retain) NSString *reg_info_str_address;
@property (nonatomic, retain) NSString *reg_info_str_zipcode;
@property (nonatomic, retain) NSString *reg_info_str_gender;
@property (nonatomic, retain) NSString *reg_info_str_birthdate;
@property (nonatomic, retain) NSString *reg_info_str_number;
@property (nonatomic, retain) NSString *reg_info_str_email;
@property (nonatomic, retain) NSString *reg_info_str_work;
@property (nonatomic, retain) NSString *reg_info_str_nationality;


@property (nonatomic, retain) NSString *reg_info_str_photo1;
@property (nonatomic, retain) NSString *reg_info_str_photo2;
@property (nonatomic, retain) NSString *reg_info_str_photo3;
@property (nonatomic, retain) NSString *reg_info_str_photo4;
@property (nonatomic, retain) NSString *reg_info_str_balance;
@property (nonatomic, retain) NSString *reg_info_str_secanswer1;
@property (nonatomic, retain) NSString *reg_info_str_secanswer2;
@property (nonatomic, retain) NSString *reg_info_str_secanswer3;
@property (nonatomic, retain) NSString *reg_info_str_secquestion1;
@property (nonatomic, retain) NSString *reg_info_str_secquestion2;
@property (nonatomic, retain) NSString *reg_info_str_secquestion3;
@property (nonatomic, retain) NSString *reg_info_str_walletno;

@end
