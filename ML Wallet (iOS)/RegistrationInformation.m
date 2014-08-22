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
#import "ServiceConnection.h"
#import "UIAlertView+alertMe.h"
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@interface RegistrationInformation ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation RegistrationInformation
@synthesize reg_info_custIDfirstNumber;
@synthesize reg_info_custIDsecondNumber;
@synthesize reg_info_custIDthirdNumber;
@synthesize reg_info_custIDphoneNumber;

@synthesize reg_info_str_firstName;
@synthesize reg_info_str_middleName;
@synthesize reg_info_str_lastName;
@synthesize reg_info_str_country;
@synthesize reg_info_str_province;
@synthesize reg_info_str_address;
@synthesize reg_info_str_zipcode;
@synthesize reg_info_str_gender;
@synthesize reg_info_str_birthdate;
@synthesize reg_info_str_number;
@synthesize reg_info_str_email;
@synthesize reg_info_str_work;
@synthesize reg_info_str_nationality;

@synthesize reg_info_str_photo1;
@synthesize reg_info_str_photo2;
@synthesize reg_info_str_photo3;
@synthesize reg_info_str_photo4;
@synthesize reg_info_str_balance;
@synthesize reg_info_str_secanswer1;
@synthesize reg_info_str_secanswer2;
@synthesize reg_info_str_secanswer3;
@synthesize reg_info_str_secquestion1;
@synthesize reg_info_str_secquestion2;
@synthesize reg_info_str_secquestion3;
@synthesize reg_info_str_walletno;

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

ProfileOutline *firstNameO, *middleNameO, *lastNameO, *countryO, *provinceO, *addressO, *zipcodeO, *genderO, *birthdateO, *ageO, *mobileNumberO, *emailO, *workO, *nationalityO;
CGRect screenRect;
CGFloat screenWidth;
CGFloat screenHeight;
UILabel *email;
NSString *str_email_add;

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
    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, screenWidth, screenHeight)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 600)];
    
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
    /*
     QuestionsActivity *questionsActivity = [[QuestionsActivity alloc] initWithNibName:@"QuestionsActivity" bundle:nil];
     [self setNextViewController:questionsActivity myImage:[UIImage imageNamed:@"next.png"]];
     
     */
    [self addNavigationBar];
    [self createPersonalLabel];
    [self createPersonalValue];
    //
    
    [self.view addSubview:profileScroll];
    [self checkEmail];
    NSLog(@"Customer ID = %@ %@ %@ = Phone Number: %@",reg_info_custIDfirstNumber,reg_info_custIDsecondNumber,reg_info_custIDthirdNumber,reg_info_custIDphoneNumber);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - CREATE UI

