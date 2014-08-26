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
#import "EditInformation.h"
#import "NSDictionary+LoadWalletData.h"

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

UIImageView *profileImage;

NSDictionary *loadData;

QuestionVerificationDialog *dialog;

NSString *correctAnswer;

UIImageView *userImage, *image1, *image2, *image3, *image4;

UILabel *profileEmail, *profileName, *profilePhone;

//DECLARE VARIABLES

UIScrollView *profileScroll;



ProfileOutline *firstNameO, *middleNameO, *lastNameO, *countryO, *provinceO, *addressO, *zipcodeO, *genderO, *birthdateO, *ageO, *mobileNumberO, *emailO, *workO, *nationalityO;

NSString *firstNameValue, *middleNameValue, *lastNameValue, *countryValue, *provinceValue, *addressValue, *zipcodeValue, *genderValue, *birthdateValue, *ageValue, *mobileNumberValue, *emailValue, *workValue, *nationalityValue, *photo1Value, *photo2Value, *photo3Value, *photo4Value, *answer1, *answer2, *answer3, *question1, *question2, *question3;

UILabel *firstName, *middleName, *lastName, *country, *province, *address, *zipcode, *gender, *birthdate, *age, *mobileNumber, *email, *work, *nationality;


- (void)viewDidLoad
{
    [super viewDidLoad];

    profileScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [profileScroll setScrollEnabled:YES];
    [profileScroll setContentSize:CGSizeMake(320, 600)];
    
    loadData = [NSDictionary initRead_LoadWallet_Data];
    [self loadFromPlaylist];
    
    [self createImageInfo];
    [self createPersonalLabel];
    [self createPersonalValue];
    
    [self setInfo];
    
    [self.view addSubview:profileScroll];
    [self.view addSubview:dialog];
    
    [self addNavigationBarButton];
    
    
}


-(void) loadFromPlaylist{
    
    firstNameValue = [loadData objectForKey:@"fname"];
    middleNameValue = [loadData objectForKey:@"mname"];
    lastNameValue = [loadData objectForKey:@"lname"];
    countryValue =[loadData objectForKey:@"country"];
    provinceValue =[loadData objectForKey:@"provinceCity"];
    addressValue =[loadData objectForKey:@"permanentAdd"];
    zipcodeValue =[loadData objectForKey:@"zipcode"];
    genderValue =[loadData objectForKey:@"gender"];
    birthdateValue =[loadData objectForKey:@"bdate"];
    ageValue =[loadData objectForKey:@"age"];
    mobileNumberValue =[loadData objectForKey:@"mobileno"];
    
    emailValue =[loadData objectForKey:@"emailadd"];
    workValue =[loadData objectForKey:@"natureOfWork"];
    nationalityValue =[loadData objectForKey:@"nationality"];
    
    photo1Value =[loadData objectForKey:@"photo1"];
    photo2Value =[loadData objectForKey:@"photo2"];
    photo3Value =[loadData objectForKey:@"photo3"];
    photo4Value =[loadData objectForKey:@"photo4"];
    
    
    question1 =[loadData objectForKey:@"secquestion1"];
    question2 =[loadData objectForKey:@"secquestion2"];
    question3 =[loadData objectForKey:@"secquestion3"];
    answer1 =[loadData objectForKey:@"secanswer1"];
    answer2 =[loadData objectForKey:@"secanswer2"];
    answer3 =[loadData objectForKey:@"secanswer3"];

    
}

#pragma mark - CREATE UI

-(void) createImageInfo{
    
    
    profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    
    profileName = [[UILabel alloc] initWithFrame:CGRectMake(130, 40, 300, 25)];
    [profileName setFont:[UIFont fontWithName:nil size:15.0f]];
    
    profilePhone = [[UILabel alloc] initWithFrame:CGRectMake(130, 60, 300, 25)];
    [profilePhone setFont:[UIFont fontWithName:nil size:13.0f]];
    
    
    
    
    
    
    
    
    
    ProfileOutline *imageCollectionView = [[ProfileOutline alloc] initWithFrame:CGRectMake(15, 150, 290, 74)];
    
    image1 = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 70, 70)];
    
    image2 = [[UIImageView alloc] initWithFrame:CGRectMake(74, 2, 70, 70)];
    
    image3 = [[UIImageView alloc] initWithFrame:CGRectMake(146, 2, 70, 70)];
    
    image4 = [[UIImageView alloc] initWithFrame:CGRectMake(218, 2, 70, 70)];
    
    
    [imageCollectionView addSubview:image1];
    [imageCollectionView addSubview:image2];
    [imageCollectionView addSubview:image3];
    [imageCollectionView addSubview:image4];

    [profileScroll addSubview:profileImage];
    [profileScroll addSubview:profileName];
    [profileScroll addSubview:profilePhone];
    
    
    [profileScroll addSubview:imageCollectionView];
    
    
}

