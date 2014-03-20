//
//  ProfileInformation.m
//  Account
//
//  Created by mm20-18 on 2/20/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "ProfileInformation.h"
#import "UpdateInformation.h"
#import "UICreationMethods.h"
#import "ProfileImage.h"
#import "ProfileOutline.h"
#import "ProfileHeader.h"
#import "AccountMain.h"
#import "ProfileLabel.h"
#import "QuestionVerificationDialog.h"

@interface ProfileInformation ()


@end

@implementation ProfileInformation

@synthesize profileScroll;
@synthesize editDialog;
UIImageView *radioButtonImage1;
UIImageView *radioButtonImage2;
UIImageView *radioButtonImage3;

NSString *question_1, *question_2, *question_3;

UILabel *selectedQuestion;

ProfileImage *profileImage;


QuestionVerificationDialog *dialog;





//DECLARE VARIABLES

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


ProfileLabel *firstName, *middleName, *lastName, *country, *province, *address, *zipcode, *gender, *birthdate, *age, *mobileNumber, *email, *work, *nationality;


ProfileOutline *firstNameO, *middleNameO, *lastNameO, *countryO, *provinceO, *addressO, *zipcodeO, *genderO, *birthdateO, *ageO, *mobileNumberO, *emailO, *workO, *nationalityO;



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
    
    question_1 = @"Who are you?";
    question_2 = @"Whar are you said?";
    question_3 = @"How come you are said that?";
    
    
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 1120)];
    
    
    
    //INTANTIATE THE VARIABLES
    labelX = 10;
    labelValueX = 0;
    
    outlineX = 10;
    outlineWidth = 300;
    
    
    profileOutlineWidth = 280;
    profileOutlineHeight = 25;
    
    imageY = 20;
    personalY = 190;
    locationY = 640;
    contactY = 890;
    
    
    [self createImageInfo];
    [self createPersonalInfo];
    [self createLocationInfo];
    [self createContactInfo];
    
    //END
    
    
    //CREATE DIALOG
    
    dialog = [[QuestionVerificationDialog alloc] initWithFrame:CGRectMake(0, 35, 280, 1120) addTarget:self action:@selector(goToEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    [dialog setHidden:YES];

    //CREATE DIALOG END

    
    [self.view addSubview:profileScroll];
    [self.view addSubview:dialog];
    
    [self addNavigationBarButton];
    
    
}







#pragma OTHER METHODS

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) goToEdit:(id)sender{
    
    UpdateInformation *updateInformation = [[UpdateInformation alloc] initWithNibName:@"UpdateInformation" bundle:nil];
    [dialog setHidden:YES];
    [self fadeInAnimation:dialog];
    [self.navigationController pushViewController:updateInformation animated:YES];
}

-(void)editPressed:(id)sender{
    
    [dialog setHidden:!dialog.hidden];
    
    [self fadeInAnimation:dialog];
    
}

-(void) addNavigationBarButton{
    
    
    
    //LEFT NAVIGATION BUTTON
    
    //RIGHT NAVIGATION BUTTON
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [backButton setImage:[UIImage imageNamed:@"back_profile.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    
    UIBarButtonItem *backNavButton = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [backNavButton setStyle:UIBarButtonItemStyleBordered];


    //RIGHT NAVIGATION BUTTON
    UIView *editView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [editButton setImage:[UIImage imageNamed:@"edit_profile.png"] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [editView addSubview:editButton];
    
    UIBarButtonItem *editNavButton = [[UIBarButtonItem alloc] initWithCustomView:editView];
    [editNavButton setStyle:UIBarButtonItemStyleBordered];
    [editNavButton setTarget:self];
    [editNavButton setAction:@selector(editPressed:)];
    

    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    [self.navigationItem setLeftBarButtonItem:backNavButton];
    [self.navigationItem setRightBarButtonItem:editNavButton];
    
}

-(void)backPressed:(id)sender{

    [self.navigationController  popViewControllerAnimated:YES];

}









#pragma mark - CREATE UI

-(void) createImageInfo{
    
    
    ProfileHeader *imageHeader = [[ProfileHeader alloc] initWithValue:@" Facial Information" x:5 y:-10 width:150];
    
    ProfileOutline *imageOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, imageY, outlineWidth, 145)];
    
    
    
    profileImage = [[ProfileImage alloc] initWithProfileImage:[UIImage imageNamed:@"rene.jpg"] x:105 y:20];
    
    [imageOutline addSubview:profileImage];
    [imageOutline addSubview:imageHeader];
    
    [profileScroll addSubview:imageOutline];
    
}

-(void) createPersonalInfo{
    
    
    
    ProfileHeader *personalHeader = [[ProfileHeader alloc] initWithValue:@" Personal Information" x:5 y:-10 width:170];
    
    ProfileOutline *personalOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, personalY, outlineWidth, 430)];
    
    
    
    
    //PERSONAL INFORMATION
    
    firstName = [[ProfileLabel alloc] initWithStatus:@"First Name" x:labelX y:20];
    
    firstNameO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Harry"];
    
    
    
    middleName = [[ProfileLabel alloc] initWithStatus:@"Middle Name" x:labelX y:70];
    
    middleNameO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 90, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Cobrado"];
    
    
    
    lastName = [[ProfileLabel alloc] initWithStatus:@"Last Name" x:labelX y:120];
    
    lastNameO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 140, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Lingad"];
    
    
    
    gender = [[ProfileLabel alloc] initWithStatus:@"Gender" x:labelX y:170];
    
    genderO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 190, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Male"];
    
    
    
    
    birthdate = [[ProfileLabel alloc] initWithStatus:@"Birthdate" x:labelX y:220];
    
    birthdateO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 240, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"November 1, 1122"];
    
    
    age = [[ProfileLabel alloc] initWithStatus:@"Age" x:labelX y:270];
    
    ageO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 290, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"56"];
    
    
    
    nationality = [[ProfileLabel alloc] initWithStatus:@"Nationality" x:labelX y:320];
    
    nationalityO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 340, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Filipino"];
    
    
    
    
    work = [[ProfileLabel alloc] initWithStatus:@"Nature of Work" x:labelX y:370];
    
    workO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 390, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Programmer"];
    
    
    
    //ADDING THE COMPONENTS
    
    [personalOutline addSubview:firstNameO];
    [personalOutline addSubview:firstName];
    
    [personalOutline addSubview:middleNameO];
    [personalOutline addSubview:middleName];
    
    [personalOutline addSubview:lastNameO];
    [personalOutline addSubview:lastName];
    
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










#pragma ANIMATION

-(void)fadeInAnimation:(UIView *) aView{
    CATransition *transition = [CATransition animation];
    transition.type = kCAAnimationRotateAuto;
    transition.duration = 0.5f;
    transition.delegate = self;
    [aView.layer addAnimation:transition forKey:nil];
    
}

-(void) moveUpAnimation:(UIView *) aView
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 0.5f;
    transition.delegate = self;
    [aView.layer addAnimation:transition forKey:nil];
}











@end
