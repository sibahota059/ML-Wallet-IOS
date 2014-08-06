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
#import "ProfileTextField.h"
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
#import "UITextfieldAnimate.h"
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
UITextfieldAnimate *textAnimate;
ProfileTextField *fullNameO, *middleNameO, *lastNameO, *countryO, *provinceO, *addressO, *zipcodeO, *genderO, *birthdateO, *ageO, *mobileNumberO, *emailO, *workO, *nationalityO;

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

    self.title = @"Registration Information";
    
    QuestionsActivity *questionsActivity = [[QuestionsActivity alloc] initWithNibName:@"QuestionsActivity" bundle:nil];
    [self setNextViewController:questionsActivity myImage:[UIImage imageNamed:@"next.png"]];
    
    
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
    if ( IDIOM == IPAD ) {
        profileOutlineWidth = 400;
        profileOutlineHeight = 40;
        NSLog(@"IPAD NI");
        //PERSONAL INFORMATION
       // fullNameO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Harry C. Lingad"];
        fullNameO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) word:@"Full Name"];
        fullNameO.layer.cornerRadius=8.0f;
        fullNameO.layer.masksToBounds=YES;
        fullNameO.layer.borderColor = [UIColor redColor].CGColor;
        fullNameO.layer.borderWidth = 1.0f;
        float fullNameO_Co = (screenWidth - profileOutlineWidth)/2;
        [fullNameO setFrame:CGRectMake(fullNameO_Co, 40, profileOutlineWidth, profileOutlineHeight)];

       // genderO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 100, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Male"];
        genderO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 100, profileOutlineWidth, profileOutlineHeight) word:@"Gender"];
        genderO.layer.cornerRadius=8.0f;
        genderO.layer.masksToBounds=YES;
        genderO.layer.borderColor = [UIColor redColor].CGColor;
        genderO.layer.borderWidth = 1.0f;
        float genderO_Co = (screenWidth - profileOutlineWidth)/2;
        [genderO setFrame:CGRectMake(genderO_Co, 100, profileOutlineWidth, profileOutlineHeight)];

      //  birthdateO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 160, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"November 1, 1122"];
        birthdateO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 160, profileOutlineWidth, profileOutlineHeight) word:@"Birthdate"];
        birthdateO.layer.cornerRadius=8.0f;
        birthdateO.layer.masksToBounds=YES;
        birthdateO.layer.borderColor = [UIColor redColor].CGColor;
        birthdateO.layer.borderWidth = 1.0f;
        float birthdateO_Co = (screenWidth - profileOutlineWidth)/2;
        [birthdateO setFrame:CGRectMake(birthdateO_Co, 160, profileOutlineWidth, profileOutlineHeight)];

        //nationalityO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 220, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Filipino"];
        nationalityO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 220, profileOutlineWidth, profileOutlineHeight) word:@"Nationality"];
        nationalityO.layer.cornerRadius=8.0f;
        nationalityO.layer.masksToBounds=YES;
        nationalityO.layer.borderColor = [UIColor redColor].CGColor;
        nationalityO.layer.borderWidth = 1.0f;
        float nationalityO_Co = (screenWidth - profileOutlineWidth)/2;
        [nationalityO setFrame:CGRectMake(nationalityO_Co, 220, profileOutlineWidth, profileOutlineHeight)];

       // workO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 280, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Programmer"];
        workO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 280, profileOutlineWidth, profileOutlineHeight) word:@"Nature of Work"];
        workO.layer.cornerRadius=8.0f;
        workO.layer.masksToBounds=YES;
        workO.layer.borderColor = [UIColor redColor].CGColor;
        workO.layer.borderWidth = 1.0f;
        float workO_Co = (screenWidth - profileOutlineWidth)/2;
        [workO setFrame:CGRectMake(workO_Co, 280, profileOutlineWidth, profileOutlineHeight)];
        
        //ADDING THE COMPONENTS

        [personalOutline addSubview:fullNameO];
        
        
        [personalOutline addSubview:genderO];

        
        [personalOutline addSubview:birthdateO];

        
        [personalOutline addSubview:ageO];

        
        [personalOutline addSubview:nationalityO];

        
        [personalOutline addSubview:workO];

        
        [personalOutline addSubview:personalHeader];
        [profileScroll addSubview:personalOutline];
        
        
        
        

    }
    else{
        NSLog(@"IPHONE NI");
        //PERSONAL INFORMATION
       // fullNameO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Harry C. Lingad"];
        fullNameO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) word:@"Full Name"];
        fullNameO.layer.cornerRadius=8.0f;
        fullNameO.layer.masksToBounds=YES;
        fullNameO.layer.borderColor = [UIColor redColor].CGColor;
        fullNameO.layer.borderWidth = 1.0f;

       // genderO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 90, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Male"];
        genderO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 90, profileOutlineWidth, profileOutlineHeight) word:@"Gender"];
        genderO.layer.cornerRadius=8.0f;
        genderO.layer.masksToBounds=YES;
        genderO.layer.borderColor = [UIColor redColor].CGColor;
        genderO.layer.borderWidth = 1.0f;
        //birthdateO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 140, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"November 1, 1122"];
        birthdateO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 140, profileOutlineWidth, profileOutlineHeight) word:@"Birthdate"];
        birthdateO.layer.cornerRadius=8.0f;
        birthdateO.layer.masksToBounds=YES;
        birthdateO.layer.borderColor = [UIColor redColor].CGColor;
        birthdateO.layer.borderWidth = 1.0f;

        //nationalityO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 190, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Filipino"];
        
        nationalityO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 190, profileOutlineWidth, profileOutlineHeight) word:@"Nationality"];
        nationalityO.layer.cornerRadius=8.0f;
        nationalityO.layer.masksToBounds=YES;
        nationalityO.layer.borderColor = [UIColor redColor].CGColor;
        nationalityO.layer.borderWidth = 1.0f;

       // workO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 240, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"Programmer"];
        workO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 240, profileOutlineWidth, profileOutlineHeight) word:@"Nature of Work"];
        workO.layer.cornerRadius=8.0f;
        workO.layer.masksToBounds=YES;
        workO.layer.borderColor = [UIColor redColor].CGColor;
        workO.layer.borderWidth = 1.0f;
        
        
        //ADDING THE COMPONENTS
        

        [personalOutline addSubview:fullNameO];
        
        
        [personalOutline addSubview:genderO];

        
        [personalOutline addSubview:birthdateO];

        
        [personalOutline addSubview:ageO];

        
        [personalOutline addSubview:nationalityO];

        
        [personalOutline addSubview:workO];

        
        [personalOutline addSubview:personalHeader];
        [profileScroll addSubview:personalOutline];
        
        
        
        

    }
    fullNameO.delegate = self;
    genderO.delegate = self;
    birthdateO.delegate = self;
    nationalityO.delegate = self;
    workO.delegate = self;
    
}

