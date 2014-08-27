//
//  QuestionsActivity.h
//  Registration
//
//  Created by mm20-18 on 3/12/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "MLViewController.h"

@interface QuestionsActivity : UIViewController <UITextFieldDelegate>
{
    NSString *quest_act_custIDfirstNumber;
    NSString *quest_act_custIDsecondNumber;
    NSString *quest_act_custIDthirdNumber;
    NSString *quest_act_custIDphoneNumber;
    
    NSString *quest_act_firstName;
    NSString *quest_act_middleName;
    NSString *quest_act_lastName;
    NSString *quest_act_country;
    NSString *quest_act_province;
    NSString *quest_act_address;
    NSString *quest_act_zipcode;
    NSString *quest_act_gender;
    NSString *quest_act_birthdate;
    NSString *quest_act_number;
    NSString *quest_act_email;
    NSString *quest_act_work;
    NSString *quest_act_nationality;
    
    NSString *quest_act_str_photo1;
    NSString *quest_act_str_photo2;
    NSString *quest_act_str_photo3;
    NSString *quest_act_str_photo4;
    NSString *quest_act_str_balance;
    NSString *quest_act_str_secanswer1;
    NSString *quest_act_str_secanswer2;
    NSString *quest_act_str_secanswer3;
    NSString *quest_act_str_secquestion1;
    NSString *quest_act_str_secquestion2;
    NSString *quest_act_str_secquestion3;
    NSString *quest_act_str_walletno;
}
@property (nonatomic, retain) NSString *quest_act_custIDfirstNumber;
@property (nonatomic, retain) NSString *quest_act_custIDsecondNumber;
@property (nonatomic, retain) NSString *quest_act_custIDthirdNumber;
@property (nonatomic, retain) NSString *quest_act_custIDphoneNumber;

@property (nonatomic, retain) NSString *quest_act_firstName;
@property (nonatomic, retain) NSString *quest_act_middleName;
@property (nonatomic, retain) NSString *quest_act_lastName;
@property (nonatomic, retain) NSString *quest_act_country;
@property (nonatomic, retain) NSString *quest_act_province;
@property (nonatomic, retain) NSString *quest_act_address;
@property (nonatomic, retain) NSString *quest_act_zipcode;
@property (nonatomic, retain) NSString *quest_act_gender;
@property (nonatomic, retain) NSString *quest_act_birthdate;
@property (nonatomic, retain) NSString *quest_act_number;
@property (nonatomic, retain) NSString *quest_act_email;
@property (nonatomic, retain) NSString *quest_act_work;
@property (nonatomic, retain) NSString *quest_act_nationality;

@property (nonatomic, retain) NSString *quest_act_str_photo1;
@property (nonatomic, retain) NSString *quest_act_str_photo2;
@property (nonatomic, retain) NSString *quest_act_str_photo3;
@property (nonatomic, retain) NSString *quest_act_str_photo4;
@property (nonatomic, retain) NSString *quest_act_str_balance;
@property (nonatomic, retain) NSString *quest_act_str_secanswer1;
@property (nonatomic, retain) NSString *quest_act_str_secanswer2;
@property (nonatomic, retain) NSString *quest_act_str_secanswer3;
@property (nonatomic, retain) NSString *quest_act_str_secquestion1;
@property (nonatomic, retain) NSString *quest_act_str_secquestion2;
@property (nonatomic, retain) NSString *quest_act_str_secquestion3;
@property (nonatomic, retain) NSString *quest_act_str_walletno;


@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSMutableData *responseData;
@property (assign, nonatomic) NSUInteger idd;
@property (assign, nonatomic) NSUInteger questionstextFieldStatus;
@end
