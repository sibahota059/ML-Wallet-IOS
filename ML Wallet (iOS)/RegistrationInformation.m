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
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

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
CGRect screenRect;
CGFloat screenWidth;
CGFloat screenHeight;

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
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
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
    
    //ProfileOutline *personalOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, personalY, outlineWidth, 280)];
    
    UIView* personalOutline = [[UIView alloc] initWithFrame:CGRectMake(outlineX,personalY,outlineWidth,280)];
    
    
    //PERSONAL INFORMATION
    
    fullName = [[ProfileLabel alloc] initWithStatus:@"Full Name" x:labelX y:20];
    
    fullNameO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Harry C. Lingad"];
    fullNameO.layer.borderColor = [UIColor redColor].CGColor;
    fullNameO.layer.borderWidth = 2.0f;
    
    
    gender = [[ProfileLabel alloc] initWithStatus:@"Gender" x:labelX y:70];
    
    genderO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 90, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Male"];
    genderO.layer.borderColor = [UIColor redColor].CGColor;
    genderO.layer.borderWidth = 2.0f;
    
    
    birthdate = [[ProfileLabel alloc] initWithStatus:@"Birthdate" x:labelX y:120];
    
    birthdateO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 140, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"November 1, 1122"];
    birthdateO.layer.borderColor = [UIColor redColor].CGColor;
    birthdateO.layer.borderWidth = 2.0f;
    
    
    nationality = [[ProfileLabel alloc] initWithStatus:@"Nationality" x:labelX y:170];
    
    nationalityO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 190, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Filipino"];
    nationalityO.layer.borderColor = [UIColor redColor].CGColor;
    nationalityO.layer.borderWidth = 2.0f;
    
    
    
    work = [[ProfileLabel alloc] initWithStatus:@"Nature of Work" x:labelX y:220];
    
    workO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 240, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Programmer"];
    workO.layer.borderColor = [UIColor redColor].CGColor;
    workO.layer.borderWidth = 2.0f;
    
    
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
    
  // ProfileOutline *locationOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, locationY, outlineWidth, 230)];
    
    UIView* locationOutline = [[UIView alloc] initWithFrame:CGRectMake(outlineX,locationY,outlineWidth,230)];
    
    country = [[ProfileLabel alloc] initWithStatus:@"Country" x:labelX y:20];
    
    countryO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Philippines"];
    countryO.layer.borderColor = [UIColor redColor].CGColor;
    countryO.layer.borderWidth = 2.0f;
    
    
    province = [[ProfileLabel alloc] initWithStatus:@"Province" x:labelX y:70];
    
    provinceO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 90, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Lanao del Norte"];
    provinceO.layer.borderColor = [UIColor redColor].CGColor;
    provinceO.layer.borderWidth = 2.0f;
    
    
    address = [[ProfileLabel alloc] initWithStatus:@"Permanent Address" x:labelX y:120 width:130];
    
    addressO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 140, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Mabolo, Cebu City"];
    addressO.layer.borderColor = [UIColor redColor].CGColor;
    addressO.layer.borderWidth = 2.0f;
    

    
    zipcode = [[ProfileLabel alloc] initWithStatus:@"Zipcode" x:labelX y:170];
    
    zipcodeO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 190, profileOutlineWidth, profileOutlineHeight) color:[UIColor redColor] word:@"6000"];
    zipcodeO.layer.borderColor = [UIColor redColor].CGColor;
    zipcodeO.layer.borderWidth = 2.0f;
    
    
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
    
    //ProfileOutline *contactOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, contactY, outlineWidth, 130)];
    
    UIView* contactOutline = [[UIView alloc] initWithFrame:CGRectMake(outlineX,contactY,outlineWidth,130)];
    
    
    email = [[ProfileLabel alloc] initWithStatus:@"Emaill Address" x:labelX y:20];
    
    emailO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"harry@yahoo.com"];
    emailO.layer.borderColor = [UIColor redColor].CGColor;
    emailO.layer.borderWidth = 2.0f;
    
    
    mobileNumber = [[ProfileLabel alloc] initWithStatus:@"Mobile Number" x:labelX y:70];
    
    mobileNumberO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 90, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"09273444456"];
    mobileNumberO.layer.borderColor = [UIColor redColor].CGColor;
    mobileNumberO.layer.borderWidth = 2.0f;
    
    
    
    
    [contactOutline addSubview:emailO];
    [contactOutline addSubview:email];
    
    [contactOutline addSubview:mobileNumber];
    [contactOutline addSubview:mobileNumberO];
    
    
    
    
    
    
    
    [contactOutline addSubview:contactHeader];
    
    [profileScroll addSubview:contactOutline];
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