-(void) createPersonalLabel{
    
    
    UILabel *accountInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 180, 25)];
    [accountInfoLabel setFont:[UIFont fontWithName:nil size:20.0f]];
    [accountInfoLabel setTextAlignment:NSTextAlignmentCenter];
    [accountInfoLabel setTextColor:[UIColor redColor]];
    [accountInfoLabel setText:@"Profile Information"];
    
    
    //ProfileInformationLabel
    
    UILabel *profileFirstName = [[UILabel alloc] initWithFrame:CGRectMake(20, 265, 100, 25)];
    [profileFirstName setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileFirstName setTextColor:[UIColor grayColor]];
    [profileFirstName setText:@"First Name: "];
    
    UILabel *profileMiddleName = [[UILabel alloc] initWithFrame:CGRectMake(20, 285, 100, 25)];
    [profileMiddleName setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileMiddleName setTextColor:[UIColor grayColor]];
    [profileMiddleName setText:@"Middle Name: "];
    
    UILabel *profileLastName = [[UILabel alloc] initWithFrame:CGRectMake(20, 305, 100, 25)];
    [profileLastName setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileLastName setTextColor:[UIColor grayColor]];
    [profileLastName setText:@"Last Name: "];
    
    UILabel *profileCountry = [[UILabel alloc] initWithFrame:CGRectMake(20, 325, 100, 25)];
    [profileCountry setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileCountry setTextColor:[UIColor grayColor]];
    [profileCountry setText:@"Country: "];
    
    UILabel *profileProvince = [[UILabel alloc] initWithFrame:CGRectMake(20, 345, 100, 25)];
    [profileProvince setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileProvince setTextColor:[UIColor grayColor]];
    [profileProvince setText:@"Province: "];
    
    UILabel *profileAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, 365, 100, 25)];
    [profileAddress setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileAddress setTextColor:[UIColor grayColor]];
    [profileAddress setText:@"Address: "];
    
    UILabel *profileZipcode = [[UILabel alloc] initWithFrame:CGRectMake(20, 385, 100, 25)];
    [profileZipcode setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileZipcode setTextColor:[UIColor grayColor]];
    [profileZipcode setText:@"Zipcode: "];
    
    UILabel *profileGender = [[UILabel alloc] initWithFrame:CGRectMake(20, 405, 100, 25)];
    [profileGender setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileGender setTextColor:[UIColor grayColor]];
    [profileGender setText:@"Gender: "];
    
    UILabel *profileBirthdate = [[UILabel alloc] initWithFrame:CGRectMake(20, 425, 100, 25)];
    [profileBirthdate setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileBirthdate setTextColor:[UIColor grayColor]];
    [profileBirthdate setText:@"Birthdate: "];
    
    UILabel *profileAge = [[UILabel alloc] initWithFrame:CGRectMake(20, 445, 100, 25)];
    [profileAge setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileAge setTextColor:[UIColor grayColor]];
    [profileAge setText:@"Age: "];
    
    UILabel *profileNumber = [[UILabel alloc] initWithFrame:CGRectMake(20, 465, 100, 25)];
    [profileNumber setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileNumber setTextColor:[UIColor grayColor]];
    [profileNumber setText:@"Mobile Number: "];
    
    UILabel *profileEmail = [[UILabel alloc] initWithFrame:CGRectMake(20, 485, 100, 25)];
    [profileEmail setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileEmail setTextColor:[UIColor grayColor]];
    [profileEmail setText:@"Email Address: "];
    
    UILabel *profileWork = [[UILabel alloc] initWithFrame:CGRectMake(20, 505, 100, 25)];
    [profileWork setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileWork setTextColor:[UIColor grayColor]];
    [profileWork setText:@"Nature of Work: "];
    
    UILabel *profileNationality = [[UILabel alloc] initWithFrame:CGRectMake(20, 525, 100, 25)];
    [profileNationality setFont:[UIFont fontWithName:nil size:13.0f]];
    [profileNationality setTextColor:[UIColor grayColor]];
    [profileNationality setText:@"Nationality: "];
    
    
    [profileScroll addSubview:accountInfoLabel];
    
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

