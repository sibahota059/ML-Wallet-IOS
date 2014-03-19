//
//  RegistrationInformation.m
//  Registration
//
//  Created by mm20-18 on 3/11/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "RegistrationInformation.h"
#import "QuestionsActivity.h"
#import "ProfileHeader.h"
#import "ProfileOutline.h"
#import "ProfileLabel.h"


@interface RegistrationInformation ()

@end

@implementation RegistrationInformation

UIScrollView *profileScroll;

int profileOutlineWidth;
int profileOutlineHeight;

int labelX;
int labelValueX;

int outlineX;
int outlineWidth;
int outlineHeight;

int imageY;
int personalY;
int locationY;
int contactY;


ProfileLabel *fullName,  *lastName, *country, *province, *address, *zipcode, *gender, *birthdate, *age, *mobileNumber, *email, *work, *nationality;


ProfileOutline *fullNameO, *middleNameO, *lastNameO, *countryO, *provinceO, *addressO, *zipcodeO, *genderO, *birthdateO, *ageO, *mobileNumberO, *emailO, *workO, *nationalityO;


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
    // Do any additional setup after loading the view from its nib.
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 800)];
    
    labelX = 10;
    labelValueX = 0;
    
    outlineX = 10;
    outlineWidth = 300;
    
    
    profileOutlineWidth = 280;
    profileOutlineHeight = 25;
    
    imageY = 20;
    personalY = 30;
    locationY = 330;
    contactY = 580;

    
    
    QuestionsActivity *questionsActivity = [[QuestionsActivity alloc] initWithNibName:@"QuestionsActivity" bundle:nil];
    [self setNextViewController:questionsActivity myImage:[UIImage imageNamed:@"question_profile.png"]];
    
    
    [self createPersonalInfo];
    [self createLocationInfo];
    [self createContactInfo];
//
    
    [self.view addSubview:profileScroll];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - CREATE UI

-(void) createPersonalInfo{
    
    
    
    ProfileHeader *personalHeader = [[ProfileHeader alloc] initWithValue:@" Personal Information" x:5 y:-10 width:170];
    
    ProfileOutline *personalOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, personalY, outlineWidth, 280)];
    
    
    
    
    //PERSONAL INFORMATION
    
    fullName = [[ProfileLabel alloc] initWithStatus:@"Full Name" x:labelX y:20];
    
    fullNameO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Harry C. Lingad"];
    
    
    
    gender = [[ProfileLabel alloc] initWithStatus:@"Gender" x:labelX y:70];
    
    genderO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 90, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Male"];
    
    
    
    birthdate = [[ProfileLabel alloc] initWithStatus:@"Birthdate" x:labelX y:120];
    
    birthdateO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 140, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"November 1, 1122"];
    
    
    
    nationality = [[ProfileLabel alloc] initWithStatus:@"Nationality" x:labelX y:170];
    
    nationalityO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 190, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Filipino"];
    
    
    
    
    work = [[ProfileLabel alloc] initWithStatus:@"Nature of Work" x:labelX y:220];
    
    workO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 240, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Programmer"];
    
    
    
    //ADDING THE COMPONENTS
    
    [personalOutline addSubview:fullName];
    [personalOutline addSubview:fullNameO];
    
    
    [personalOutline addSubview:genderO];
    [personalOutline addSubview:gender];
    
    [personalOutline addSubview:birthdateO];
    [personalOutline addSubview:birthdate];
    
    [personalOutline addSubview:ageO];
    [personalOutline addSubview:age];
    
    [personalOutline addSubview:nationalityO];
    [personalOutline addSubview:nationality];
    
    [personalOutline addSubview:workO];
    [personalOutline addSubview:work];
    
    [personalOutline addSubview:personalHeader];
    [profileScroll addSubview:personalOutline];
    
    
    
    
    
}

-(void) createLocationInfo{
    
    
    ProfileHeader *locationHeader = [[ProfileHeader alloc] initWithValue:@" Location Information" x:5 y:-10 width:170];
    
    ProfileOutline *locationOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, locationY, outlineWidth, 230)];
    
    
    
    country = [[ProfileLabel alloc] initWithStatus:@"Country" x:labelX y:20];
    
    countryO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Philippines"];
    
    
    
    province = [[ProfileLabel alloc] initWithStatus:@"Province" x:labelX y:70];
    
    provinceO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 90, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Lanao del Norte"];
    
    
    
    address = [[ProfileLabel alloc] initWithStatus:@"Permanent Address" x:labelX y:120 width:130];
    
    addressO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 140, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Mabolo, Cebu City"];
    
    
    
    zipcode = [[ProfileLabel alloc] initWithStatus:@"Zipcode" x:labelX y:170];
    
    zipcodeO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 190, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"6000"];
    
    
    
    [locationOutline addSubview:countryO];
    [locationOutline addSubview:country];
    
    [locationOutline addSubview:provinceO];
    [locationOutline addSubview:province];
    
    [locationOutline addSubview:addressO];
    [locationOutline addSubview:address];
    
    [locationOutline addSubview:zipcodeO];
    [locationOutline addSubview:zipcode];
    
    
    [locationOutline addSubview:locationHeader];
    [profileScroll addSubview:locationOutline];
    
}

-(void) createContactInfo{
    
    
    ProfileHeader *contactHeader = [[ProfileHeader alloc] initWithValue:@" Contact Information" x:5 y:-10 width:170];
    
    ProfileOutline *contactOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, contactY, outlineWidth, 130)];
    
    
    
    
    email = [[ProfileLabel alloc] initWithStatus:@"Emaill Address" x:labelX y:20];
    
    emailO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"harry@yahoo.com"];
    
    
    
    mobileNumber = [[ProfileLabel alloc] initWithStatus:@"Mobile Number" x:labelX y:70];
    
    mobileNumberO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 90, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"09273444456"];
    
    
    
    
    
    [contactOutline addSubview:emailO];
    [contactOutline addSubview:email];
    
    [contactOutline addSubview:mobileNumber];
    [contactOutline addSubview:mobileNumberO];
    
    
    
    
    
    
    
    [contactOutline addSubview:contactHeader];
    
    [profileScroll addSubview:contactOutline];
    
}



@end