-(void) createPersonalLabel{
    /*
     
     UILabel *accountInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 180, 25)];
     [accountInfoLabel setFont:[UIFont fontWithName:nil size:20.0f]];
     [accountInfoLabel setTextAlignment:NSTextAlignmentCenter];
     [accountInfoLabel setTextColor:[UIColor redColor]];
     [accountInfoLabel setText:@"Profile Information"];
     */
    
    //ProfileInformationLabel
    
    
    
    if ( IDIOM == IPAD ) {
        NSLog(@"IPAD NI");
        UILabel *personalInfo = [[UILabel alloc] initWithFrame:CGRectMake(-45, 10, 500, 40)];
        [personalInfo setFont:[UIFont fontWithName:nil size:24.0f]];
        [personalInfo setTextAlignment:NSTextAlignmentCenter];
        [personalInfo setTextColor:[UIColor redColor]];
        [personalInfo setText:@"Profile Information"];
        
        
        
        UILabel *profileFirstName = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.27, 50, 500, 40)];
        [profileFirstName setFont:[UIFont fontWithName:nil size:24.0f]];
        [profileFirstName setTextColor:[UIColor grayColor]];
        [profileFirstName setText:@"First Name: "];
        
        UILabel *profileMiddleName = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.27, 90, 500, 40)];
        [profileMiddleName setFont:[UIFont fontWithName:nil size:24.0f]];
        [profileMiddleName setTextColor:[UIColor grayColor]];
        [profileMiddleName setText:@"Middle Name: "];
        
        UILabel *profileLastName = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.27, 130, 500, 40)];
        [profileLastName setFont:[UIFont fontWithName:nil size:24.0f]];
        [profileLastName setTextColor:[UIColor grayColor]];
        [profileLastName setText:@"Last Name: "];
        
        UILabel *profileGender = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.27, 170, 500, 40)];
        [profileGender setFont:[UIFont fontWithName:nil size:24.0f]];
        [profileGender setTextColor:[UIColor grayColor]];
        [profileGender setText:@"Gender: "];
        
        UILabel *profileBirthdate = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.27, 210, 500, 40)];
        [profileBirthdate setFont:[UIFont fontWithName:nil size:24.0f]];
        [profileBirthdate setTextColor:[UIColor grayColor]];
        [profileBirthdate setText:@"Birthdate: "];
        
        UILabel *profileNationality = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.27, 250, 500, 40)];
        [profileNationality setFont:[UIFont fontWithName:nil size:24.0f]];
        [profileNationality setTextColor:[UIColor grayColor]];
        [profileNationality setText:@"Nationality: "];
        
        UILabel *profileWork = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.27, 290, 500, 40)];
        [profileWork setFont:[UIFont fontWithName:nil size:24.0f]];
        [profileWork setTextColor:[UIColor grayColor]];
        [profileWork setText:@"Nature of Work: "];
        
        
        //Location Information
        
        UILabel *locationInfo = [[UILabel alloc] initWithFrame:CGRectMake(-35, 330, 500, 40)];
        [locationInfo setFont:[UIFont fontWithName:nil size:24.0f]];
        [locationInfo setTextAlignment:NSTextAlignmentCenter];
        [locationInfo setTextColor:[UIColor redColor]];
        [locationInfo setText:@"Location Information"];
        
        UILabel *profileCountry = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.27, 370, 500, 40)];
        [profileCountry setFont:[UIFont fontWithName:nil size:24.0f]];
        [profileCountry setTextColor:[UIColor grayColor]];
        [profileCountry setText:@"Country: "];
        
        UILabel *profileProvince = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.27, 410, 500, 40)];
        [profileProvince setFont:[UIFont fontWithName:nil size:24.0f]];
        [profileProvince setTextColor:[UIColor grayColor]];
        [profileProvince setText:@"Province: "];
        
        UILabel *profileAddress = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.27, 450, 500, 40)];
        [profileAddress setFont:[UIFont fontWithName:nil size:24.0f]];
        [profileAddress setTextColor:[UIColor grayColor]];
        [profileAddress setText:@"Address: "];
        
        UILabel *profileZipcode = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.27, 490, 500, 40)];
        [profileZipcode setFont:[UIFont fontWithName:nil size:24.0f]];
        [profileZipcode setTextColor:[UIColor grayColor]];
        [profileZipcode setText:@"Zipcode: "];
        
        //Contact Information
        
        UILabel *contactInfo = [[UILabel alloc] initWithFrame:CGRectMake(-38, 530, 500, 40)];
        [contactInfo setFont:[UIFont fontWithName:nil size:24.0f]];
        [contactInfo setTextAlignment:NSTextAlignmentCenter];
        [contactInfo setTextColor:[UIColor redColor]];
        [contactInfo setText:@"Contact Information"];
        
        UILabel *profileEmail = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.27, 570, 500, 40)];
        [profileEmail setFont:[UIFont fontWithName:nil size:24.0f]];
        [profileEmail setTextColor:[UIColor grayColor]];
        [profileEmail setText:@"Email Address: "];
        
        UILabel *profileNumber = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.27, 610, 500, 40)];
        [profileNumber setFont:[UIFont fontWithName:nil size:24.0f]];
        [profileNumber setTextColor:[UIColor grayColor]];
        [profileNumber setText:@"Mobile Number: "];
        
        
        
        [profileScroll addSubview:personalInfo];
        [profileScroll addSubview:locationInfo];
        [profileScroll addSubview:contactInfo];
        
        [profileScroll addSubview:profileFirstName];
        [profileScroll addSubview:profileMiddleName];
        [profileScroll addSubview:profileLastName];
        [profileScroll addSubview:profileCountry];
        [profileScroll addSubview:profileProvince];
        [profileScroll addSubview:profileAddress];
        [profileScroll addSubview:profileZipcode];
        [profileScroll addSubview:profileGender];
        [profileScroll addSubview:profileBirthdate];
        [profileScroll addSubview:profileNumber];
        [profileScroll addSubview:profileEmail];
        [profileScroll addSubview:profileWork];
        [profileScroll addSubview:profileNationality];
        
        
        
        
        
        
    }
    else {
        NSLog(@"IPHONE NI");
        UILabel *personalInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 150, 25)];
        [personalInfo setFont:[UIFont fontWithName:nil size:15.0f]];
        [personalInfo setTextAlignment:NSTextAlignmentCenter];
        [personalInfo setTextColor:[UIColor redColor]];
        [personalInfo setText:@"Profile Information"];
        
        
        UILabel *profileFirstName = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 100, 25)];
        [profileFirstName setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileFirstName setTextColor:[UIColor grayColor]];
        [profileFirstName setText:@"First Name: "];
        
        UILabel *profileMiddleName = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 100, 25)];
        [profileMiddleName setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileMiddleName setTextColor:[UIColor grayColor]];
        [profileMiddleName setText:@"Middle Name: "];
        
        UILabel *profileLastName = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 100, 25)];
        [profileLastName setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileLastName setTextColor:[UIColor grayColor]];
        [profileLastName setText:@"Last Name: "];
        
        UILabel *profileGender = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 100, 25)];
        [profileGender setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileGender setTextColor:[UIColor grayColor]];
        [profileGender setText:@"Gender: "];
        
        UILabel *profileBirthdate = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 100, 25)];
        [profileBirthdate setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileBirthdate setTextColor:[UIColor grayColor]];
        [profileBirthdate setText:@"Birthdate: "];
        
        UILabel *profileNationality = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 100, 25)];
        [profileNationality setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileNationality setTextColor:[UIColor grayColor]];
        [profileNationality setText:@"Nationality: "];
        
        UILabel *profileWork = [[UILabel alloc] initWithFrame:CGRectMake(20, 210, 100, 25)];
        [profileWork setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileWork setTextColor:[UIColor grayColor]];
        [profileWork setText:@"Nature of Work: "];
        
        //Location Information
        UILabel *locationInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 240, 150, 25)];
        [locationInfo setFont:[UIFont fontWithName:nil size:15.0f]];
        [locationInfo setTextAlignment:NSTextAlignmentCenter];
        [locationInfo setTextColor:[UIColor redColor]];
        [locationInfo setText:@"Location Information"];
        
        
        UILabel *profileCountry = [[UILabel alloc] initWithFrame:CGRectMake(20, 270, 100, 25)];
        [profileCountry setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileCountry setTextColor:[UIColor grayColor]];
        [profileCountry setText:@"Country: "];
        
        UILabel *profileProvince = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 100, 25)];
        [profileProvince setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileProvince setTextColor:[UIColor grayColor]];
        [profileProvince setText:@"Province: "];
        
        UILabel *profileAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, 330, 100, 25)];
        [profileAddress setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileAddress setTextColor:[UIColor grayColor]];
        [profileAddress setText:@"Address: "];
        
        UILabel *profileZipcode = [[UILabel alloc] initWithFrame:CGRectMake(20, 360, 100, 25)];
        [profileZipcode setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileZipcode setTextColor:[UIColor grayColor]];
        [profileZipcode setText:@"Zipcode: "];
        
        //Contact Information
        
        UILabel *contactInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 390, 150, 25)];
        [contactInfo setFont:[UIFont fontWithName:nil size:15.0f]];
        [contactInfo setTextAlignment:NSTextAlignmentCenter];
        [contactInfo setTextColor:[UIColor redColor]];
        [contactInfo setText:@"Contact Information"];
        
        UILabel *profileEmail = [[UILabel alloc] initWithFrame:CGRectMake(20, 420, 100, 25)];
        [profileEmail setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileEmail setTextColor:[UIColor grayColor]];
        [profileEmail setText:@"Email Address: "];
        
        
        
        UILabel *profileNumber = [[UILabel alloc] initWithFrame:CGRectMake(20, 450, 100, 25)];
        [profileNumber setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileNumber setTextColor:[UIColor grayColor]];
        [profileNumber setText:@"Mobile Number: "];
        
        
        [profileScroll addSubview:personalInfo];
        [profileScroll addSubview:locationInfo];
        [profileScroll addSubview:contactInfo];
        
        [profileScroll addSubview:profileFirstName];
        [profileScroll addSubview:profileMiddleName];
        [profileScroll addSubview:profileLastName];
        [profileScroll addSubview:profileCountry];
        [profileScroll addSubview:profileProvince];
        [profileScroll addSubview:profileAddress];
        [profileScroll addSubview:profileZipcode];
        [profileScroll addSubview:profileGender];
        [profileScroll addSubview:profileBirthdate];
        [profileScroll addSubview:profileNumber];
        [profileScroll addSubview:profileEmail];
        [profileScroll addSubview:profileWork];
        [profileScroll addSubview:profileNationality];
        
        
    }
    
    
    
    
    
}