-(void) createPersonalValue{

    
    //ProfileInformationLabel
    
    firstName = [[UILabel alloc] initWithFrame:CGRectMake(130, 265, 180, 25)];
    [firstName setFont:[UIFont fontWithName:nil size:13.0f]];
    
    middleName = [[UILabel alloc] initWithFrame:CGRectMake(130, 285, 180, 25)];
    [middleName setFont:[UIFont fontWithName:nil size:13.0f]];
    
    lastName = [[UILabel alloc] initWithFrame:CGRectMake(130, 305, 180, 25)];
    [lastName setFont:[UIFont fontWithName:nil size:13.0f]];
    
    country = [[UILabel alloc] initWithFrame:CGRectMake(130, 325, 180, 25)];
    [country setFont:[UIFont fontWithName:nil size:13.0f]];
    
    province = [[UILabel alloc] initWithFrame:CGRectMake(130, 345, 180, 25)];
    [province setFont:[UIFont fontWithName:nil size:13.0f]];
    
    address = [[UILabel alloc] initWithFrame:CGRectMake(130, 365, 180, 25)];
    [address setFont:[UIFont fontWithName:nil size:13.0f]];
    
    zipcode = [[UILabel alloc] initWithFrame:CGRectMake(130, 385, 180, 25)];
    [zipcode setFont:[UIFont fontWithName:nil size:13.0f]];
    
    gender = [[UILabel alloc] initWithFrame:CGRectMake(130, 405, 180, 25)];
    [gender setFont:[UIFont fontWithName:nil size:13.0f]];
    
    birthdate = [[UILabel alloc] initWithFrame:CGRectMake(130, 425, 180, 25)];
    [birthdate setFont:[UIFont fontWithName:nil size:13.0f]];
    
    age = [[UILabel alloc] initWithFrame:CGRectMake(130, 445, 180, 25)];
    [age setFont:[UIFont fontWithName:nil size:13.0f]];
    
    mobileNumber = [[UILabel alloc] initWithFrame:CGRectMake(130, 465, 180, 25)];
    [mobileNumber setFont:[UIFont fontWithName:nil size:13.0f]];
    
   
    
    work = [[UILabel alloc] initWithFrame:CGRectMake(130, 505, 180, 25)];
    [work setFont:[UIFont fontWithName:nil size:13.0f]];
    
    nationality = [[UILabel alloc] initWithFrame:CGRectMake(130, 525, 180, 25)];
    [nationality setFont:[UIFont fontWithName:nil size:13.0f]];
    
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
    [profileScroll addSubview:mobileNumber];
    [profileScroll addSubview:work];
    [profileScroll addSubview:nationality];
    
    
    
}

