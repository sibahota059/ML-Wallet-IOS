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
    NSString *custIDfirstNumber;
    NSString *custIDsecondNumber;
    NSString *custIDthirdNumber;
    NSString *custIDphoneNumber;
}

@property (nonatomic, retain) NSString *custIDfirstNumber;
@property (nonatomic, retain) NSString *custIDsecondNumber;
@property (nonatomic, retain) NSString *custIDthirdNumber;
@property (nonatomic, retain) NSString *custIDphoneNumber;

@end
