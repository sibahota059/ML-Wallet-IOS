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
@synthesize custIDfirstNumber;
@synthesize custIDsecondNumber;
@synthesize custIDthirdNumber;
@synthesize custIDphoneNumber;
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


UITextField *firstName, *middleName, *lastName, *country, *province, *address, *zipcode, *gender, *birthdate, *mobileNumber, *email, *work, *nationality,*number;


ProfileOutline *firstNameO, *middleNameO, *lastNameO, *countryO, *provinceO, *addressO, *zipcodeO, *genderO, *birthdateO, *ageO, *mobileNumberO, *emailO, *workO, *nationalityO;
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
    NSLog(@"Customer ID = %@ %@ %@ = Phone Number: %@",custIDfirstNumber,custIDsecondNumber,custIDthirdNumber,custIDphoneNumber);
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
        UILabel *personalInfo = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 10, 170, 25)];
        [personalInfo setFont:[UIFont fontWithName:nil size:20.0f]];
        [personalInfo setTextAlignment:NSTextAlignmentCenter];
        [personalInfo setTextColor:[UIColor redColor]];
        [personalInfo setText:@"Profile Information"];
        
        
        
        UILabel *profileFirstName = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 30, 100, 25)];
        [profileFirstName setFont:[UIFont fontWithName:nil size:18.0f]];
        [profileFirstName setTextColor:[UIColor grayColor]];
        [profileFirstName setText:@"First Name: "];
        
        UILabel *profileMiddleName = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 50, 100, 25)];
        [profileMiddleName setFont:[UIFont fontWithName:nil size:18.0f]];
        [profileMiddleName setTextColor:[UIColor grayColor]];
        [profileMiddleName setText:@"Middle Name: "];
        
        UILabel *profileLastName = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 70, 100, 25)];
        [profileLastName setFont:[UIFont fontWithName:nil size:18.0f]];
        [profileLastName setTextColor:[UIColor grayColor]];
        [profileLastName setText:@"Last Name: "];
        
        UILabel *profileGender = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 90, 100, 25)];
        [profileGender setFont:[UIFont fontWithName:nil size:18.0f]];
        [profileGender setTextColor:[UIColor grayColor]];
        [profileGender setText:@"Gender: "];
        
        UILabel *profileBirthdate = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 110, 100, 25)];
        [profileBirthdate setFont:[UIFont fontWithName:nil size:18.0f]];
        [profileBirthdate setTextColor:[UIColor grayColor]];
        [profileBirthdate setText:@"Birthdate: "];
        
        UILabel *profileNationality = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 130, 100, 25)];
        [profileNationality setFont:[UIFont fontWithName:nil size:18.0f]];
        [profileNationality setTextColor:[UIColor grayColor]];
        [profileNationality setText:@"Nationality: "];
        
        UILabel *profileWork = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 150, 100, 25)];
        [profileWork setFont:[UIFont fontWithName:nil size:18.0f]];
        [profileWork setTextColor:[UIColor grayColor]];
        [profileWork setText:@"Nature of Work: "];
        
        
        //Location Information
        
        UILabel *locationInfo = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 170, 190, 25)];
        [locationInfo setFont:[UIFont fontWithName:nil size:20.0f]];
        [locationInfo setTextAlignment:NSTextAlignmentCenter];
        [locationInfo setTextColor:[UIColor redColor]];
        [locationInfo setText:@"Location Information"];
        
        UILabel *profileCountry = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 190, 100, 25)];
        [profileCountry setFont:[UIFont fontWithName:nil size:18.0f]];
        [profileCountry setTextColor:[UIColor grayColor]];
        [profileCountry setText:@"Country: "];
        
        UILabel *profileProvince = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 210, 100, 25)];
        [profileProvince setFont:[UIFont fontWithName:nil size:18.0f]];
        [profileProvince setTextColor:[UIColor grayColor]];
        [profileProvince setText:@"Province: "];
        
        UILabel *profileAddress = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 230, 100, 25)];
        [profileAddress setFont:[UIFont fontWithName:nil size:18.0f]];
        [profileAddress setTextColor:[UIColor grayColor]];
        [profileAddress setText:@"Address: "];
        
        UILabel *profileZipcode = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 250, 100, 25)];
        [profileZipcode setFont:[UIFont fontWithName:nil size:18.0f]];
        [profileZipcode setTextColor:[UIColor grayColor]];
        [profileZipcode setText:@"Zipcode: "];
        
        //Contact Information
        
        UILabel *contactInfo = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.28, 270, 190, 25)];
        [contactInfo setFont:[UIFont fontWithName:nil size:20.0f]];
        [contactInfo setTextAlignment:NSTextAlignmentCenter];
        [contactInfo setTextColor:[UIColor redColor]];
        [contactInfo setText:@"Contact Information"];
        
        UILabel *profileEmail = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 290, 100, 25)];
        [profileEmail setFont:[UIFont fontWithName:nil size:18.0f]];
        [profileEmail setTextColor:[UIColor grayColor]];
        [profileEmail setText:@"Email Address: "];
        
        UILabel *profileNumber = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 310, 100, 25)];
        [profileNumber setFont:[UIFont fontWithName:nil size:18.0f]];
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
        UILabel *locationInfo = [[UILabel alloc] initWithFrame:CGRectMake(5, 240, 150, 25)];
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
        
        UILabel *contactInfo = [[UILabel alloc] initWithFrame:CGRectMake(5, 390, 150, 25)];
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
        
        UILabel *firstName = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 30, 180, 25)];
        [firstName setFont:[UIFont fontWithName:nil size:18.0f]];
        [firstName setText:@"Harry"];
        
        UILabel *middleName = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 50, 180, 25)];
        [middleName setFont:[UIFont fontWithName:nil size:18.0f]];
        [middleName setText:@"Cobrado"];
        
        UILabel *lastName = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 70, 180, 25)];
        [lastName setFont:[UIFont fontWithName:nil size:18.0f]];
        [lastName setText:@"Lingad"];
        
        UILabel *gender = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 90, 180, 25)];
        [gender setFont:[UIFont fontWithName:nil size:18.0f]];
        [gender setText:@"Male"];
        
        UILabel *birthdate = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 110, 180, 25)];
        [birthdate setFont:[UIFont fontWithName:nil size:18.0f]];
        [birthdate setText:@"Nov. 11, 1985"];
        
        UILabel *nationality = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 130, 180, 25)];
        [nationality setFont:[UIFont fontWithName:nil size:18.0f]];
        [nationality setText:@"Phillipines"];
        
        UILabel *work = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 150, 180, 25)];
        [work setFont:[UIFont fontWithName:nil size:18.0f]];
        [work setText:@"Programmer"];
        
        
        //Location Information
        UILabel *country = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 190, 180, 25)];
        [country setFont:[UIFont fontWithName:nil size:18.0f]];
        [country setText:@"Phillipines"];
        
        UILabel *province = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 210, 180, 25)];
        [province setFont:[UIFont fontWithName:nil size:18.0f]];
        [province setText:@"Davao"];
        
        UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 230, 180, 25)];
        [address setFont:[UIFont fontWithName:nil size:18.0f]];
        [address setText:@"Manalili Cebu City"];
        
        UILabel *zipcode = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 250, 180, 25)];
        [zipcode setFont:[UIFont fontWithName:nil size:18.0f]];
        [zipcode setText:@"6000"];
        
        //Contact Information
        
        UILabel *email = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 290, 180, 25)];
        [email setFont:[UIFont fontWithName:nil size:18.0f]];
        [email setText:@"harry@yahoo.com"];
        
        
        UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 310, 180, 25)];
        [number setFont:[UIFont fontWithName:nil size:18.0f]];
        [number setText:@"09273444456"];
        
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
        
        firstName = [[UITextField alloc] initWithFrame:CGRectMake(130, 30, 180, 25)];
        [firstName setFont:[UIFont fontWithName:nil size:13.0f]];
        [firstName setText:@"Harry"];
        firstName.layer.cornerRadius=8.0f;
        firstName.layer.masksToBounds=YES;
        firstName.layer.borderColor=[[UIColor redColor]CGColor];
        firstName.layer.borderWidth= 1.0f;
        firstName.delegate = self;
        firstName.textAlignment = NSTextAlignmentCenter;
        
        middleName = [[UITextField alloc] initWithFrame:CGRectMake(130, 60, 180, 25)];
        [middleName setFont:[UIFont fontWithName:nil size:13.0f]];
        [middleName setText:@"Cobrado"];
        middleName.layer.cornerRadius=8.0f;
        middleName.layer.masksToBounds=YES;
        middleName.layer.borderColor=[[UIColor redColor]CGColor];
        middleName.layer.borderWidth= 1.0f;
        middleName.delegate = self;
        middleName.textAlignment = NSTextAlignmentCenter;
        
        lastName = [[UITextField alloc] initWithFrame:CGRectMake(130, 90, 180, 25)];
        [lastName setFont:[UIFont fontWithName:nil size:13.0f]];
        [lastName setText:@"Lingad"];
        lastName.layer.cornerRadius=8.0f;
        lastName.layer.masksToBounds=YES;
        lastName.layer.borderColor=[[UIColor redColor]CGColor];
        lastName.layer.borderWidth= 1.0f;
        lastName.delegate = self;
        lastName.textAlignment = NSTextAlignmentCenter;
        
        gender = [[UITextField alloc] initWithFrame:CGRectMake(130, 120, 180, 25)];
        [gender setFont:[UIFont fontWithName:nil size:13.0f]];
        [gender setText:@"Male"];
        gender.layer.cornerRadius=8.0f;
        gender.layer.masksToBounds=YES;
        gender.layer.borderColor=[[UIColor redColor]CGColor];
        gender.layer.borderWidth= 1.0f;
        gender.delegate = self;
        gender.textAlignment = NSTextAlignmentCenter;
        
        birthdate = [[UITextField alloc] initWithFrame:CGRectMake(130, 150, 180, 25)];
        [birthdate setFont:[UIFont fontWithName:nil size:13.0f]];
        [birthdate setText:@"Nov. 11, 1985"];
        birthdate.layer.cornerRadius=8.0f;
        birthdate.layer.masksToBounds=YES;
        birthdate.layer.borderColor=[[UIColor redColor]CGColor];
        birthdate.layer.borderWidth= 1.0f;
        birthdate.delegate = self;
        birthdate.textAlignment = NSTextAlignmentCenter;
        
        nationality = [[UITextField alloc] initWithFrame:CGRectMake(130, 180, 180, 25)];
        [nationality setFont:[UIFont fontWithName:nil size:13.0f]];
        [nationality setText:@"Phillipines"];
        nationality.layer.cornerRadius=8.0f;
        nationality.layer.masksToBounds=YES;
        nationality.layer.borderColor=[[UIColor redColor]CGColor];
        nationality.layer.borderWidth= 1.0f;
        nationality.delegate = self;
        nationality.textAlignment = NSTextAlignmentCenter;
        
        work = [[UITextField alloc] initWithFrame:CGRectMake(130, 210, 180, 25)];
        [work setFont:[UIFont fontWithName:nil size:13.0f]];
        [work setText:@"Programmer"];
        work.layer.cornerRadius=8.0f;
        work.layer.masksToBounds=YES;
        work.layer.borderColor=[[UIColor redColor]CGColor];
        work.layer.borderWidth= 1.0f;
        work.delegate = self;
        work.textAlignment = NSTextAlignmentCenter;
        
        //Location Information
        
        
        country = [[UITextField alloc] initWithFrame:CGRectMake(130, 270, 180, 25)];
        [country setFont:[UIFont fontWithName:nil size:13.0f]];
        [country setText:@"Phillipines"];
        country.layer.cornerRadius=8.0f;
        country.layer.masksToBounds=YES;
        country.layer.borderColor=[[UIColor redColor]CGColor];
        country.layer.borderWidth= 1.0f;
        country.delegate = self;
        country.textAlignment = NSTextAlignmentCenter;
        
        province = [[UITextField alloc] initWithFrame:CGRectMake(130, 300, 180, 25)];
        [province setFont:[UIFont fontWithName:nil size:13.0f]];
        [province setText:@"Davao"];
        province.layer.cornerRadius=8.0f;
        province.layer.masksToBounds=YES;
        province.layer.borderColor=[[UIColor redColor]CGColor];
        province.layer.borderWidth= 1.0f;
        province.delegate = self;
        province.textAlignment = NSTextAlignmentCenter;
        
        address = [[UITextField alloc] initWithFrame:CGRectMake(130, 330, 180, 25)];
        [address setFont:[UIFont fontWithName:nil size:13.0f]];
        [address setText:@"Manalili Cebu City"];
        address.layer.cornerRadius=8.0f;
        address.layer.masksToBounds=YES;
        address.layer.borderColor=[[UIColor redColor]CGColor];
        address.layer.borderWidth= 1.0f;
        address.delegate = self;
        address.textAlignment = NSTextAlignmentCenter;
        
        zipcode = [[UITextField alloc] initWithFrame:CGRectMake(130, 360, 180, 25)];
        [zipcode setFont:[UIFont fontWithName:nil size:13.0f]];
        [zipcode setText:@"6000"];
        zipcode.layer.cornerRadius=8.0f;
        zipcode.layer.masksToBounds=YES;
        zipcode.layer.borderColor=[[UIColor redColor]CGColor];
        zipcode.layer.borderWidth= 1.0f;
        zipcode.delegate = self;
        zipcode.textAlignment = NSTextAlignmentCenter;
        
        //Contact Information
        
        email = [[UITextField alloc] initWithFrame:CGRectMake(130, 420, 180, 25)];
        [email setFont:[UIFont fontWithName:nil size:13.0f]];
        [email setText:@"harry@yahoo.com"];
        email.layer.cornerRadius=8.0f;
        email.layer.masksToBounds=YES;
        email.layer.borderColor=[[UIColor redColor]CGColor];
        email.layer.borderWidth= 1.0f;
        email.delegate = self;
        email.textAlignment = NSTextAlignmentCenter;
        
        
        number = [[UITextField alloc] initWithFrame:CGRectMake(130, 450, 180, 25)];
        [number setFont:[UIFont fontWithName:nil size:13.0f]];
        [number setText:@"09273444456"];
        number.layer.cornerRadius=8.0f;
        number.layer.masksToBounds=YES;
        number.layer.borderColor=[[UIColor redColor]CGColor];
        number.layer.borderWidth= 1.0f;
        number.delegate = self;
        number.textAlignment = NSTextAlignmentCenter;
        
        
        
        
        
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
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y);
    [profileScroll setContentOffset:scrollPoint animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [profileScroll setContentOffset:CGPointZero animated:YES];

}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [firstName resignFirstResponder];
    [middleName resignFirstResponder];
    [lastName resignFirstResponder];
    [country resignFirstResponder];
    [province resignFirstResponder];
    [address resignFirstResponder];
    [zipcode resignFirstResponder];
    [gender resignFirstResponder];
    [birthdate resignFirstResponder];
    [number resignFirstResponder];
    [email resignFirstResponder];
    [work resignFirstResponder];
    [nationality resignFirstResponder];
    
    return NO;
}

-(void) addNavigationBar{
    self.title = @"Registration Information";
    /*
     UIBarButtonItem *btnHome = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self
     action:@selector(backPressed)];
     
     self.navigationItem.leftBarButtonItem = btnHome;
     */
    
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
    NSLog(@"Next ni Bai!");
    QuestionsActivity *questAct = [[QuestionsActivity alloc] initWithNibName:@"QuestionsActivity" bundle:nil];
    questAct.custIDfirstNumber = custIDfirstNumber;
    questAct.custIDsecondNumber = custIDsecondNumber;
    questAct.custIDthirdNumber = custIDthirdNumber;
    questAct.custIDphoneNumber = custIDphoneNumber;
    
    questAct.firstName = firstName.text;
    questAct.middleName = middleName.text;
    questAct.lastName = lastName.text;
    questAct.country = country.text;
    questAct.province = province.text;
    questAct.address = address.text;
    questAct.zipcode = zipcode.text;
    questAct.gender = gender.text;
    questAct.birthdate = birthdate.text;
    questAct.number = number.text;
    questAct.email = email.text;
    questAct.work = work.text;
    questAct.nationality = nationality.text;

    
    [self.navigationController pushViewController:questAct animated:YES];
    
    
}


- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