-(void) setInfo{
    [firstName setText:firstNameValue];
    [middleName setText:middleNameValue];
    [lastName setText:lastNameValue];
    [country setText:countryValue];
    [province setText:provinceValue];
    [address setText:addressValue];
    [zipcode setText:zipcodeValue];
    [gender setText:genderValue];
    
    //FORMAT DATE====================================================
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *date = [dateFormatter dateFromString:birthdateValue];
//    [dateFormatter setDateFormat:@"MMM. dd, yyyy"];
//    NSString *finalDateString = [dateFormatter stringFromDate:date];
    //End Format Date===============================================
    
    [birthdate setText:birthdateValue];
    [age setText:ageValue];
    [mobileNumber setText:mobileNumberValue];
    [work setText:workValue];
    [nationality setText:nationalityValue];
    
    
    
    
    //CONVERTING STRING INTO IMAGE=================================================
    NSData *data = [[NSData alloc]initWithBase64EncodedString:photo1Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    
    UIImage *userProfileImage = [UIImage imageWithData:data];
    if (userProfileImage == nil)
    {
        [profileImage setImage:[UIImage imageNamed:@"noImage.png"]];
    }
    else
    {
        [profileImage setImage:userProfileImage];
    }
    
    
    
    NSData *data1 = [[NSData alloc]initWithBase64EncodedString:photo1Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    
    UIImage *userImage1 = [UIImage imageWithData:data1];
    if (userImage1 == nil)
    {
        [image1 setImage:[UIImage imageNamed:@"noImage.png"]];
    }
    else
    {
        [image1 setImage:userImage1];

    }

    
    
    
    NSData *data2 = [[NSData alloc]initWithBase64EncodedString:photo2Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *userImage2 = [UIImage imageWithData:data2];
    if (userImage2 == nil)
    {
        [image2 setImage:[UIImage imageNamed:@"noImage.png"]];
    }
    else
    {
        [image2 setImage:userImage2];
        
    }
    
    
    NSData *data3 = [[NSData alloc]initWithBase64EncodedString:photo3Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
   
    UIImage *userImage3 = [UIImage imageWithData:data3];
    if (userImage3 == nil)
    {
        [image3 setImage:[UIImage imageNamed:@"noImage.png"]];
    }
    else
    {
        [image3 setImage:userImage3];
        
    }
    
    
    NSData *data4 = [[NSData alloc]initWithBase64EncodedString:photo4Value options:NSDataBase64DecodingIgnoreUnknownCharacters];
   
    UIImage *userImage4 = [UIImage imageWithData:data4];
    if (userImage4 == nil)
    {
        [image4 setImage:[UIImage imageNamed:@"noImage.png"]];
    }
    else
    {
        [image4 setImage:userImage4];
        
    }
    
    //================================================================================
    
    dialog = [[QuestionVerificationDialog alloc] initWithFrame:CGRectMake(0, 0, 768, 1120) addTarget:self action:@selector(goToEdit:) forControlEvents:UIControlEventTouchUpInside addQuestion1:question1 addQuestion2:question2 addQuestion3:question3];
    
    [dialog setHidden:YES];

    [profileName setText:[NSString stringWithFormat:@"%@ %@. %@",firstNameValue, middleNameValue, lastNameValue]];
    [profilePhone setText:mobileNumberValue];
    [profileEmail setText:emailValue];
    
}




-(void) viewWillAppear:(BOOL)animated{
 
    NSDictionary *loadEmail = [NSDictionary initRead_LoadWallet_Data];
    
    NSString *emailAgain = [loadEmail objectForKey:@"emailadd"];
    
    email = [[UILabel alloc] initWithFrame:CGRectMake(130, 485, 180, 25)];
    [email setFont:[UIFont fontWithName:nil size:13.0f]];
    
    profileEmail = [[UILabel alloc] initWithFrame:CGRectMake(130, 76, 300, 25)];
    [profileEmail setFont:[UIFont fontWithName:nil size:13.0f]];
    
    [email setText:emailAgain];
    [profileEmail setText:emailAgain];
    
    
    [profileScroll addSubview:email];
    [profileScroll addSubview:profileEmail];
    
    if(![dialog isHidden])
    {
        [dialog setHidden:YES];
    }

}

-(void) viewDidDisappear:(BOOL)animated{
    [email removeFromSuperview];
    [profileEmail removeFromSuperview];
}


#pragma OTHER METHODS

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) goToEdit:(id)sender{

    
    if(dialog.finalQuestion == question1)
    {
        correctAnswer = answer1;
    }
    else if(dialog.finalQuestion == question2)
    {
        correctAnswer = answer2;
    }
    else
    {
        correctAnswer = answer3;
    }
    
    NSString *usersAnswer = dialog.answer.text;
    
    if([usersAnswer isEqualToString:correctAnswer])
    {
        
        EditInformation *editInformation = [[EditInformation alloc] initWithNibName:@"EditInformation" bundle:nil];
        [self fadeInAnimation:dialog];
        [self.navigationController pushViewController:editInformation animated:YES];
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Secret question" message:@"Sorry! Your answer is wrong." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alertView show];
    }
    

    
    
}













-(void)editPressed:(id)sender{
    
    [dialog setHidden:!dialog.hidden];
    
    [self fadeInAnimation:dialog];
    
}

-(void) addNavigationBarButton{
    
    
    
    self.title = @"My Profile";
    
    //RIGHT NAVIGATION BUTTON
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
//    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
//    [backButton setImage:[UIImage imageNamed:@"back_profile.png"] forState:UIControlStateNormal];
//      [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [backView addSubview:backButton];
    
    
//    UIBarButtonItem *backNavButton = [[UIBarButtonItem alloc] initWithCustomView:backView];
//    [backNavButton setStyle:UIBarButtonItemStyleBordered];


    //RIGHT NAVIGATION BUTTON
    UIView *editView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
   [editButton setImage:[UIImage imageNamed:@"my_edit.png"] forState:UIControlStateNormal];
    
  //[editButton setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [editView addSubview:editButton];
    
    UIBarButtonItem *editNavButton = [[UIBarButtonItem alloc] initWithCustomView:editView];
    [editNavButton setStyle:UIBarButtonItemStyleBordered];
    [editNavButton setTarget:self];
    [editNavButton setAction:@selector(editPressed:)];
    

    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];//    [self.navigationItem setLeftBarButtonItem:backNavButton];
    [self.navigationItem setRightBarButtonItem:editNavButton];
    
}

-(void)backPressed:(id)sender{

    [self.navigationController  popViewControllerAnimated:YES];

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




- (BOOL)prefersStatusBarHidden{
    return YES;
}






@end
