//
//  Customer.h
//  Registration
//
//  Created by mm20-18 on 3/13/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *middleName;
@property (strong, nonatomic) NSString *lastName;


@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *birthday;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *nationality;
@property (strong, nonatomic) NSString *work;

@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *provinceCity;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *zipcode;

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *mobileNo;

@property (strong, nonatomic) NSString *question1;
@property (strong, nonatomic) NSString *question2;
@property (strong, nonatomic) NSString *question3;

@property (strong, nonatomic) NSString *answer1;
@property (strong, nonatomic) NSString *answer2;
@property (strong, nonatomic) NSString *answer3;

@property (strong, nonatomic) NSString *walletNo;
@property (strong, nonatomic) NSString *balance;

@end
