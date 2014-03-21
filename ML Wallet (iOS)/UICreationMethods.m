//
//  UICreationMethods.m
//  Account
//
//  Created by mm20-18 on 3/4/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "UICreationMethods.h"
#import "ProfileLabel.h"

@interface UICreationMethods ()

@end

@implementation UICreationMethods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) createProfileInfo:(UIView *) view x:(int)x y:(int)y{
    
    ProfileLabel *firtName, *middleName, *lastName, *country, *province, *address, *zipcode, *gender, *birthdate, *age, *mobileNumber, *email, *work, *nationality;
    
    firtName = [[ProfileLabel alloc] initWithStatus:@"First Name" x:x y:y];
    middleName = [[ProfileLabel alloc] initWithStatus:@"Middle Name" x:x y:(y + 20)];
    lastName = [[ProfileLabel alloc] initWithStatus:@"Last Name" x:x y:(y + 40)];
    country = [[ProfileLabel alloc] initWithStatus:@"Country" x:x y:(y + 60)];
    province = [[ProfileLabel alloc] initWithStatus:@"Province" x:x y:(y + 80)];
    address = [[ProfileLabel alloc] initWithStatus:@"Address" x:x y:(y + 100)];
    zipcode = [[ProfileLabel alloc] initWithStatus:@"Zipcode" x:x y:(y + 120)];
    gender = [[ProfileLabel alloc] initWithStatus:@"Gender" x:x y:(y + 140)];
    birthdate = [[ProfileLabel alloc] initWithStatus:@"Birthdate" x:x y:(y + 160)];
    age = [[ProfileLabel alloc] initWithStatus:@"Age" x:x y:(y + 180)];
    mobileNumber = [[ProfileLabel alloc] initWithStatus:@"Mobile Number" x:x y:(y + 200)];
    email = [[ProfileLabel alloc] initWithStatus:@"Email Address" x:x y:(y + 220)];
    work = [[ProfileLabel alloc] initWithStatus:@"Nature of Work" x:x y:(y + 240)];
    nationality = [[ProfileLabel alloc] initWithStatus:@"Nationality" x:x y:(y + 260)];
    
    
    [view addSubview:firtName];
    [view addSubview:middleName];
    [view addSubview:lastName];
    [view addSubview:country];
    [view addSubview:province];
    [view addSubview:address];
    [view addSubview:zipcode];
    [view addSubview:gender];
    [view addSubview:birthdate];
    [view addSubview:age];
    [view addSubview:mobileNumber];
    [view addSubview:email];
    [view addSubview:work];
    [view addSubview:nationality];

    
}




-(void) createProfileInfoValue:(UIView *) view x:(int)x y:(int)y{
    
    ProfileLabel *firtName, *middleName, *lastName, *country, *province, *address, *zipcode, *gender, *birthdate, *age, *mobileNumber, *email, *work, *nationality;
    
    firtName = [[ProfileLabel alloc] initWithStatusValue:@"Harry" x:x y:y];
    middleName = [[ProfileLabel alloc] initWithStatusValue:@"Cobrado" x:x y:(y + 20)];
    lastName = [[ProfileLabel alloc] initWithStatusValue:@"Lingad" x:x y:(y + 40)];
    country = [[ProfileLabel alloc] initWithStatusValue:@"Phillipines" x:x y:(y + 60)];
    province = [[ProfileLabel alloc] initWithStatusValue:@"Lanao Del Norte" x:x y:(y + 80)];
    address = [[ProfileLabel alloc] initWithStatusValue:@"Mabolo Cebu City" x:x y:(y + 100)];
    zipcode = [[ProfileLabel alloc] initWithStatusValue:@"6000" x:x y:(y + 120)];
    gender = [[ProfileLabel alloc] initWithStatusValue:@"Male" x:x y:(y + 140)];
    birthdate = [[ProfileLabel alloc] initWithStatusValue:@"November 1, 1985" x:x y:(y + 160)];
    age = [[ProfileLabel alloc] initWithStatusValue:@"28" x:x y:(y + 180)];
    mobileNumber = [[ProfileLabel alloc] initWithStatusValue:@"09273444456" x:x y:(y + 200)];
    email = [[ProfileLabel alloc] initWithStatusValue:@"harrylingad@yahoo.com" x:x y:(y + 220)];
    work = [[ProfileLabel alloc] initWithStatusValue:@"Programmer" x:x y:(y + 240)];
    nationality = [[ProfileLabel alloc] initWithStatusValue:@"Pinoy" x:x y:(y + 260)];
    
    
    [view addSubview:firtName];
    [view addSubview:middleName];
    [view addSubview:lastName];
    [view addSubview:country];
    [view addSubview:province];
    [view addSubview:address];
    [view addSubview:zipcode];
    [view addSubview:gender];
    [view addSubview:birthdate];
    [view addSubview:age];
    [view addSubview:mobileNumber];
    [view addSubview:email];
    [view addSubview:work];
    [view addSubview:nationality];
    
    
}


@end
