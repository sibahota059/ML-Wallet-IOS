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


ProfileLabel *firstName, *middleName, *lastName, *country, *province, *address, *zipcode, *gender, *birthdate, *age, *mobileNumber, *email, *work, *nationality;


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
    [self setNextViewController:questionsActivity myImage:[UIImage imageNamed:@"next.png"]];
    
    [self createPersonalLabel];
    [self createPersonalValue];
    //
    self.title = @"User Information";
    [self.view addSubview:profileScroll];
    
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
        
        UILabel *profileFirstName = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 10, 100, 25)];
        [profileFirstName setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileFirstName setTextColor:[UIColor grayColor]];
        [profileFirstName setText:@"First Name: "];
        
        UILabel *profileMiddleName = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 30, 100, 25)];
        [profileMiddleName setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileMiddleName setTextColor:[UIColor grayColor]];
        [profileMiddleName setText:@"Middle Name: "];
        
        UILabel *profileLastName = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 50, 100, 25)];
        [profileLastName setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileLastName setTextColor:[UIColor grayColor]];
        [profileLastName setText:@"Last Name: "];
        
        UILabel *profileCountry = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 70, 100, 25)];
        [profileCountry setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileCountry setTextColor:[UIColor grayColor]];
        [profileCountry setText:@"Country: "];
        
        UILabel *profileProvince = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 90, 100, 25)];
        [profileProvince setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileProvince setTextColor:[UIColor grayColor]];
        [profileProvince setText:@"Province: "];
        
        UILabel *profileAddress = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 110, 100, 25)];
        [profileAddress setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileAddress setTextColor:[UIColor grayColor]];
        [profileAddress setText:@"Address: "];
        
        UILabel *profileZipcode = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 130, 100, 25)];
        [profileZipcode setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileZipcode setTextColor:[UIColor grayColor]];
        [profileZipcode setText:@"Zipcode: "];
        
        UILabel *profileGender = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 150, 100, 25)];
        [profileGender setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileGender setTextColor:[UIColor grayColor]];
        [profileGender setText:@"Gender: "];
        
        UILabel *profileBirthdate = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 170, 100, 25)];
        [profileBirthdate setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileBirthdate setTextColor:[UIColor grayColor]];
        [profileBirthdate setText:@"Birthdate: "];
        
        UILabel *profileAge = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 190, 180, 25)];
        [profileAge setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileAge setTextColor:[UIColor grayColor]];
        [profileAge setText:@"Age: "];
        
        UILabel *profileNumber = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 210, 100, 25)];
        [profileNumber setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileNumber setTextColor:[UIColor grayColor]];
        [profileNumber setText:@"Mobile Number: "];
        
        UILabel *profileEmail = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 230, 100, 25)];
        [profileEmail setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileEmail setTextColor:[UIColor grayColor]];
        [profileEmail setText:@"Email Address: "];
        
        UILabel *profileWork = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 250, 100, 25)];
        [profileWork setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileWork setTextColor:[UIColor grayColor]];
        [profileWork setText:@"Nature of Work: "];
        
        UILabel *profileNationality = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*.3, 270, 100, 25)];
        [profileNationality setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileNationality setTextColor:[UIColor grayColor]];
        [profileNationality setText:@"Nationality: "];
        
        
        //   [profileScroll addSubview:accountInfoLabel];
        
        [profileScroll addSubview:profileFirstName];
        [profileScroll addSubview:profileMiddleName];
        [profileScroll addSubview:profileLastName];
        [profileScroll addSubview:profileCountry];
        [profileScroll addSubview:profileProvince];
        [profileScroll addSubview:profileAddress];
        [profileScroll addSubview:profileZipcode];
        [profileScroll addSubview:profileGender];
        [profileScroll addSubview:profileBirthdate];
        [profileScroll addSubview:profileAge];
        [profileScroll addSubview:profileNumber];
        [profileScroll addSubview:profileEmail];
        [profileScroll addSubview:profileWork];
        [profileScroll addSubview:profileNationality];
        
    }
    else {
        NSLog(@"IPHONE NI");
        
        UILabel *profileFirstName = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 25)];
        [profileFirstName setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileFirstName setTextColor:[UIColor grayColor]];
        [profileFirstName setText:@"First Name: "];
        
        UILabel *profileMiddleName = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 100, 25)];
        [profileMiddleName setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileMiddleName setTextColor:[UIColor grayColor]];
        [profileMiddleName setText:@"Middle Name: "];
        
        UILabel *profileLastName = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 100, 25)];
        [profileLastName setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileLastName setTextColor:[UIColor grayColor]];
        [profileLastName setText:@"Last Name: "];
        
        UILabel *profileCountry = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 100, 25)];
        [profileCountry setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileCountry setTextColor:[UIColor grayColor]];
        [profileCountry setText:@"Country: "];
        
        UILabel *profileProvince = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 100, 25)];
        [profileProvince setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileProvince setTextColor:[UIColor grayColor]];
        [profileProvince setText:@"Province: "];
        
        UILabel *profileAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 100, 25)];
        [profileAddress setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileAddress setTextColor:[UIColor grayColor]];
        [profileAddress setText:@"Address: "];
        
        UILabel *profileZipcode = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 100, 25)];
        [profileZipcode setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileZipcode setTextColor:[UIColor grayColor]];
        [profileZipcode setText:@"Zipcode: "];
        
        UILabel *profileGender = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 100, 25)];
        [profileGender setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileGender setTextColor:[UIColor grayColor]];
        [profileGender setText:@"Gender: "];
        
        UILabel *profileBirthdate = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 100, 25)];
        [profileBirthdate setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileBirthdate setTextColor:[UIColor grayColor]];
        [profileBirthdate setText:@"Birthdate: "];
        
        UILabel *profileAge = [[UILabel alloc] initWithFrame:CGRectMake(20, 190, 180, 25)];
        [profileAge setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileAge setTextColor:[UIColor grayColor]];
        [profileAge setText:@"Age: "];
        
        UILabel *profileNumber = [[UILabel alloc] initWithFrame:CGRectMake(20, 210, 100, 25)];
        [profileNumber setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileNumber setTextColor:[UIColor grayColor]];
        [profileNumber setText:@"Mobile Number: "];
        
        UILabel *profileEmail = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 100, 25)];
        [profileEmail setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileEmail setTextColor:[UIColor grayColor]];
        [profileEmail setText:@"Email Address: "];
        
        UILabel *profileWork = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, 100, 25)];
        [profileWork setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileWork setTextColor:[UIColor grayColor]];
        [profileWork setText:@"Nature of Work: "];
        
        UILabel *profileNationality = [[UILabel alloc] initWithFrame:CGRectMake(20, 270, 100, 25)];
        [profileNationality setFont:[UIFont fontWithName:nil size:13.0f]];
        [profileNationality setTextColor:[UIColor grayColor]];
        [profileNationality setText:@"Nationality: "];
        
        
        //   [profileScroll addSubview:accountInfoLabel];
        
        [profileScroll addSubview:profileFirstName];
        [profileScroll addSubview:profileMiddleName];
        [profileScroll addSubview:profileLastName];
        [profileScroll addSubview:profileCountry];
        [profileScroll addSubview:profileProvince];
        [profileScroll addSubview:profileAddress];
        [profileScroll addSubview:profileZipcode];
        [profileScroll addSubview:profileGender];
        [profileScroll addSubview:profileBirthdate];
        [profileScroll addSubview:profileAge];
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
        
        UILabel *firstName = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 10, 180, 25)];
        [firstName setFont:[UIFont fontWithName:nil size:13.0f]];
        [firstName setText:@"Harry"];
        
        UILabel *middleName = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 30, 180, 25)];
        [middleName setFont:[UIFont fontWithName:nil size:13.0f]];
        [middleName setText:@"Cobrado"];
        
        UILabel *lastName = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 50, 180, 25)];
        [lastName setFont:[UIFont fontWithName:nil size:13.0f]];
        [lastName setText:@"Lingad"];
        
        UILabel *country = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 70, 180, 25)];
        [country setFont:[UIFont fontWithName:nil size:13.0f]];
        [country setText:@"Phillipines"];
        
        UILabel *province = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 90, 180, 25)];
        [province setFont:[UIFont fontWithName:nil size:13.0f]];
        [province setText:@"Davao"];
        
        UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 110, 180, 25)];
        [address setFont:[UIFont fontWithName:nil size:13.0f]];
        [address setText:@"Manalili Cebu City"];
        
        UILabel *zipcode = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 130, 180, 25)];
        [zipcode setFont:[UIFont fontWithName:nil size:13.0f]];
        [zipcode setText:@"6000"];
        
        UILabel *gender = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 150, 180, 25)];
        [gender setFont:[UIFont fontWithName:nil size:13.0f]];
        [gender setText:@"Male"];
        
        UILabel *birthdate = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 170, 180, 25)];
        [birthdate setFont:[UIFont fontWithName:nil size:13.0f]];
        [birthdate setText:@"Nov. 11, 1985"];
        
        UILabel *age = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 190, 180, 25)];
        [age setFont:[UIFont fontWithName:nil size:13.0f]];
        [age setText:@"19"];
        
        UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 210, 180, 25)];
        [number setFont:[UIFont fontWithName:nil size:13.0f]];
        [number setText:@"09273444456"];
        
        UILabel *email = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 230, 180, 25)];
        [email setFont:[UIFont fontWithName:nil size:13.0f]];
        [email setText:@"harry@yahoo.com"];
        
        UILabel *work = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 250, 180, 25)];
        [work setFont:[UIFont fontWithName:nil size:13.0f]];
        [work setText:@"Programmer"];
        
        UILabel *nationality = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth*.3)+110, 270, 180, 25)];
        [nationality setFont:[UIFont fontWithName:nil size:13.0f]];
        [nationality setText:@"Phillipines"];
        
        
        
        
        
        
        [profileScroll addSubview:firstName];
        [profileScroll addSubview:middleName];
        [profileScroll addSubview:lastName];
        [profileScroll addSubview:country];
        [profileScroll addSubview:province];
        [profileScroll addSubview:address];
        [profileScroll addSubview:zipcode];
        [profileScroll addSubview:gender];
        [profileScroll addSubview:birthdate];
        [profileScroll addSubview:age];
        [profileScroll addSubview:number];
        [profileScroll addSubview:email];
        [profileScroll addSubview:work];
        [profileScroll addSubview:nationality];
        
    }
    else {
        NSLog(@"IPHONE NI");
        
        //ProfileInformationLabel
        
        UILabel *firstName = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, 180, 25)];
        [firstName setFont:[UIFont fontWithName:nil size:13.0f]];
        [firstName setText:@"Harry"];
        
        UILabel *middleName = [[UILabel alloc] initWithFrame:CGRectMake(130, 30, 180, 25)];
        [middleName setFont:[UIFont fontWithName:nil size:13.0f]];
        [middleName setText:@"Cobrado"];
        
        UILabel *lastName = [[UILabel alloc] initWithFrame:CGRectMake(130, 50, 180, 25)];
        [lastName setFont:[UIFont fontWithName:nil size:13.0f]];
        [lastName setText:@"Lingad"];
        
        UILabel *country = [[UILabel alloc] initWithFrame:CGRectMake(130, 70, 180, 25)];
        [country setFont:[UIFont fontWithName:nil size:13.0f]];
        [country setText:@"Phillipines"];
        
        UILabel *province = [[UILabel alloc] initWithFrame:CGRectMake(130, 90, 180, 25)];
        [province setFont:[UIFont fontWithName:nil size:13.0f]];
        [province setText:@"Davao"];
        
        UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(130, 110, 180, 25)];
        [address setFont:[UIFont fontWithName:nil size:13.0f]];
        [address setText:@"Manalili Cebu City"];
        
        UILabel *zipcode = [[UILabel alloc] initWithFrame:CGRectMake(130, 130, 180, 25)];
        [zipcode setFont:[UIFont fontWithName:nil size:13.0f]];
        [zipcode setText:@"6000"];
        
        UILabel *gender = [[UILabel alloc] initWithFrame:CGRectMake(130, 150, 180, 25)];
        [gender setFont:[UIFont fontWithName:nil size:13.0f]];
        [gender setText:@"Male"];
        
        UILabel *birthdate = [[UILabel alloc] initWithFrame:CGRectMake(130, 170, 180, 25)];
        [birthdate setFont:[UIFont fontWithName:nil size:13.0f]];
        [birthdate setText:@"Nov. 11, 1985"];
        
        UILabel *age = [[UILabel alloc] initWithFrame:CGRectMake(130, 190, 180, 25)];
        [age setFont:[UIFont fontWithName:nil size:13.0f]];
        [age setText:@"19"];
        
        UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(130, 210, 180, 25)];
        [number setFont:[UIFont fontWithName:nil size:13.0f]];
        [number setText:@"09273444456"];
        
        UILabel *email = [[UILabel alloc] initWithFrame:CGRectMake(130, 230, 180, 25)];
        [email setFont:[UIFont fontWithName:nil size:13.0f]];
        [email setText:@"harry@yahoo.com"];
        
        UILabel *work = [[UILabel alloc] initWithFrame:CGRectMake(130, 250, 180, 25)];
        [work setFont:[UIFont fontWithName:nil size:13.0f]];
        [work setText:@"Programmer"];
        
        UILabel *nationality = [[UILabel alloc] initWithFrame:CGRectMake(130, 270, 180, 25)];
        [nationality setFont:[UIFont fontWithName:nil size:13.0f]];
        [nationality setText:@"Phillipines"];
        

        [profileScroll addSubview:firstName];
        [profileScroll addSubview:middleName];
        [profileScroll addSubview:lastName];
        [profileScroll addSubview:country];
        [profileScroll addSubview:province];
        [profileScroll addSubview:address];
        [profileScroll addSubview:zipcode];
        [profileScroll addSubview:gender];
        [profileScroll addSubview:birthdate];
        [profileScroll addSubview:age];
        [profileScroll addSubview:number];
        [profileScroll addSubview:email];
        [profileScroll addSubview:work];
        [profileScroll addSubview:nationality];
        
    }
    
    
    
    
    
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
