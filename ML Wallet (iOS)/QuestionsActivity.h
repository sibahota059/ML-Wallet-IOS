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
    NSString *custIDfirstNumber;
    NSString *custIDsecondNumber;
    NSString *custIDthirdNumber;
    NSString *custIDphoneNumber;
    
    NSString *firstName;
    NSString *middleName;
    NSString *lastName;
    NSString *country;
    NSString *province;
    NSString *address;
    NSString *zipcode;
    NSString *gender;
    NSString *birthdate;
    NSString *number;
    NSString *email;
    NSString *work;
    NSString *nationality;
}
@property (nonatomic, retain) NSString *custIDfirstNumber;
@property (nonatomic, retain) NSString *custIDsecondNumber;
@property (nonatomic, retain) NSString *custIDthirdNumber;
@property (nonatomic, retain) NSString *custIDphoneNumber;

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *middleName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *province;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *zipcode;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *birthdate;
@property (nonatomic, retain) NSString *number;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *work;
@property (nonatomic, retain) NSString *nationality;
@end