-(void) createLocationInfo{
    if ( IDIOM == IPAD ) {
        
        profileOutlineWidth = 400;
        profileOutlineHeight = 40;
        
        
        ProfileHeader *locationHeader = [[ProfileHeader alloc] initWithValue:@" Location Information" x:5 y:50 width:170];
        
        // ProfileOutline *locationOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, locationY, outlineWidth, 230)];
        
        UIView* locationOutline = [[UIView alloc] initWithFrame:CGRectMake(outlineX,locationY,outlineWidth,230)];

       // countryO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 100, profileOutlineWidth, profileOutlineHeight) color:[UIColor whiteColor] word:@"Philippines"];
        countryO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 100, profileOutlineWidth, profileOutlineHeight) word:@"Province"];
        countryO.layer.cornerRadius=8.0f;
        countryO.layer.masksToBounds=YES;
        countryO.layer.borderColor = [UIColor redColor].CGColor;
        countryO.layer.borderWidth = 1.0f;
        float countryO_Co = (screenWidth - profileOutlineWidth)/2;
        [countryO setFrame:CGRectMake(countryO_Co, 100, profileOutlineWidth, profileOutlineHeight)];

       // provinceO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 160, profileOutlineWidth, profileOutlineHeight) color:[UIColor whiteColor] word:@"Lanao del Norte"];
        provinceO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 160, profileOutlineWidth, profileOutlineHeight) word:@"Province"];
        provinceO.layer.cornerRadius=8.0f;
        provinceO.layer.masksToBounds=YES;
        provinceO.layer.borderColor = [UIColor redColor].CGColor;
        provinceO.layer.borderWidth = 1.0f;
        float provinceO_Co = (screenWidth - profileOutlineWidth)/2;
        [provinceO setFrame:CGRectMake(provinceO_Co, 160, profileOutlineWidth, profileOutlineHeight)];

       // addressO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 220, profileOutlineWidth, profileOutlineHeight) color:[UIColor whiteColor] word:@"Mabolo, Cebu City"];
        addressO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 220, profileOutlineWidth, profileOutlineHeight) word:@"Permanent Address"];
        addressO.layer.cornerRadius=8.0f;
        addressO.layer.masksToBounds=YES;
        addressO.layer.borderColor = [UIColor redColor].CGColor;
        addressO.layer.borderWidth = 1.0f;
        float addressO_Co = (screenWidth - profileOutlineWidth)/2;
        [addressO setFrame:CGRectMake(addressO_Co, 220, profileOutlineWidth, profileOutlineHeight)];
        

       // zipcodeO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 280, profileOutlineWidth, profileOutlineHeight) color:[UIColor redColor] word:@"6000"];
        zipcodeO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 280, profileOutlineWidth, profileOutlineHeight) word:@"Zipcode"];
        zipcodeO.layer.cornerRadius=8.0f;
        zipcodeO.layer.masksToBounds=YES;
        zipcodeO.layer.borderColor = [UIColor redColor].CGColor;
        zipcodeO.layer.borderWidth = 1.0f;
        float zipcodeO_Co = (screenWidth - profileOutlineWidth)/2;
        [zipcodeO setFrame:CGRectMake(zipcodeO_Co, 280, profileOutlineWidth, profileOutlineHeight)];
        
        
        [locationOutline addSubview:countryO];

        
        [locationOutline addSubview:provinceO];

        
        [locationOutline addSubview:addressO];

        
        [locationOutline addSubview:zipcodeO];

        
        
        [locationOutline addSubview:locationHeader];
        [profileScroll addSubview:locationOutline];

    }
    else{
        
        ProfileHeader *locationHeader = [[ProfileHeader alloc] initWithValue:@" Location Information" x:5 y:-10 width:170];
        
        // ProfileOutline *locationOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, locationY, outlineWidth, 230)];
        
        UIView* locationOutline = [[UIView alloc] initWithFrame:CGRectMake(outlineX,locationY,outlineWidth,230)];

        //countryO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) color:[UIColor whiteColor] word:@"Philippines"];
        
        countryO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) word:@"Country"];
        countryO.layer.cornerRadius=8.0f;
        countryO.layer.masksToBounds=YES;
        countryO.layer.borderColor = [UIColor redColor].CGColor;
        countryO.layer.borderWidth = 1.0f;

     //   provinceO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 90, profileOutlineWidth, profileOutlineHeight) color:[UIColor whiteColor] word:@"Lanao del Norte"];
        provinceO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 90, profileOutlineWidth, profileOutlineHeight) word:@"Province"];
        provinceO.layer.cornerRadius=8.0f;
        provinceO.layer.masksToBounds=YES;
        provinceO.layer.borderColor = [UIColor redColor].CGColor;
        provinceO.layer.borderWidth = 1.0f;

       // addressO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 140, profileOutlineWidth, profileOutlineHeight) color:[UIColor whiteColor] word:@"Mabolo, Cebu City"];
        addressO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 140, profileOutlineWidth, profileOutlineHeight) word:@"Permanent Address"];
        
        addressO.layer.cornerRadius=8.0f;
        addressO.layer.masksToBounds=YES;
        addressO.layer.borderColor = [UIColor redColor].CGColor;
        addressO.layer.borderWidth = 1.0f;

        //zipcodeO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 190, profileOutlineWidth, profileOutlineHeight) color:[UIColor redColor] word:@"6000"];
        zipcodeO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 190, profileOutlineWidth, profileOutlineHeight) word:@"Zipcode"];
        zipcodeO.layer.cornerRadius=8.0f;
        zipcodeO.layer.masksToBounds=YES;
        zipcodeO.layer.borderColor = [UIColor redColor].CGColor;
        zipcodeO.layer.borderWidth = 1.0f;
        
        
        [locationOutline addSubview:countryO];

        
        [locationOutline addSubview:provinceO];

        
        [locationOutline addSubview:addressO];
 
        
        [locationOutline addSubview:zipcodeO];

        
        
        [locationOutline addSubview:locationHeader];
        [profileScroll addSubview:locationOutline];

    }
    
    countryO.delegate = self;
    provinceO.delegate = self;
    addressO.delegate = self;
    zipcodeO.delegate = self;
}