-(void) createPersonalValue{
    
    if ( IDIOM == IPAD ) {
        NSLog(@"IPAD NI");
        
        //ProfileInformationLabel
        
        UILabel *firstName = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+180, 50, 180, 40)];
        [firstName setFont:[UIFont fontWithName:nil size:24.0f]];
        [firstName setText:[NSString stringWithFormat:@"%@",reg_info_str_firstName]];
        
        UILabel *middleName = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+180, 90, 180, 40)];
        [middleName setFont:[UIFont fontWithName:nil size:24.0f]];
        [middleName setText:[NSString stringWithFormat:@"%@",reg_info_str_middleName]];
        
        UILabel *lastName = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+180, 130, 180, 40)];
        [lastName setFont:[UIFont fontWithName:nil size:24.0f]];
        [lastName setText:[NSString stringWithFormat:@"%@",reg_info_str_lastName]];
        
        UILabel *gender = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+180, 170, 180, 40)];
        [gender setFont:[UIFont fontWithName:nil size:24.0f]];
        [gender setText:[NSString stringWithFormat:@"%@",reg_info_str_gender]];
        
        UILabel *birthdate = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+180, 210, 180, 40)];
        [birthdate setFont:[UIFont fontWithName:nil size:24.0f]];
        [birthdate setText:[NSString stringWithFormat:@"%@",reg_info_str_birthdate]];
        
        UILabel *nationality = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+180, 250, 180, 40)];
        [nationality setFont:[UIFont fontWithName:nil size:24.0f]];
        [nationality setText:[NSString stringWithFormat:@"%@",reg_info_str_nationality]];
        
        UILabel *work = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+180, 290, 180, 40)];
        [work setFont:[UIFont fontWithName:nil size:24.0f]];
        [work setText:[NSString stringWithFormat:@"%@",reg_info_str_work]];
        
        
        //Location Information
        UILabel *country = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+180, 370, 180, 40)];
        [country setFont:[UIFont fontWithName:nil size:24.0f]];
        [country setText:[NSString stringWithFormat:@"%@",reg_info_str_country]];
        
        UILabel *province = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+180, 410, 180, 40)];
        [province setFont:[UIFont fontWithName:nil size:24.0f]];
        [province setText:[NSString stringWithFormat:@"%@",reg_info_str_province]];
        
        UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+180, 450, 180, 40)];
        [address setFont:[UIFont fontWithName:nil size:24.0f]];
        [address setText:[NSString stringWithFormat:@"%@",reg_info_str_address]];
        
        UILabel *zipcode = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+180, 490, 180, 40)];
        [zipcode setFont:[UIFont fontWithName:nil size:24.0f]];
        [zipcode setText:[NSString stringWithFormat:@"%@",reg_info_str_zipcode]];
        
        //Contact Information
        
        email = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+180, 570, 500, 40)];
        [email setFont:[UIFont fontWithName:nil size:24.0f]];
        [email setText:[NSString stringWithFormat:@"%@",reg_info_str_email]];
        
        
        UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+180, 610, 180, 40)];
        [number setFont:[UIFont fontWithName:nil size:24.0f]];
        [number setText:[NSString stringWithFormat:@"%@",reg_info_str_number]];
        
        [profileScroll addSubview:firstName];
        [profileScroll addSubview:middleName];
        [profileScroll addSubview:lastName];
        [profileScroll addSubview:country];
        [profileScroll addSubview:province];
        [profileScroll addSubview:address];
        [profileScroll addSubview:zipcode];
        [profileScroll addSubview:gender];
        [profileScroll addSubview:birthdate];
        [profileScroll addSubview:number];
        [profileScroll addSubview:email];
        [profileScroll addSubview:work];
        [profileScroll addSubview:nationality];
        
    }
    else {
        NSLog(@"IPHONE NI");
        
        //ProfileInformationLabel
        
        UILabel *firstName = [[UILabel alloc] initWithFrame:CGRectMake(140, 30, 180, 25)];
        [firstName setFont:[UIFont fontWithName:nil size:13.0f]];
        [firstName setText:[NSString stringWithFormat:@"%@",reg_info_str_firstName]];

        
        UILabel *middleName = [[UILabel alloc] initWithFrame:CGRectMake(140, 60, 180, 25)];
        [middleName setFont:[UIFont fontWithName:nil size:13.0f]];
        [middleName setText:[NSString stringWithFormat:@"%@",reg_info_str_middleName]];
        
        UILabel *lastName = [[UILabel alloc] initWithFrame:CGRectMake(140, 90, 180, 25)];
        [lastName setFont:[UIFont fontWithName:nil size:13.0f]];
        [lastName setText:[NSString stringWithFormat:@"%@",reg_info_str_lastName]];
        
        UILabel *gender = [[UILabel alloc] initWithFrame:CGRectMake(140, 120, 180, 25)];
        [gender setFont:[UIFont fontWithName:nil size:13.0f]];
        [gender setText:[NSString stringWithFormat:@"%@",reg_info_str_gender]];
        
        UILabel *birthdate = [[UILabel alloc] initWithFrame:CGRectMake(140, 150, 180, 25)];
        [birthdate setFont:[UIFont fontWithName:nil size:13.0f]];
        [birthdate setText:[NSString stringWithFormat:@"%@",reg_info_str_birthdate]];
        
        UILabel *nationality = [[UILabel alloc] initWithFrame:CGRectMake(140, 180, 180, 25)];
        [nationality setFont:[UIFont fontWithName:nil size:13.0f]];
        [nationality setText:[NSString stringWithFormat:@"%@",reg_info_str_nationality]];
        
        UILabel *work = [[UILabel alloc] initWithFrame:CGRectMake(140, 210, 180, 25)];
        [work setFont:[UIFont fontWithName:nil size:13.0f]];
        [work setText:[NSString stringWithFormat:@"%@",reg_info_str_work]];
        
        //Location Information
        
        
        UILabel *country = [[UILabel alloc] initWithFrame:CGRectMake(140, 270, 180, 25)];
        [country setFont:[UIFont fontWithName:nil size:13.0f]];
        [country setText:[NSString stringWithFormat:@"%@",reg_info_str_country]];
        
        UILabel *province = [[UILabel alloc] initWithFrame:CGRectMake(140, 300, 180, 25)];
        [province setFont:[UIFont fontWithName:nil size:13.0f]];
        [province setText:[NSString stringWithFormat:@"%@",reg_info_str_province]];
        
        UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(140, 330, 180, 25)];
        [address setFont:[UIFont fontWithName:nil size:13.0f]];
        [address setText:[NSString stringWithFormat:@"%@",reg_info_str_address]];
        
        UILabel *zipcode = [[UILabel alloc] initWithFrame:CGRectMake(140, 360, 180, 25)];
        [zipcode setFont:[UIFont fontWithName:nil size:13.0f]];
        [zipcode setText:[NSString stringWithFormat:@"%@",reg_info_str_zipcode]];
        
        //Contact Information
        email = [[UILabel alloc] initWithFrame:CGRectMake(140, 420, 180, 25)];
