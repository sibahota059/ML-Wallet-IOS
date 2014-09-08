//
//  ProfileInformationPad.h
//  ML Wallet
//
//  Created by mm20-18 on 8/4/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileInformationPad : UIViewController

@property (strong, nonatomic) UIScrollView *profileScroll;

@property (strong, nonatomic) UIView * editDialog;


@property (strong, nonatomic) UIImageView *profileImage;

@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UIImageView *imageView3;
@property (strong, nonatomic) UIImageView *imageView4;




@property (strong, nonatomic) UILabel *profileName;
@property (strong, nonatomic) UILabel *profilePhone;
@property (strong, nonatomic) UILabel *profileEmail;


@property (strong, nonatomic) UILabel *firstName;
@property (strong, nonatomic) UILabel *middleName;
@property (strong, nonatomic) UILabel *lastName;
@property (strong, nonatomic) UILabel *country;
@property (strong, nonatomic) UILabel *province;
@property (strong, nonatomic) UILabel *address;
@property (strong, nonatomic) UILabel *zipcode;
@property (strong, nonatomic) UILabel *gender;
@property (strong, nonatomic) UILabel *birthdate;
@property (strong, nonatomic) UILabel *age;
@property (strong, nonatomic) UILabel *mobileNumber;
@property (strong, nonatomic) UILabel *work;
@property (strong, nonatomic) UILabel *nationality;



@end