-(void) createContactInfo{
    if ( IDIOM == IPAD ) {
        profileOutlineWidth = 400;
        profileOutlineHeight = 40;
        ProfileHeader *contactHeader = [[ProfileHeader alloc] initWithValue:@" Contact Information" x:5 y:90 width:170];
        
        //ProfileOutline *contactOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, contactY, outlineWidth, 130)];
        
        UIView* contactOutline = [[UIView alloc] initWithFrame:CGRectMake(outlineX,contactY,outlineWidth,290)];

       // emailO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 140, profileOutlineWidth, profileOutlineHeight) color:[UIColor lightGrayColor] word:@"harry@yahoo.com"];
        emailO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 140, profileOutlineWidth, profileOutlineHeight) word:@"Email Address"];
        emailO.layer.borderColor = [UIColor redColor].CGColor;
        emailO.layer.borderWidth = 1.0f;
        float emailO_Co = (screenWidth - profileOutlineWidth)/2;
        [emailO setFrame:CGRectMake(emailO_Co, 140, profileOutlineWidth, profileOutlineHeight)];

       // mobileNumberO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 200, profileOutlineWidth, profileOutlineHeight) color:[UIColor whiteColor] word:@"09273444456"];
        mobileNumberO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 200, profileOutlineWidth, profileOutlineHeight) word:@"Mobile Number"];
        mobileNumberO.layer.cornerRadius=8.0f;
        mobileNumberO.layer.masksToBounds=YES;
        mobileNumberO.layer.borderColor = [UIColor redColor].CGColor;
        mobileNumberO.layer.borderWidth = 1.0f;
        float mobileNumberO_Co = (screenWidth - profileOutlineWidth)/2;
        [mobileNumberO setFrame:CGRectMake(mobileNumberO_Co, 200, profileOutlineWidth, profileOutlineHeight)];

        
        
        
        [contactOutline addSubview:emailO];
        [contactOutline addSubview:mobileNumberO];
        
        
        
        
        
        
        
        [contactOutline addSubview:contactHeader];
        
        [profileScroll addSubview:contactOutline];
    }
    else {
        ProfileHeader *contactHeader = [[ProfileHeader alloc] initWithValue:@" Contact Information" x:5 y:-10 width:170];
        
        //ProfileOutline *contactOutline = [[ProfileOutline alloc] initWithFrame:CGRectMake(outlineX, contactY, outlineWidth, 130)];
        
        UIView* contactOutline = [[UIView alloc] initWithFrame:CGRectMake(outlineX,contactY,outlineWidth,130)];

       // emailO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) color:[UIColor whiteColor] word:@"harry@yahoo.com"];
        emailO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 40, profileOutlineWidth, profileOutlineHeight) word:@"Email Address"];
        emailO.layer.cornerRadius=8.0f;
        emailO.layer.masksToBounds=YES;
        emailO.layer.borderColor = [UIColor redColor].CGColor;
        emailO.layer.borderWidth = 1.0f;

      //  mobileNumberO = [[ProfileOutline alloc] initWithFrame:CGRectMake(labelX, 90, profileOutlineWidth, profileOutlineHeight) color:[UIColor whiteColor] word:@"09273444456"];
        mobileNumberO = [[ProfileTextField alloc] initWithFrame:CGRectMake(labelX, 90, profileOutlineWidth, profileOutlineHeight) word:@"Mobile Number"];
        mobileNumberO.layer.cornerRadius=8.0f;
        mobileNumberO.layer.masksToBounds=YES;
        mobileNumberO.layer.borderColor = [UIColor redColor].CGColor;
        mobileNumberO.layer.borderWidth = 1.0f;
        
        
        
        
        [contactOutline addSubview:emailO];
        [contactOutline addSubview:mobileNumberO];
        
        
        
        
        
        
        
        [contactOutline addSubview:contactHeader];
        
        [profileScroll addSubview:contactOutline];
    }
    emailO.delegate = self;
    mobileNumberO.delegate = self;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textAnimate animateTextField:textField up:YES SelfView:self.view];
    //CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y);
    //[scrollView setContentOffset:scrollPoint animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // [scrollView setContentOffset:CGPointZero animated:YES];
    [textAnimate animateTextField:textField up:NO SelfView:self.view];
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [countryO resignFirstResponder];
    [provinceO resignFirstResponder];
    [addressO resignFirstResponder];
    [zipcodeO resignFirstResponder];
    [emailO resignFirstResponder];
    [mobileNumberO resignFirstResponder];
    [fullNameO resignFirstResponder];

    [genderO resignFirstResponder];
    [birthdateO resignFirstResponder];
    [nationalityO resignFirstResponder];
    [workO resignFirstResponder];
    
    return NO;
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