//        UILabel *email = [[UILabel alloc] initWithFrame:CGRectMake(130, 420, 180, 25)];
        [email setFont:[UIFont fontWithName:nil size:13.0f]];
        [email setText:[NSString stringWithFormat:@"%@",reg_info_str_email]];
        
        
        UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(140, 450, 180, 25)];
        [number setFont:[UIFont fontWithName:nil size:13.0f]];
        [number setText:[NSString stringWithFormat:@"%@",reg_info_str_number]];
        
        
        
        
        
        [profileScroll addSubview:firstName];
        [profileScroll addSubview:middleName];
        [profileScroll addSubview:lastName];
        [profileScroll addSubview:country];
        [profileScroll addSubview:province];
        [profileScroll addSubview:address];
        [profileScroll addSubview:zipcode];
        [profileScroll addSubview:gender];
        [profileScroll addSubview:birthdate];
        [profileScroll addSubview:number];
        [profileScroll addSubview:email];
        [profileScroll addSubview:work];
        [profileScroll addSubview:nationality];
        
    }
    
    

    
    
}

-(void) addNavigationBar{
    self.title = @"Registration Information";
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                                         initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    //next navigation button
    UIBarButtonItem *btnNext = [[UIBarButtonItem alloc] initWithTitle:
                                @"Next"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(gotoNextView)];
    self.navigationItem.rightBarButtonItem = btnNext;
    
    //Set Background
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        
        if ([UIScreen mainScreen].bounds.size.height == 568) //4 inch
        {
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground1.png"]]];
        }
        else //4 inc below
        {
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground2.png"]]];
        }
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground5.png"]]];
    }
    
}
-(void) backPressed{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void) gotoNextView{
    NSLog(@"Next ni Bai! -- %@",email.text);
    QuestionsActivity *questAct = [[QuestionsActivity alloc] initWithNibName:@"QuestionsActivity" bundle:nil];
    questAct.quest_act_custIDfirstNumber = reg_info_custIDfirstNumber;
    questAct.quest_act_custIDsecondNumber = reg_info_custIDsecondNumber;
    questAct.quest_act_custIDthirdNumber = reg_info_custIDthirdNumber;
    questAct.quest_act_custIDphoneNumber = reg_info_custIDphoneNumber;
    
    questAct.quest_act_firstName = reg_info_str_firstName;
    questAct.quest_act_middleName = reg_info_str_middleName;
    questAct.quest_act_lastName = reg_info_str_lastName;
    questAct.quest_act_country = reg_info_str_country;
    questAct.quest_act_province = reg_info_str_province;
    questAct.quest_act_address = reg_info_str_address;
    questAct.quest_act_zipcode = reg_info_str_zipcode;
    questAct.quest_act_gender = reg_info_str_gender;
    questAct.quest_act_birthdate = reg_info_str_birthdate;
    questAct.quest_act_number = reg_info_str_number;
    questAct.quest_act_email = email.text;
    questAct.quest_act_work = reg_info_str_work;
    questAct.quest_act_nationality = reg_info_str_nationality;

    
    questAct.quest_act_str_photo1 = reg_info_str_photo1;
    questAct.quest_act_str_photo2 = reg_info_str_photo2;
    questAct.quest_act_str_photo3 = reg_info_str_photo3;
    questAct.quest_act_str_photo4 = reg_info_str_photo4;
    questAct.quest_act_str_balance = reg_info_str_balance;
    questAct.quest_act_str_secanswer1 = reg_info_str_secanswer1;
    questAct.quest_act_str_secanswer2 = reg_info_str_secanswer2;
    questAct.quest_act_str_secanswer3 = reg_info_str_secanswer3;
    questAct.quest_act_str_secquestion1 = reg_info_str_secquestion1;
    questAct.quest_act_str_secquestion2 = reg_info_str_secquestion2;
    questAct.quest_act_str_secquestion3 = reg_info_str_secquestion3;
    questAct.quest_act_str_walletno = reg_info_str_walletno;
     NSLog(@"Ang Wallet Number ----- %@",reg_info_str_walletno);

    [self.navigationController pushViewController:questAct animated:YES];
    
    
}

-(void)checkEmail{
    if([reg_info_str_email isEqualToString:@""]){
//        [UIAlertView myCostumeAlert:@"Update" alertMessage:@"Your account has currently no email. Please enter your email below." delegate:nil cancelButton:@"Ok" otherButtons:nil];
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update"
                                                        message:@"Your account has currently no email. Please enter your email below."
                                                       delegate:self
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
        
    }

}
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%@", [alertView textFieldAtIndex:0].text);
    
    str_email_add = [alertView textFieldAtIndex:0].text;
    if([self NSStringIsValidEmail:str_email_add]){
       [email setText:[NSString stringWithFormat:@"%@",[alertView textFieldAtIndex:0].text]];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Invalid Email."
                                                       delegate:self
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
}



- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
